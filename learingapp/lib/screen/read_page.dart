// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:learingapp/screen/addcousre.dart';
import 'package:markdown_widget/markdown_widget.dart';

class MarkdownDisplayScreen extends StatefulWidget {
  final String markdownContent;
  final String title;
  final bool quizepage;

  const MarkdownDisplayScreen(
      {super.key,
      required this.markdownContent,
      this.title = 'Study Content',
      required this.quizepage});

  @override
  State<MarkdownDisplayScreen> createState() => _MarkdownDisplayScreenState();
}

class _MarkdownDisplayScreenState extends State<MarkdownDisplayScreen> {
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text(
          widget.title,
          style: const TextStyle(
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.88,
              width: MediaQuery.of(context).size.width,
              child: MarkdownWidget(
                data: widget.markdownContent,
                config: MarkdownConfig(
                  configs: const [
                    H1Config(
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    H2Config(
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    H3Config(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    H4Config(
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    H5Config(
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    H6Config(
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // const HeadingConfig(
                    //   h1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    //   h2: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    //   h3: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    // ),
                    // LinkConfig(
                    //   style: const TextStyle(
                    //     color: Colors.blue,
                    //     decoration: TextDecoration.underline,
                    //   ),
                    //   onTap: (url) {
                    //     // Handle link taps here
                    //     print('Tapped link: $url');
                    //   },
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: widget.quizepage
          ? null
          : FloatingActionButton.extended(
              backgroundColor: const Color.fromARGB(255, 33, 45, 51),
              onPressed: () async {
                setState(() {
                  isloading = true;
                });

                try {
                  final model = GenerativeModel(
                    model: 'gemini-1.5-flash-latest',
                    apiKey: "AIzaSyCcLWJMgkqSXzYNF_ND9qWY1RIhiHYUDKU",
                  );
                  String prompt =
                      '${widget.markdownContent} on basis of this generate some 5-10 quize from easy to hard with options and all ans in last after some blank lines pass add some note in last that practice youself etc like this';
                  final content = [Content.text(prompt)];
                  final response = await model.generateContent(content);
                  // print(response.text);
                  final data = response.text;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MarkdownDisplayScreen(
                                markdownContent: data!,
                                title: "Quizzes",
                                quizepage: true,
                              )));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                } finally {
                  setState(() {
                    isloading = false;
                  });
                }

                setState(() {
                  isloading = false;
                });
              },
              label: const Text(
                "Generate Quizzes",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              icon: isloading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
            ),
    );
  }
}
