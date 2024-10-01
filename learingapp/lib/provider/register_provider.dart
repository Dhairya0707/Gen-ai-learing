import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learingapp/main.dart';
import 'package:learingapp/provider/gen_provider.dart';

class RegisterProvider extends ChangeNotifier {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isloading = false;

  Future<void> register(context) async {
    isloading = true;
    notifyListeners();

    try {
      await auth.createUserWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      final authid = auth.currentUser?.uid;
      firestore.collection("users").doc(authid).set({
        "name": name.text.trim(),
        "email": email.text.trim(),
        "password": password.text.trim(),
        "score": 0,
      });
      showSnackBar(context, "Account Created Successfully");
      isloading = false;
      notifyListeners();
      email.clear();
      password.clear();
      name.clear();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AuthGate()),
          (route) => false);
    } catch (e) {
      showSnackBar(context, "Error : ${e.toString()}");
      isloading = false;
      notifyListeners();
      print(e);
    }
  }
}
