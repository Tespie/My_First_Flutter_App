import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:My_First_Flutter_App/components/my_list_tile.dart';
import 'package:My_First_Flutter_App/helper/helper_functions.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Users"),
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   elevation: 0,
      // ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot) {
          // loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            // showLoader(context);

            // return const Center(child: CircularProgressIndicator());

            return showProgressIndicatorSimple();
          } else if (snapshot.hasError) {
            // any errors
            return Text("Error : ${snapshot.error}");
            // return displayMessageToUser(snapshot.error.toString(), context);
          } else if (snapshot.data == null) {
            // no data
            return const Text("No data found");
          } else if (snapshot.hasData) {
            //data received

            // extract data
            final users = snapshot.data!.docs;

            return Column(
              children: [
                // back button
                placeBackButton(context),

                // list of users
                Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      // get individual user
                      final user = users[index];

                      // get data from each user
                      String username = user['username'];
                      String email = user['email'];

                      return MyListTile(title: username, subTitle: email);
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Text(
                "Something went wrong while fetching user details");
          }
        },
      ),
    );
  }
}
