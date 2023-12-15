import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:My_First_Flutter_App/components/my_drawer.dart';
import 'package:My_First_Flutter_App/components/my_list_tile.dart';
import 'package:My_First_Flutter_App/components/my_post_button.dart';
import 'package:My_First_Flutter_App/components/my_textfield.dart';
import 'package:My_First_Flutter_App/database/firestore.dart';
import 'package:My_First_Flutter_App/helper/helper_functions.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // firestore access
  final FirestoreDatabase database = FirestoreDatabase();

  // text controller
  final TextEditingController newPostController = TextEditingController();

  // post message method
  void postMessage() {
    // only post if something in textfield
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message).then((value) => newPostController.clear());
      // .then(
      //     (value) => {displayMessageToUser("Posted Successfully", context)});
    } else {
      // FlutterError("bhai likh le phele kuch BSDK");
      showCustomAlert("Warning", "BC lakh to kharo phela");
      // showAlert(context, "Warning", "BC lakh to kharo phela");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("W A L L"),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        // actions: [
        //   // logout button
        //   IconButton(
        //     onPressed: logout,
        //     icon: Icon(Icons.logout)
        //     )
        // ],
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          //textfield for user to type the message
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                // textfield
                Expanded(
                  child: MyTextField(
                      hintText: "Say something...",
                      obscureText: false,
                      controller: newPostController),
                ),

                // post button
                MyPostButton(onTap: postMessage)
              ],
            ),
          ),

          // POSTS LISTING
          StreamBuilder(
            stream: database.getPostsStream(),
            builder: (context, snapshot) {
              // get all posts
              final posts = snapshot.data!.docs;
              // loading
              if (snapshot.connectionState == ConnectionState.waiting) {
                // showLoader(context);

                // return const Center(child: CircularProgressIndicator());

                return showProgressIndicatorSimple();
              } else if (snapshot.hasError) {
                // any errors
                return Text("Error : ${snapshot.error}");
                // return displayMessageToUser(snapshot.error.toString(), context);
              } else if (snapshot.data == null || posts.isEmpty) {
                // no data
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Text("No Posts.... Post something!"),
                  ),
                );
              } else if (snapshot.hasData) {
                // list of posts
                return Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      // get individual user
                      final post = posts[index];

                      // get data from each post
                      String message = post['postMessage'];
                      String userEmail = post['userEmail'];
                      Timestamp timeStamp = post['timeStamp'];

                      return MyListTile(title: message, subTitle: userEmail);
                    },
                  ),
                );
              } else {
                return const Text(
                    "Something went wrong while fetching user details");
              }
            },
          )
        ],
      ),
    );
  }

  // logout method
  void logout() {
    FirebaseAuth.instance.signOut();
  }
}
