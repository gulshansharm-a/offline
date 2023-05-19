import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:offline_classes/utils/my_appbar.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/constants.dart';

class ParentsDoubtsSaved extends StatelessWidget {
  const ParentsDoubtsSaved({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar2(context, 'Parents Doubts'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, i) {
                  return Container(
                    margin: EdgeInsets.all(1.h),
                    width: 93.w,
                    decoration: k3DboxDecoration(42),
                    padding: EdgeInsets.only(
                        left: 9.w, right: 2.w, top: 2.h, bottom: 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lorem ipsum dolor',
                          style: kBodyText18wNormal(black),
                        ),
                        Text(
                          'Posted On: 13th Jan 2023',
                          style: kBodyText14w500(textColor),
                        ),
                        addVerticalSpace(1.h),
                        Text(
                          'Lorem ipsum dolor sit amet consectetur. Quam lobortis in proin amet et.',
                          style: kBodyText14w500(black),
                        )
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
