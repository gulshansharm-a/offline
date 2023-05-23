import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:offline_classes/model/login_model.dart';

import '../model/check_register_model.dart';
import '../model/student_home_data_model.dart';

class GlobalData {
  static Map<String, dynamic> mapResponseStudetHome = {};
  static Map<String, dynamic> mapResponseLogin = {};
  static Map<String, dynamic> mapRegisterCheck = {};

  static String phoneNumber = "+917665512617";

  static String baseUrl = "https://trusher.shellcode.co.in/api";
  static String auth1 =
      "C4NX7IelyDl14flZGWcwDrhymzMnTcYV93dYtwfcVC1O7yabAT2Uexsd4ku7L9vlxd5nWrJDsPOfEfdDjfBGnl0ekg9droyLaPrn";

  static String role = "none";

  static String language = "English";

  updateLanguage(String lang) {
    language = lang;
  }

  updateRole(String roles) {
    role = roles;
  }

  static String registerCheck = "";

  Future<List<StudentHomeDataModel>> getInfoStudentHome(
      String apiurl, String authkey, String mobno) async {
    var apiUrl = apiurl;
    var authKey = authkey;
    // final http.Response response = await http.get(Uri.parse(
    //     "https://trusher.shellcode.co.in/api/studentHome?authKey=C4NX7IelyDl14flZGWcwDrhymzMnTcYV93dYtwfcVC1O7yabAT2Uexsd4ku7L9vlxd5nWrJDsPOfEfdDjfBGnl0ekg9droyLaPrn&mobile=917665512617"));
    final http.Response response = await http.get(Uri.parse(
        baseUrl + apiUrl + "?authKey=" + authKey + "&mobile=" + mobno));
    mapResponseStudetHome = json.decode(response.body);
    if (response.statusCode == 200) {
      print(mapResponseStudetHome);
      return [StudentHomeDataModel.fromJson(mapResponseStudetHome)];
    } else {
      return <StudentHomeDataModel>[];
    }
  }

  Future<List<CheckRegisterModel>> getRegisterData(
      String apiurl, String authkey, String mobno, String role) async {
    print("KKKKKKKKKK");
    print("I got it.");
    var apiUrl = apiurl;
    var authKey = authkey;
    // final http.Response response = await http.get(Uri.parse(
    //     "https://trusher.shellcode.co.in/api/studentHome?authKey=C4NX7IelyDl14flZGWcwDrhymzMnTcYV93dYtwfcVC1O7yabAT2Uexsd4ku7L9vlxd5nWrJDsPOfEfdDjfBGnl0ekg9droyLaPrn&mobile=917665512617"));
    var url = Uri.parse(
        'https://trusher.shellcode.co.in/api/registerCheck?mobile=${GlobalData.phoneNumber.substring(1)}&authKey=${GlobalData.auth1}&role=${GlobalData.role}');
    var res = await http.get(url);
    print("Happening");
    print("Doing");
    mapRegisterCheck = json.decode(res.body.toString());
    if (res.statusCode == 200) {
      print(mapRegisterCheck);
      if (res.body.isNotEmpty) {
        mapRegisterCheck = json.decode(res.body);
        registerCheck = mapRegisterCheck["Message"];
        print(registerCheck);
      } else {
        registerCheck = "$role not Registerd";
      }
      return [CheckRegisterModel.fromJson(mapResponseStudetHome)];
    } else {
      return <CheckRegisterModel>[];
    }
  }

  updatePhoneNumber(String phno) {
    phoneNumber = phno;
  }

  Future<List<LoginModel>> getInfoLogin(
      String apiurl, String authkey, String mobno) async {
    var apiUrl = apiurl;
    var authKey = authkey;
    // final http.Response response = await http.get(Uri.parse(
    // "https://trusher.shellcode.co.in/api/login?authKey=C4NX7IelyDl14flZGWcwDrhymzMnTcYV93dYtwfcVC1O7yabAT2Uexsd4ku7L9vlxd5nWrJDsPOfEfdDjfBGnl0ekg9droyLaPrn&mobile=918577098983"));
    final http.Response response = await http.get(Uri.parse(
        baseUrl + apiUrl + "?authKey=" + authKey + "&mobile=" + mobno));
    mapResponseLogin = json.decode(response.body.toString());
    updateRole(mapResponseLogin["logindata"][0]["role"]);
    var url = Uri.parse(
        'https://trusher.shellcode.co.in/api/registerCheck?mobile=${GlobalData.phoneNumber.substring(1)}&authKey=${GlobalData.auth1}&role=${GlobalData.role}');
    var res = await http.get(url);
    if (response.statusCode == 200) {
      print(mapResponseLogin);
      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          mapRegisterCheck = json.decode(res.body);
          var registerCheck = mapRegisterCheck["Message"];
          print(registerCheck);
        }
      } else {
        registerCheck = "$role not Registerd";
      }
      return [LoginModel.fromJson(mapResponseLogin)];
    } else {
      return <LoginModel>[];
    }
  }
}
