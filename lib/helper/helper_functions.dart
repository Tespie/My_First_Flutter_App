import 'package:My_First_Flutter_App/components/my_back_button.dart';
import 'package:flutter/material.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// display message to user
void displayMessageToUser(String message, BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(message),
          ));
}

bool isValidEmail(
  String? inputString, {
  bool isRequired = false,
}) {
  bool isInputStringValid = false;

  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {
    isInputStringValid = true;
  }

  if (inputString != null && inputString.isNotEmpty) {
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    final regExp = RegExp(pattern);

    isInputStringValid = regExp.hasMatch(inputString);
  }

  return isInputStringValid;
}

void showLoader(BuildContext context) {
  // GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  showDialog(
      context: context,
      // context: navigatorKey.currentState!.overlay!.context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator.adaptive(
            strokeWidth: 5,
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.purple,
            ),
            backgroundColor: Colors.amberAccent,
          ),
        );
      });
}

void popContext(BuildContext context) {
  Navigator.pop(context);
}

Padding placeBackButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 50, left: 15),
    child: Row(
      children: [
        MyBackButton(),
      ],
    ),
  );
}

Center showProgressIndicatorSimple() {
  return const Center(child: CircularProgressIndicator());
}

void showAlert(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'OK',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

void showCustomAlert(String title, String message) {
  final customContext = GlobalKey<State>();
  BuildContext context = customContext.currentContext!;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              // Navigator.of(context).pop();
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
