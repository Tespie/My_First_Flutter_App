import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:My_First_Flutter_App/components/my_button.dart';
import 'package:My_First_Flutter_App/components/my_textfield.dart';
import 'package:My_First_Flutter_App/helper/helper_functions.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controllers
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  //register method
  void clickRegister() async {
    // make sure pw and cpwd matches
    if (passwordController.text != confirmPasswordController.text) {
      // hide loading
      Navigator.pop(context);

      // show error message to user
      displayMessageToUser("Passwords don't match", context);

      // if passwords match
    } else if (usernameController.text != "" &&
        isValidEmail(emailController.text)) {
// show loading circle
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      //try creating the user
      try {
        // create user
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        // create a user and add to firestore
        createUserDocument(userCredential);

        // hide loading
        if (context.mounted) popContext(context);
      } on FirebaseAuthException catch (e) {
        // hide loading
        if (context.mounted) popContext(context);

        String message = e.code;

        switch (message) {
          case "email-already-in-use":
            message = "This user already exist";
            break;
          case "invalid-email":
            message = "Please enter valid email";
            break;
          case "operation-not-allowed":
            message = "Your account is disabled in the Firebase Console";
            break;
          case "weak-password":
            message = "Use Strong Password";
            break;
          default:
            message = "Something went wrong";
        }

        // displayMessageToUser(e.code, context);
        displayMessageToUser(message, context);
      }
    } else {
      displayMessageToUser("Please fill details first", context);
    }
  }

  // login method
  // void clickLogin() {
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),

              const SizedBox(height: 25),

              //app name
              const Text(
                "J I G N E C T",
                style: TextStyle(fontSize: 20),
              ),

              const SizedBox(height: 50),

              // username textfield
              MyTextField(
                  hintText: "Username",
                  obscureText: false,
                  controller: usernameController),

              const SizedBox(height: 10),

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

              // confirm password textfield
              MyTextField(
                  hintText: "Confirm Password",
                  obscureText: true,
                  controller: confirmPasswordController),

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

              // register button
              MyButton(text: "Register", onTap: clickRegister),

              const SizedBox(height: 25),

              // don't have an account? Register here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  GestureDetector(
                    // onTap: clickLogin,
                    onTap: widget.onTap,
                    child: const Text(" Login Here",
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

  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'username': usernameController.text,
      });
    } else {}
  }

  // void displayMessageToUser() {}
}
