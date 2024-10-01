import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:learingapp/provider/course_provider.dart';
import 'package:learingapp/provider/gen_provider.dart';
import 'package:learingapp/provider/home_provider.dart';
import 'package:learingapp/provider/login_provider.dart';
import 'package:learingapp/provider/register_provider.dart';
import 'package:learingapp/screen/homepage.dart';
import 'package:learingapp/screen/landing.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => GenProvider()),
          ChangeNotifierProvider(create: (context) => HomeProvider()),
          ChangeNotifierProvider(create: (context) => CourseProvider()),
          ChangeNotifierProvider(create: (context) => LoginProvider()),
          ChangeNotifierProvider(create: (context) => RegisterProvider())
        ],
        child: MaterialApp(
          title: 'Ai-Learning',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: Colors.deepPurple.shade400),
            useMaterial3: true,
          ),
          home: const AuthGate(),
        ));
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // If the user is signed in, show the HomeScreen
        if (snapshot.hasData) {
          return HomeScreen(); // Replace with your authenticated screen
        }
        // Otherwise, show the RegisterScreen
        return const LandingScreen();
      },
    );
  }
}
