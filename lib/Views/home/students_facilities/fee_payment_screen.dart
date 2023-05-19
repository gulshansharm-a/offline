import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:offline_classes/model/statics_list.dart';
import 'package:offline_classes/utils/my_appbar.dart';
import 'package:offline_classes/widget/custom_back_button.dart';
import 'package:offline_classes/widget/custom_button.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../utils/constants.dart';
import '../../auth/succesfull_login_screen.dart';

class FeePaymentScreen extends StatelessWidget {
  const FeePaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar2(context, 'Fee Payment'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),

              padding:
                  EdgeInsets.only(left: 9.w, right: 3.w, top: 2.h, bottom: 2.h),
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
                        style: kBodyText20wBold(white),
                      ),
                      Text(
                        '13th Jan 23 - Today ',
                        style: kBodyText14wNormal(white),
                      ),
                      addVerticalSpace(10),
                      Text(
                        'Total No. of classes: 09 ',
                        style: kBodyText14wNormal(white),
                      ),
                      addVerticalSpace(1.3.h),
                      InkWell(
                        onTap: () {
                          nextScreen(context, ShowFeePaymnetOfMonth());
                        },
                        child: Container(
                          height: 4.h,
                          width: 30.w,
                          decoration:
                              kGradientBoxDecoration(30, greenGradient()),
                          child: Center(
                            child: Text(
                              'Pay Fee',
                              style: kBodyText12wBold(white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      SizedBox(
                        height: 12.h,
                        child: Image.asset('assets/images/fee.png'),
                      ),
                    ],
                  )
                ],
              ),
            ),
            addVerticalSpace(3.h),
            Text(
              'Previous Months ',
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
                        left: 9.w, right: 5.w, top: 2.h, bottom: 2.h),
                    // height: 16.h,
                    width: width(context) * 0.93,
                    decoration: k3DboxDecoration(42),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 13.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Dec 22 - Jan 23',
                                style: kBodyText18wNormal(black),
                              ),
                              Text(
                                'Total No. of classes: 22 ',
                                style: kBodyText12wBold(textColor),
                              ),
                              addVerticalSpace(1.h),
                              Text(
                                'Total Fee: 2200/-',
                                style: kBodyText18wNormal(black),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Paid',
                          style: kBodyText24wBold(green),
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

class ShowFeePaymnetOfMonth extends StatefulWidget {
  const ShowFeePaymnetOfMonth({super.key});

  @override
  State<ShowFeePaymnetOfMonth> createState() => _ShowFeePaymnetOfMonthState();
}

class _ShowFeePaymnetOfMonthState extends State<ShowFeePaymnetOfMonth> {
  DateRangePickerController _datePickerController = DateRangePickerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar2(context, 'Fee Payment'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 6.h,
              child: ListView.builder(
                  itemCount: subjectList2.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, i) {
                    return Container(
                      margin: EdgeInsets.all(5),
                      height: 6.h,
                      decoration: kGradientBoxDecoration(15, purpleGradident()),
                      padding: EdgeInsets.symmetric(horizontal: 13),
                      child: Center(
                        child: Text(
                          subjectList2[i],
                          style: kBodyText14wBold(white),
                        ),
                      ),
                    );
                  }),
            ),
            Container(
              decoration: k3DboxDecoration(15),
              margin: EdgeInsets.all(12),
              height: 45.h,
              child: SfDateRangePicker(
                  controller: _datePickerController,
                  view: DateRangePickerView.month,
                  monthViewSettings:
                      DateRangePickerMonthViewSettings(firstDayOfWeek: 6),
                  selectionMode: DateRangePickerSelectionMode.multiple,
                  showActionButtons: false,
                  endRangeSelectionColor: Colors.red,
                  selectionColor: Colors.green,
                  rangeSelectionColor: Colors.yellow,
                  todayHighlightColor: Colors.green,
                  onSubmit: (val) {
                    print(val);
                  },
                  onCancel: () {
                    _datePickerController.selectedRanges = null;
                  }),
            ),
            addVerticalSpace(1.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      height: 5.h,
                      width: 13.w,
                      decoration: kFillBoxDecoration(0, Colors.yellow, 10),
                      child: Center(
                        child: Text('25'),
                      ),
                    ),
                    addVerticalSpace(1.3.h),
                    Text(
                      'Total \nclasses taken',
                      style: kBodyText12wNormal(black),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                addHorizontalySpace(3.w),
                Column(
                  children: [
                    Container(
                      height: 5.h,
                      width: 13.w,
                      decoration: kFillBoxDecoration(0, Colors.green, 10),
                      child: Center(
                        child: Text('21'),
                      ),
                    ),
                    addVerticalSpace(3.h),
                    Text(
                      'Present',
                      style: kBodyText14w500(black),
                    )
                  ],
                ),
                addHorizontalySpace(7.w),
                Column(
                  children: [
                    Container(
                      height: 5.h,
                      width: 13.w,
                      decoration: kFillBoxDecoration(0, Colors.red, 10),
                      child: Center(
                        child: Text('4'),
                      ),
                    ),
                    addVerticalSpace(3.h),
                    Text(
                      'Absent',
                      style: kBodyText12wNormal(black),
                    )
                  ],
                ),
                addHorizontalySpace(7.w),
                Column(
                  children: [
                    Container(
                      height: 5.h,
                      width: 13.w,
                      decoration: kFillBoxDecoration(0, boxColor, 10),
                      child: Center(
                        child: Text('2'),
                      ),
                    ),
                    addVerticalSpace(1.3.h),
                    Text(
                      'Class \nnot taken',
                      textAlign: TextAlign.center,
                      style: kBodyText12wNormal(black),
                    )
                  ],
                ),
              ],
            ),
            addVerticalSpace(2.h),
            Text(
              'Total Amount: Rs. 2200',
              style: kBodyText20wBold(primary),
            ),
            addVerticalSpace(3.h),
            Center(
              child: CustomButton(text: 'Pay Rs.2200', onTap: () {}),
            ),
            addVerticalSpace(2.h),
            CustomButtonOutline(
                textWidget: Text(
                  'Pay All Course Fee',
                  style: kBodyText16wBold(green),
                ),
                ontap: () {
                  nextScreen(context, PaymentSuccessFullScreen());
                },
                width: width(context) * 0.9,
                height: 6.5.h),
            addVerticalSpace(3.h)
          ],
        ),
      ),
    );
  }
}
