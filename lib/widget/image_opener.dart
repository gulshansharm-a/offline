import 'dart:io';

import 'package:flutter/material.dart';
import 'package:offline_classes/utils/my_appbar.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sizer/sizer.dart';

import 'custom_button.dart';

class ImageOpener extends StatelessWidget {
  final File? imageFile;
  final String? baseurl;
  final bool showOnly;

  const ImageOpener({
    super.key,
    required this.imageFile,
    this.baseurl = "",
    required this.showOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: customAppbar2(context, "Send Doubt"),
      body: Center(
        child: imageFile != null
            ? PhotoView(
                imageProvider: FileImage(imageFile!),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2.0,
              )
            : Text('No Image Selected'),
      ),
      bottomNavigationBar: showOnly
          ? null
          : Container(
              padding: EdgeInsets.only(left: 30, right: 30, bottom: 5, top: 5),
              color: Colors.transparent,
              width: 25.w,
              child: CustomButton(
                text: 'Send',
                onTap: () {},
              ),
            ),
    );
  }
}
