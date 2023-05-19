import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:offline_classes/utils/constants.dart';
import 'package:offline_classes/utils/my_appbar.dart';
import 'package:sizer/sizer.dart';

class YourDoubts extends StatelessWidget {
  const YourDoubts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar2(context, 'Your Doubts'),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 4,
                itemBuilder: (ctx, i) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(8),
                    decoration: k3DboxDecoration(32),
                    child: ListTile(
                      leading: SizedBox(
                          height: 4.h,
                          child: Image.asset('assets/images/jpg.png')),
                      title: Text(
                        'Mathematics',
                        style: kBodyText18wNormal(black),
                      ),
                      subtitle: Text('28th Dec 2022'),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
