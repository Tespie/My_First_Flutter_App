import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:My_First_Flutter_App/components/my_back_button.dart';
import 'package:My_First_Flutter_App/helper/helper_functions.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  // current logged in user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // future to fetch user details from cloud firestore
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Profile Page"),
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   elevation: 0,
      // ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: getUserDetails(),
          builder: (context, snapshot) {
            // loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              // showLoader(context);

              // return const Center(
              //   child: CircularProgressIndicator()
              //   );

              return showProgressIndicatorSimple();
            } else if (snapshot.hasError) {
              // any errors
              return Text("Error : ${snapshot.error}");
            } else if (snapshot.data == null) {
              // no data
              return const Text("No data found");
            } else if (snapshot.hasData) {
              //data received

              // extract data
              Map<String, dynamic>? user = snapshot.data!.data();

              return Center(
                child: Column(
                  children: [
                    //back button
                    Padding(
                      padding: const EdgeInsets.only(top: 50, left: 15),
                      child: Row(
                        children: [
                          MyBackButton(),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // profile pic
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.all(25),
                      child: const Icon(
                        Icons.person,
                        size: 64,
                      ),
                    ),

                    const SizedBox(height: 25),

                    // username
                    Text(
                      user!['username'],
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 10),

                    // email
                    Text(
                      user['email'],
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              );
            } else {
              return const Text(
                  "Something went wrong while fetching user details");
            }
          }),
    );
  }
}
