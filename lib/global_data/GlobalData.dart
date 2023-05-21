import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:offline_classes/model/login_model.dart';

import '../model/student_home_data_model.dart';

class GlobalData {
  static Map<String, dynamic> mapResponseStudetHome = {};
  static Map<String, dynamic> mapResponseLogin = {};
  static String phoneNumber = "917665512617";

  static String baseUrl = "https://trusher.shellcode.co.in/api";
  static String auth1 =
      "C4NX7IelyDl14flZGWcwDrhymzMnTcYV93dYtwfcVC1O7yabAT2Uexsd4ku7L9vlxd5nWrJDsPOfEfdDjfBGnl0ekg9droyLaPrn";

  static String role = "Student";

  updateRole(String roles) {
    role = roles;
  }

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
      print("Global");
      return [StudentHomeDataModel.fromJson(mapResponseStudetHome)];
    } else {
      return <StudentHomeDataModel>[];
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
    //     "https://trusher.shellcode.co.in/api/studentHome?authKey=C4NX7IelyDl14flZGWcwDrhymzMnTcYV93dYtwfcVC1O7yabAT2Uexsd4ku7L9vlxd5nWrJDsPOfEfdDjfBGnl0ekg9droyLaPrn&mobile=917665512617"));
    final http.Response response = await http.get(Uri.parse(
        baseUrl + apiUrl + "?authKey=" + authKey + "&mobile=" + mobno));
    mapResponseLogin = json.decode(response.body);
    if (response.statusCode == 200) {
      print(mapResponseStudetHome);
      print("Global");
      return [LoginModel.fromJson(mapResponseStudetHome)];
    } else {
      return <LoginModel>[];
    }
  }
}
