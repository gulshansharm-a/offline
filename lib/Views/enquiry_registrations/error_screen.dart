import 'package:flutter/material.dart';

import '../../utils/my_appbar.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar2(context, ''),
      body: Container(),
    );
  }
}
