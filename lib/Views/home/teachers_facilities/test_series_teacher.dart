// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:offline_classes/utils/my_appbar.dart';
import 'package:offline_classes/widget/image_opener.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../../global_data/GlobalData.dart';
import '../../../global_data/teacher_global_data.dart';
import '../../../utils/constants.dart';

class TestSeriesForTeacher extends StatelessWidget {
  TestSeriesForTeacher(
      {super.key, required this.title, required this.student_id});
  final String title;
  final int student_id;

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

  Future<void> getDoubts() async {
    log("${GlobalData.baseUrl}/teacherTestShow?authKey=${GlobalData.auth1}&teacher_id=${GlobalTeacher.id}&student_id=${student_id}");
    final http.Response response = await http.get(Uri.parse(
        "${GlobalData.baseUrl}/teacherTestShow?authKey=${GlobalData.auth1}&teacher_id=${GlobalTeacher.id}&student_id=${student_id}"));
    tests = json.decode(response.body);
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      log(tests.toString());
    } else {
      print("Unsuccessful");
    }
  }

  Map<String, dynamic> tests = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar2(context, title),
      body: FutureBuilder(
        future: getDoubts(),
        builder: (context, snapshot) {
          if (tests.isEmpty) {
            return const Center(
                child: CircularProgressIndicator(color: primary2));
          } else {
            return Column(
              children: [
                Visibility(
                  visible: tests["data"].length == 0,
                  child: Text(
                    "No tests uploaded yet.",
                    style: kBodyText16wBold(primary2),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: tests["data"].length,
                    itemBuilder: (ctx, i) {
                      return Container(
                        width: 92.w,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(8),
                        decoration: k3DboxDecoration(32),
                        child: ListTile(
                          leading: GestureDetector(
                            onTap: () async {
                              var imageUrl = GlobalTeacher.urlPrefix +
                                  tests["data"][i]["questions"];
                              log(imageUrl);
                              if (await canLaunchUrl(Uri.parse(imageUrl))) {
                                await launchUrl(Uri.parse(imageUrl));
                              } else {
                                throw 'Could not launch url';
                              }
                            },
                            child: SizedBox(
                                height: 4.h,
                                child: Image.asset('assets/images/jpg.png')),
                          ),
                          title: Text(
                            tests["data"][i]["title"],
                            style: kBodyText18wNormal(black),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(tests["data"][i]["dt"]),
                              GestureDetector(
                                onTap: () async {
                                  var imageUrl = GlobalTeacher.urlPrefix +
                                      tests["data"][i]["answer"];
                                  log(imageUrl);
                                  if (await canLaunchUrl(Uri.parse(imageUrl))) {
                                    await launchUrl(Uri.parse(imageUrl));
                                  } else {
                                    throw 'Could not launch url';
                                  }
                                },
                                child: Text(
                                  "Answers",
                                  style: TextStyle(color: primary),
                                ),
                              )
                            ],
                          ),
                          onTap: () async {
                            // File imageFile =
                            //     await convertImageUrlToFile(imageUrl);
                            // nextScreen(
                            //   context,
                            //   ImageOpener(
                            //     imageFile: imageFile,
                            //     send: false,
                            //     showOnly: true,
                            //   ),
                            // );
                          },
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
