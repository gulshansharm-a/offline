import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:offline_classes/model/statics_list.dart';
import 'package:offline_classes/utils/constants.dart';
import 'package:offline_classes/utils/my_appbar.dart';
import 'package:sizer/sizer.dart';

import '../../../global_data/GlobalData.dart';
import '../../../global_data/student_global_data.dart';

class GKScreen extends StatelessWidget {
  GKScreen({super.key});

  Future<void> getGK() async {
    final http.Response response = await http.get(Uri.parse(
        "https://trusher.shellcode.co.in/api/gk?authKey=${GlobalData.auth1}&user_id=${GlobalStudent.id}"));
    try {
      gk = json.decode(response.body);
      if (response.statusCode == 200) {
        print(gk);
      } else {
        print("Unsuccessful");
      }
    } catch (e) {
      print("Unsuccessful");
    }
  }

  Map<String, dynamic> gk = {};

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getGK(),
      builder: (context, snapshot) {
        if (gk.isEmpty) {
          return const Center(
              child: CircularProgressIndicator(color: primary2));
        } else {
          return Scaffold(
            appBar: customAppbar2(context, 'General Knowledge'),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  addVerticalSpace(1.h),
                  Center(
                    child: Text(
                      'For All Classes',
                      style: kBodyText18wBold(black),
                    ),
                  ),
                  ListView.builder(
                      itemCount: gk["allgk"].length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, i) {
                        return Container(
                          margin: EdgeInsets.all(1.h),
                          width: 93.w,
                          decoration: k3DboxDecoration(42),
                          padding: EdgeInsets.only(
                              left: 9.w, right: 5.w, top: 2.h, bottom: 2.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                gk["allgk"][i]["tittle"],
                                style: kBodyText18wNormal(black),
                              ),
                              Center(
                                child: Image.network(
                                  GlobalStudent.urlPrefix +
                                      gk["allgk"][i]["image"],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              addVerticalSpace(1.h),
                              Text(
                                gk["allgk"][i]["disc"],
                                style: kBodyText14w500(black),
                              )
                            ],
                          ),
                        );
                      }),
                  addVerticalSpace(2.h),
                  Center(
                    child: Text(
                      'For You',
                      style: kBodyText18wBold(black),
                    ),
                  ),
                  ListView.builder(
                    itemCount: gk["foryou"].length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, i) {
                      print(gk["foryou"].length);
                      return Container(
                        margin: EdgeInsets.all(1.h),
                        width: 93.w,
                        decoration: k3DboxDecoration(42),
                        padding: EdgeInsets.only(
                            left: 9.w, right: 5.w, top: 2.h, bottom: 2.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              gk["foryou"][i]["tittle"],
                              style: kBodyText18wNormal(black),
                            ),
                            Center(
                              child: Image.network(
                                GlobalStudent.urlPrefix +
                                    gk["foryou"][i]["image"],
                                fit: BoxFit.cover,
                              ),
                            ),
                            addVerticalSpace(1.h),
                            Text(
                              gk["foryou"][i]["disc"],
                              style: kBodyText14w500(black),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
