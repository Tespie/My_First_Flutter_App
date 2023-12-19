// ignore_for_file: prefer_const_constructors

import 'package:My_First_Flutter_App/helper/helper_functions.dart';
import 'package:My_First_Flutter_App/pages/practice_page.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Tab"),
      ),
      body: Column(
        children: const [
          Test_ButtonWithFirstPageButton(),
          SizedBox(height: 25),
          Test_CustomAlertShowBaji()
        ],
      ),
    );
  }
}

class Test_CustomAlertShowBaji extends StatelessWidget {
  const Test_CustomAlertShowBaji({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: NiceTextLabel(text: "Tap me to open Alert"),
      onTap: () {
        showCustomDialog(context, "title", "first tap with cancel button",
            onOkPressed: () {
          showCustomDialog(context, "OK",
              "alert dialog without cancel button and \n 🤡 You Can't dismiss me on Outer Touch ⚠️",
              canDismissed: false);
        }, showCancel: true);
      },
    );
  }
}
