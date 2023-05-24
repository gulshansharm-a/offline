import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;
import 'package:offline_classes/global_data/student_global_data.dart';
import 'package:offline_classes/utils/my_appbar.dart';
import 'package:offline_classes/widget/custom_textfield.dart';
import 'package:offline_classes/widget/image_opener.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';

import '../../../global_data/GlobalData.dart';
import '../../../utils/constants.dart';
import '../../../widget/custom_button.dart';
import '../../enquiry_registrations/error_screen.dart';

class StudentProfileEdit extends StatefulWidget {
  const StudentProfileEdit({super.key});

  @override
  State<StudentProfileEdit> createState() => _StudentProfileEditState();
}

class _StudentProfileEditState extends State<StudentProfileEdit> {
  TextEditingController datofBirthControler = TextEditingController();
  TextEditingController tfname = TextEditingController();
  TextEditingController tfschool = TextEditingController();
  TextEditingController tfclass = TextEditingController();
  TextEditingController tfsubject = TextEditingController();

  bool showSpinner = false;

  @override
  initState() {
    datofBirthControler.text = GlobalStudent.specificProfile["data"][0]["dob"];
    tfname.text = GlobalStudent.specificProfile["data"][0]["name"];
    tfclass.text = GlobalStudent.specificProfile["data"][0]["class"];
    tfschool.text = GlobalStudent.specificProfile["data"][0]["school_name"];
    tfsubject.text = GlobalStudent.specificProfile["data"][0]["subject"];
    super.initState();
  }

  Future<File> convertImageUrlToFile(String imageUrl) async {
    var response = await http.get(Uri.parse(imageUrl));
    var filePath =
        await _localPath(); // Function to get the local directory path
    var fileName = imageUrl.split('/').last;

    File file = File('$filePath/$fileName');
    await file.writeAsBytes(response.bodyBytes);

    return file;
  }

  Future<String> _localPath() async {
    // Function to get the local directory path
    var directory = await getTemporaryDirectory();
    return directory.path;
  }

  Future<void> postData() async {
    setState(() {
      showSpinner = true;
    });

    var uri = Uri.parse("https://trusher.shellcode.co.in/api/editStudent?");

    var request = http.MultipartRequest('POST', uri);

    request.fields['authKey'] = GlobalData.auth1;
    request.fields['student_name'] = tfname.text.toString().trim();
    request.fields['dob'] = datofBirthControler.text.toString().trim();
    request.fields['school_name'] = tfschool.text.trim();
    request.fields['class'] = tfclass.text;
    request.fields['user_id'] = GlobalStudent.id.toString();
    request.fields['subject'] = tfsubject.text;

    var multiPart;

    if (image != null) {
      var stream = http.ByteStream(image!.openRead());
      stream.cast();
      var len = await image!.length();
      multiPart = http.MultipartFile(
        'image',
        () async* {
          yield* image!.openRead();
        }(),
        len,
        filename: image!.path,
      );
      request.files.add(multiPart);
    } else {
      try {
        var imageUrl = GlobalStudent.urlPrefix +
            GlobalStudent.specificProfile["data"][0]["image"];
        File imageFile = await convertImageUrlToFile(imageUrl);
        request.files.add(http.MultipartFile(
          'image',
          imageFile.readAsBytes().asStream(),
          imageFile.lengthSync(),
          filename: imageFile.path.split('/').last,
          contentType: MediaType('image',
              'jpeg'), // Adjust the content type as per your image type
        ));
      } catch (e) {
        print(e);
      }
    }

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        var httpResponse = await http.Response.fromStream(response);
        var jsonResponse = json.decode(httpResponse.body);
        String msg = jsonResponse["message"].toString();
        if (msg == "Registrtion successfull") {
          setState(() {
            showSpinner = false;
          });
        } else {
          setState(() {
            showSpinner = false;
          });
          nextScreen(context, ErrorScreen(message: msg));
        }
      } else {
        setState(() {
          showSpinner = false;
        });
        Get.snackbar("Error", "Try again");
        print('API request failed with status code ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar("Error", "Try again");
      setState(() {
        showSpinner = false;
      });
      print('API request failed with exception: $e');
    }
    setState(() {
      showSpinner = false;
    });
  }

  File? image;
  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            backgroundColor: white,
            foregroundColor: black,
            elevation: 0,
            leading: Container(
              margin: EdgeInsets.all(3),
              padding: EdgeInsets.symmetric(horizontal: 8),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                gradient: orangeGradient(),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Center(
                child: IconButton(
                    onPressed: () {
                      goBack(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: white,
                    )),
              ),
            ),
            title: Text(
              "Edit",
              style: kBodyText20wBold(primary),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                addVerticalSpace(20),
                Center(
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    child: GestureDetector(
                      onTap: () async {
                        final pickedFile = await picker.pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 80,
                        );

                        if (pickedFile != null) {
                          image = File(pickedFile.path);
                          Get.snackbar(
                              "Success", "Image Selected Successfully");
                        } else {
                          Get.snackbar("Error", "Image Not Uploaded");
                          print("No image selected");
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.w),
                        child: Image.network(
                          "${GlobalStudent.urlPrefix}${GlobalStudent.specificProfile["data"][0]["image"]}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                addVerticalSpace(20),
                CustomTextfield(
                  hintext: 'Name',
                  controller: tfname,
                ),
                addVerticalSpace(20),
                CustomTextfield(
                  hintext: 'DOB',
                  controller: datofBirthControler,
                  onTap: () {
                    pickDate();
                  },
                  sufixIcon: Icons.calendar_month,
                ),
                addVerticalSpace(20),
                CustomTextfield(
                  hintext: 'School',
                  controller: tfschool,
                ),
                addVerticalSpace(20),
                CustomTextfield(
                  hintext: 'Class',
                  controller: tfclass,
                  keyBoardType: TextInputType.number,
                ),
                addVerticalSpace(20),
                CustomTextfield(
                  hintext: 'Class',
                  controller: tfsubject,
                ),
                addVerticalSpace(40),
                CustomButton(
                  text: 'Done',
                  onTap: () {
                    postData();
                  },
                ),
                addVerticalSpace(40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  pickDate() async {
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1947),
        lastDate: DateTime.now());
    if (pickedDate != null) {
      print(pickedDate);
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);

      setState(() {
        datofBirthControler.text = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }
}