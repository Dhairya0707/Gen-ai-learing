import 'package:flutter/material.dart';
import 'package:learingapp/provider/gen_provider.dart';
import 'package:learingapp/provider/login_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
        builder: (context, LoginProvider provider, child) {
      return Scaffold(
        appBar: AppBar(
          elevation: 10,
          title: const Text(
            "Login to your Account",
            style: TextStyle(
              color: Color.fromARGB(255, 33, 45, 51),
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 33, 45, 51),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  _buildTextField('Enter your email', provider.email),
                  const SizedBox(height: 20),
                  _buildTextField('Create Password', provider.password,
                      isPassword: true),
                  const SizedBox(height: 40),
                  const Spacer(),
                  _buildSubmitButton(provider)
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildTextField(String hint, TextEditingController controller,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      style: const TextStyle(fontWeight: FontWeight.bold),
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildSubmitButton(LoginProvider provider) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (provider.email.text.isNotEmpty ||
              provider.password.text.isNotEmpty) {
            provider.login(context);
          } else {
            showSnackBar(context, "Fill all the fields");
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 33, 45, 51),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: provider.isloading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Text(
                'Login',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
      ),
    );
  }
}
