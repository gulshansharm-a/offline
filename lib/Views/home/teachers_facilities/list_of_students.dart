import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:offline_classes/Views/home/teachers_facilities/students_details.dart';
import 'package:offline_classes/utils/my_appbar.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/constants.dart';

class ListOfStudentsScreen extends StatelessWidget {
  const ListOfStudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar2(context, 'Students List'),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (ctx, i) {
                    return InkWell(
                      onTap: () {
                        nextScreen(context, StudentsDetails());
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(12),
                        // height: 12.h,
                        width: 93.w,
                        decoration:
                            kGradientBoxDecoration(35, purpleGradident()),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 11.h,
                              width: 25.w,
                              decoration:
                                  kGradientBoxDecoration(18, orangeGradient()),
                              child: Image.asset('assets/images/dummy1.png'),
                            ),
                            addHorizontalySpace(width(context) * 0.06),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Diksha Shah',
                                  style: kBodyText24wBold(white),
                                ),
                                addVerticalSpace(10),
                                Text(
                                  'Science & English',
                                  style: kBodyText16wNormal(white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
