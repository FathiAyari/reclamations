import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reclamations/models/User.dart';


class AuthServices {
  //var storage = GetStorage();
  final FirebaseAuth auth = FirebaseAuth.instance;
  var userCollection = FirebaseFirestore.instance.collection('users');

  Future<bool> signIn(String emailController, String passwordController) async {
    try {
      await auth.signInWithEmailAndPassword(email: emailController, password: passwordController);

      return true;
    } on FirebaseException catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<bool> signUp(
      {required String email,
      required String password,
      required String name,
      required String lastName,
      required String phoneNumber}) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);

      await saveUser(Cuser(
        status: 1,
        uid: user!.uid,
        name: name,
        email: email,
        role: 'client',
        lastName: lastName,
        phoneNumber: phoneNumber,
      ));

      return true;
    } on FirebaseException catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> resetPassword(String emailController) async {
    try {
      await auth.sendPasswordResetEmail(email: emailController);
      return true;
    } on FirebaseException catch (e) {
      return false;
    }
  }

  Future<Cuser> getUserData() async {
    var userData = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
    return Cuser.fromJson(userData.data()!);
  }

  User? get user => auth.currentUser;

  saveUser(Cuser user) async {
    try {
      await userCollection.doc(user.uid).set(user.toJson());
    } catch (e) {}
  }

  Future<void> saveUserLocally(Cuser user) async {
   // await storage.write("role", user.role);

  /*  await storage.write("user", {
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'phoneNumber': user.phoneNumber,
      'role': user.role,
      'lastName': user.lastName,
    });*/
    print('saving values');
  }

  logOut(BuildContext context) {
   // storage.remove('role');
    //storage.remove('user');
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

}
