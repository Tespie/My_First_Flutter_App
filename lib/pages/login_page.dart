import 'package:firebase_auth/firebase_auth.dart';
import 'package:My_First_Flutter_App/components/my_button.dart';
import 'package:My_First_Flutter_App/components/my_textfield.dart';
import 'package:My_First_Flutter_App/helper/helper_functions.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void gotoProfile() {
    Navigator.pushNamed(context, 'profile_page');
  }

  //login method
  void clickLogin() async {
    if (!isValidEmail(emailController.text, isRequired: true) ||
        passwordController.text == "") {
      displayMessageToUser("One of your fields have invalid data.", context);
      return;
    }

    // show loader
    // showLoader(context);

    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // // hide loader
      // if (!context.mounted) return;
      // popContext(context);

      displayMessageToUser("Login Success", context);
      // showCustomAlertDialog("Success", "Login done successfully",
      //     onOkPressed: gotoProfile);
      // showCustomAlert("title", "message");
    } on FirebaseAuthException catch (e) {
      // hide loader
      if (!context.mounted) return;
      popContext(context);

      displayMessageToUser(e.message.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            scrollDirection: Axis.vertical,
            children: [
              const Padding(padding: EdgeInsets.only(top: 20)),
              //logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),

              const SizedBox(height: 25),

              //app name
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "J I G N E C T",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),

              const SizedBox(height: 50),

              // email textfield
              MyTextField(
                  hintText: "Email",
                  obscureText: false,
                  controller: emailController),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController),

              const SizedBox(height: 10),

              //forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // sign in button
              MyButton(text: "Login", onTap: clickLogin),

              const SizedBox(height: 25),

              // don't have an account? Register here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    // onTap: clickRegister,
                    child: const Text(" Register Here",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void clickRegister() {}
}
