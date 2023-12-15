import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/*
 * This database stores the posts that users have published in the app.
 * It is stored in a collection called 'Posts' in Firebase.
 * 
 * Each post contains;
 * - a message
 * - email of user
 * - timestamp 
 */
class FirestoreDatabase {
  // current logged in user
  User? user = FirebaseAuth.instance.currentUser;

  // get collection of posts from firestore
  final CollectionReference posts =
      FirebaseFirestore.instance.collection("Posts");

  // post a message
  Future<void> addPost(String message) {
    return posts.add({
      'postMessage': message,
      'userEmail': user!.email,
      'timeStamp': Timestamp.now(),
    });
  }

  // read posts from database
  Stream<QuerySnapshot> getPostsStream() {
    final postStream = FirebaseFirestore.instance
        .collection("Posts")
        .orderBy('timeStamp', descending: true)
        .snapshots();

    return postStream;
  }
}
