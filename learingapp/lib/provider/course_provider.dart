// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:learingapp/screen/read_page.dart';

class CourseProvider extends ChangeNotifier {
  final TextEditingController courseName = TextEditingController();
  final TextEditingController specificFocus = TextEditingController();
  String _difficultyLevel = 'Beginner';
  bool _isLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String get difficultyLevel => _difficultyLevel;
  bool get isLoading => _isLoading;

  void setDifficultyLevel(String level) {
    _difficultyLevel = level;
    notifyListeners();
  }

  void addCourse(BuildContext context) async {
    if (courseName.text.isEmpty || _difficultyLevel.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: "AIzaSyCcLWJMgkqSXzYNF_ND9qWY1RIhiHYUDKU",
      );
      String prompt =
          'Generate a long  detailed learning plan with study way in Markdown format on the topic : ${courseName.text} specificFocus focus : ${specificFocus.text}. difficulty level : $_difficultyLevel. Include: An introduction to the topic. Two main sections explaining key concepts. One example or practice question for each section. A closing motivational statement in a blockquote. Provide a list of additional resources (links, articles, or books) at the end.';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      // print(response.text);
      final data = response.text;

      await firestore
          .collection("users")
          .doc(auth.currentUser?.uid)
          .collection("course")
          .add({
        'courseName': courseName.text,
        'specificFocus': specificFocus.text,
        'difficultyLevel': difficultyLevel,
        'generatedContent': data,
        'createdAt': FieldValue.serverTimestamp(),
      });

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MarkdownDisplayScreen(
                    markdownContent: data!,
                    title: courseName.text,
                    quizepage: false,
                  )));
      courseName.clear();
      specificFocus.clear();
      _difficultyLevel = 'Beginner';
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    // await Future.delayed(const Duration(seconds: 2));

    // _isLoading = false;
    // notifyListeners();

    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text('Course added successfully')),
    // );

    // courseName.clear();
    // specificFocus.clear();
    // _difficultyLevel = 'Beginner';

    // Navigator.pop(context);
  }
}
