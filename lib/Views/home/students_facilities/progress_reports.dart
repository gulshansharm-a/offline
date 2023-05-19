import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:offline_classes/utils/my_appbar.dart';
import 'package:offline_classes/widget/custom_button.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/constants.dart';

class ProgressReports extends StatelessWidget {
  const ProgressReports({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar2(context, 'Progress Report'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(12),
                // height: 12.h,
                width: 93.w,
                decoration: kGradientBoxDecoration(35, purpleGradident()),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Month',
                          style: kBodyText22bold(white),
                        ),
                        Text(
                          '13th Jan 23 - Today ',
                          style: kBodyText14wNormal(white),
                        ),
                        addVerticalSpace(10),
                        Container(
                          width: width(context) * 0.24,
                          height: 4.h,
                          decoration:
                              kGradientBoxDecoration(40, greenGradient()),
                          child: Center(
                            child: Text(
                              'View Report',
                              style: kBodyText10wBold(white),
                            ),
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    Container(
                      height: 13.h,
                      child: Image.asset('assets/images/report.png'),
                    )
                  ],
                ),
              ),
            ),
            addVerticalSpace(3.h),
            Text(
              'Previous Months Reports ',
              style: kBodyText18wBold(black),
            ),
            addVerticalSpace(1.h),
            ListView.builder(
                shrinkWrap: true,
                itemCount: 4,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, i) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.only(
                        left: 8.w, right: 12, top: 2.h, bottom: 2.h),
                    // height: 16.h,
                    width: width(context) * 0.93,
                    decoration: k3DboxDecoration(35),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Mathematics',
                              style: kBodyText18wNormal(black),
                            ),
                            Text(
                              '27th Dec 2022',
                              style: kBodyText12wBold(textColor),
                            ),
                            addVerticalSpace(1.2.h),
                            SizedBox(
                              width: width(context) * 0.55,
                              child: Text(
                                'Total Marks Obtained: 73/100',
                                style: kBodyText12wNormal(black),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Container(
                          width: width(context) * 0.26,
                          height: 4.h,
                          decoration:
                              kGradientBoxDecoration(40, greenGradient()),
                          child: Center(
                            child: Text(
                              'View Report',
                              style: kBodyText10wBold(white),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
