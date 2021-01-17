import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'dash.dart';

String id;

String getId() {
  print(id);
  return id;
}

void signIn(String email, String pass, context) async {
  await Firebase.initializeApp();
  FirebaseAuth auth = FirebaseAuth.instance;
  User user;

  try {
    user = (await auth.signInWithEmailAndPassword(email: email, password: pass))
        .user;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print("No user found");
    } else if (e.code == 'wrong-password') {
      print("Wrong password");
    }
  }
  if (user != null) {
    print(user.email);
    id = user.uid;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Dash()),
    );
  }
}
