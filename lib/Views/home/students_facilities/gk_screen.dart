import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:offline_classes/model/statics_list.dart';
import 'package:offline_classes/utils/constants.dart';
import 'package:offline_classes/utils/my_appbar.dart';
import 'package:sizer/sizer.dart';

class GKScreen extends StatelessWidget {
  const GKScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                itemCount: gkList1.length,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          gkList1[i],
                          style: kBodyText18wNormal(black),
                        ),
                        addVerticalSpace(1.h),
                        Text(
                          'Lorem ipsum dolor sit amet consectetur. In cursus egestas amet nam sodales sollicitudin ut feugiat.',
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
                itemCount: gkList2.length,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          gkList2[i],
                          style: kBodyText18wNormal(black),
                        ),
                        addVerticalSpace(1.h),
                        Text(
                          'Lorem ipsum dolor sit amet consectetur. In cursus egestas amet nam sodales sollicitudin ut feugiat.',
                          style: kBodyText14w500(black),
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
