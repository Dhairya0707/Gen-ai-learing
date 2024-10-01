import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learingapp/main.dart';
import 'package:learingapp/provider/gen_provider.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isloading = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login(context) async {
    try {
      isloading = true;
      notifyListeners();
      await auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      isloading = false;
      notifyListeners();
      email.clear();
      password.clear();
      showSnackBar(context, "Login Successfully");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AuthGate()),
          (route) => false);
    } catch (e) {
      showSnackBar(context, "Error : ${e.toString()}");
      isloading = false;
      notifyListeners();
    }
  }
}
