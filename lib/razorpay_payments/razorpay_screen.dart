import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:offline_classes/global_data/GlobalData.dart';
import 'package:offline_classes/utils/constants.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import '../Views/enquiry_registrations/registration_successfull.dart';
import 'razor_credentials.dart' as razorCredentials;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class RazorpayScreen extends StatefulWidget {
  final double amount;
  const RazorpayScreen({super.key, required this.amount});

  @override
  State<RazorpayScreen> createState() => _RazorpayScreenState();
}

class _RazorpayScreenState extends State<RazorpayScreen> {
  final Razorpay _razorpay = Razorpay();

  double amt = 1.0;

  @override
  void initState() {
    // amt = widget.amount;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    });
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print(response);
    print("success");
    verifySignature(
      signature: response.signature,
      paymentId: response.paymentId,
      orderId: response.orderId,
    );
    nextScreen(
        context,
        RegistrationSuccessfull(
          whoareYou: 'Student',
        ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print(response);
    // Do something when payment fails
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.message ?? 'Error Occured'),
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print(response);
    // Do something when an external wallet is selected
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.walletName ?? 'External wallet selected'),
      ),
    );
  }

// create order
  void createOrder() async {
    String username = razorCredentials.keyId;
    String password = razorCredentials.keySecret;
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    Map<String, dynamic> body = {
      "amount": amt * 100,
      "currency": "INR",
      "receipt": "rcptid_11"
    };
    var res = await http.post(
      Uri.https(
          "api.razorpay.com", "v1/orders"), //https://api.razorpay.com/v1/orders
      headers: <String, String>{
        "Content-Type": "application/json",
        'authorization': basicAuth,
      },
      body: jsonEncode(body),
    );

    if (res.statusCode == 200) {
      openGateway(jsonDecode(res.body)['id']);
    }
    print(res.body);
  }

  openGateway(String orderId) {
    var options = {
      'key': razorCredentials.keyId,
      'amount': amt * 100, //in the smallest currency sub-unit.
      'name': 'Trusir',
      'order_id': orderId, // Generate order_id using Orders API
      'description': 'Payment',
      'timeout': 60 * 5, // in seconds // 5 minutes
      'prefill': {
        'contact': GlobalData.phoneNumber.substring(3),
        'email': emailTextEditingController.text.toString(),
      },
      'method': {
        'upi': {
          'vpa': '8577098983@paytm',
        },
      },
    };
    _razorpay.open(options);
  }

  verifySignature({
    String? signature,
    String? paymentId,
    String? orderId,
  }) async {
    Map<String, dynamic> body = {
      'razorpay_signature': signature,
      'razorpay_payment_id': paymentId,
      'razorpay_order_id': orderId,
    };

    var parts = [];
    body.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value)}');
    });
    var formData = parts.join('&');
    var res = await http.post(
      Uri.https(
        "10.0.2.2", // my ip address , localhost
        "razorpay_signature_verify.php",
      ),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded", // urlencoded
      },
      body: formData,
    );

    print(res.body);
    if (res.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.body),
        ),
      );
    }
  }

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }

  TextEditingController textEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: Text("Razorpay Payment Gateway"),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: textEditingController,
                  enabled: false,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: amt.toString(),
                    icon: const Icon(
                      Icons.monetization_on,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: nameTextEditingController,
                  decoration: const InputDecoration(
                    hintText: "Name",
                    icon: Icon(
                      Icons.monetization_on,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: emailTextEditingController,
                  decoration: const InputDecoration(
                    hintText: "Email",
                    icon: Icon(
                      Icons.monetization_on,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextButton(
                  onPressed: () {
                    String name =
                        nameTextEditingController.text.toString().trim();
                    String email =
                        emailTextEditingController.text.toString().trim();
                    if (name.isNotEmpty &&
                        name != "Name" &&
                        email.isNotEmpty &&
                        email.contains('@')) {
                      createOrder();
                    } else {
                      if (!email.contains('@')) {
                        Get.snackbar("Error", "Enter Valid Email");
                      } else {
                        Get.snackbar("Error", "Enter Values");
                      }
                    }
                  },
                  child: Text(
                    "Start Payment",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(backgroundColor: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
