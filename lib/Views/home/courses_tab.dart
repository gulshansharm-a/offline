import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:offline_classes/utils/constants.dart';
import 'package:offline_classes/widget/custom_button.dart';
import 'package:sizer/sizer.dart';

class CoursesTab extends StatelessWidget {
  const CoursesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        foregroundColor: black,
        elevation: 0,
        leadingWidth: width(context) * 0.4,
        leading: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text(
            '  Courses',
            style: kBodyText20wBold(primary),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                'Cancel Courses',
                style: kBodyText14wBold(primary2),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            addVerticalSpace(10),
            Center(
              child: Text(
                'Courses Enrolled',
                style: kBodyText18wBold(primary),
              ),
            ),
            addVerticalSpace(3.h),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (ctx, i) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.5.h),
                    // height: 11.h,
                    width: 93.w,
                    decoration: kGradientBoxDecoration(35, purpleGradident()),
                    // decoration: kFillBoxDecoration(0, Color(0xff48116a), 35),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Mathematics',
                              style: kBodyText24wBold(white),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                confirmationPopup(context);
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 10,
                                child: Icon(
                                  Icons.close,
                                  size: 15,
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                          'Course started on: 14th Dec 2022',
                          style: kBodyText15wNormal(white),
                        )
                      ],
                    ),
                  );
                }),
            addVerticalSpace(15),
            Text(
              'Selected Courses',
              style: kBodyText20wBold(primary),
            ),
            addVerticalSpace(10),
            ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, i) {
                  return Container(
                      // height: 8.h,
                      padding: EdgeInsets.all(2.h),
                      width: 93.w,
                      margin: EdgeInsets.all(10),
                      decoration: k3DboxDecoration(25),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Social Science',
                                style: kBodyText18wBold(primary),
                              ),
                              Spacer(),
                              Text(
                                'Rs. 2000',
                                style: kBodyText16wNormal(primary),
                              ),
                            ],
                          ),
                          addVerticalSpace(2.5.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomButtonOutline(
                                  textWidget: Text(
                                    'Book Demo',
                                    style: kBodyText12wBold(black),
                                  ),
                                  ontap: () {},
                                  width: 32.w,
                                  height: 4.5.h),
                              addHorizontalySpace(5.w),
                              Container(
                                width: 30.w,
                                height: 4.5.h,
                                decoration:
                                    kGradientBoxDecoration(30, greenGradient()),
                                child: Center(
                                  child: Text(
                                    'Buy Course',
                                    style: kBodyText12wBold(white),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ));
                }),
            addVerticalSpace(15),
            Text(
              'Add Courses',
              style: kBodyText20wBold(primary),
            ),
            addVerticalSpace(10),
            ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, i) {
                  return Container(
                      // height: 8.h,
                      padding: EdgeInsets.all(2.h),
                      width: 93.w,
                      margin: EdgeInsets.all(10),
                      decoration: k3DboxDecoration(25),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Social Science',
                                style: kBodyText18wBold(primary),
                              ),
                              Spacer(),
                              Text(
                                'Rs. 2000',
                                style: kBodyText16wNormal(primary),
                              ),
                            ],
                          ),
                          addVerticalSpace(2.5.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomButtonOutline(
                                  textWidget: Text(
                                    'Book Demo',
                                    style: kBodyText12wBold(black),
                                  ),
                                  ontap: () {},
                                  width: 32.w,
                                  height: 4.5.h),
                              addHorizontalySpace(5.w),
                              Container(
                                width: 30.w,
                                height: 4.5.h,
                                decoration:
                                    kGradientBoxDecoration(30, greenGradient()),
                                child: Center(
                                  child: Text(
                                    'Buy Course',
                                    style: kBodyText12wBold(white),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ));
                }),
            addVerticalSpace(15),
          ],
        ),
      ),
    );
  }
}

Future<dynamic> confirmationPopup(BuildContext context) {
  return showDialog(
      context: context,
      builder: (_) => AlertDialog(
            contentPadding: const EdgeInsets.all(6),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                var height = MediaQuery.of(context).size.height;
                var width = MediaQuery.of(context).size.width;

                return Container(
                    height: height * 0.3,
                    // decoration: kFillBoxDecoration(0, white, 40),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Are you sure you want to cancel Mathematics Course?',
                          style: kBodyText18wBold(black),
                          textAlign: TextAlign.center,
                        ),
                        addVerticalSpace(6.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                goBack(context);
                              },
                              child: Container(
                                height: 5.h,
                                width: 20.w,
                                decoration: kOutlineBoxDecoration(2, green, 18),
                                child: Center(
                                  child: Text(
                                    'No',
                                    style: kBodyText16wBold(green),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                                height: 5.h,
                                width: 20.w,
                                child: CustomButton(
                                    text: 'Yes',
                                    onTap: () {
                                      goBack(context);
                                    }))
                          ],
                        ),
                      ],
                    ));
              },
            ),
          ));
}
