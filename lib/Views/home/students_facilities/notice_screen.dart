import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:offline_classes/model/statics_list.dart';
import 'package:offline_classes/utils/constants.dart';
import 'package:offline_classes/utils/my_appbar.dart';
import 'package:offline_classes/widget/custom_button.dart';
import 'package:offline_classes/widget/custom_textfield.dart';
import 'package:sizer/sizer.dart';

class NoticeScreen extends StatelessWidget {
  const NoticeScreen({super.key, required this.isVisible});
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar2(context, 'Notice'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            addVerticalSpace(1.h),
            Center(
              child: Text(
                'Notices From Teacher',
                style: kBodyText18wBold(black),
              ),
            ),
            ListView.builder(
                itemCount: NoticeList.length,
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          NoticeList[i]['title'],
                          style: kBodyText18wNormal(black),
                        ),
                        Text(
                          NoticeList[i]['date'],
                          style: kBodyText14w500(textColor),
                        ),
                        addVerticalSpace(1.h),
                        Text(
                          NoticeList[i]['desc'],
                          style: kBodyText14w500(black),
                        )
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
      bottomNavigationBar: Visibility(
        visible: isVisible,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: CustomButton(
              text: 'Add Notice',
              onTap: () {
                nextScreen(context, AddNoticeScreen());
              }),
        ),
      ),
    );
  }
}

class AddNoticeScreen extends StatelessWidget {
  const AddNoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController description = TextEditingController();
    return Scaffold(
      appBar: customAppbar2(context, 'Add Notice'),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            addVerticalSpace(2.h),
            CustomTextfield(
              hintext: 'Title',
              controller: title,
            ),
            addVerticalSpace(3.h),
            CustomTextfieldMaxLine(
              hintext: 'Description',
              controller: title,
            ),
            const Spacer(),
            CustomButton(text: 'Post', onTap: () {})
          ],
        ),
      ),
    );
  }
}
