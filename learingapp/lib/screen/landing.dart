// import 'package:flutter/material.dart';

// class LandingScreen extends StatefulWidget {
//   const LandingScreen({super.key});

//   @override
//   State<LandingScreen> createState() => _LandingScreenState();
// }

// ignore_for_file: use_full_hex_values_for_flutter_colors

// class _LandingScreenState extends State<LandingScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Gem Study',
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         elevation: 0,
//         centerTitle: false,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Your Personalized Learning Companion',
//                     style: TextStyle(
//                       fontSize: 36,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue[800],
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     'Study smarter, not harder with Gem Study.',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.grey[700],
//                     ),
//                   ),
//                   const SizedBox(height: 32),
//                   Wrap(
//                     spacing: 8,
//                     runSpacing: 8,
//                     children: [
//                       Chip(
//                         label: const Text('Personalized Learning'),
//                         backgroundColor: Colors.blue[100],
//                       ),
//                       Chip(
//                         label: const Text('Adaptive Quizzes'),
//                         backgroundColor: Colors.green[100],
//                       ),
//                       Chip(
//                         label: const Text('Expert Guidance'),
//                         backgroundColor: Colors.yellow[100],
//                       ),
//                       Chip(
//                         label: const Text('Progress Tracking'),
//                         backgroundColor: Colors.pink[100],
//                       ),
//                       Chip(
//                         label: const Text('Community Support'),
//                         backgroundColor: Colors.purple[100],
//                       ),
//                       Chip(
//                         label: const Text('Learning Resources'),
//                         backgroundColor: Colors.orange[100],
//                       ),
//                       Chip(
//                         label: const Text('Feedback System'),
//                         backgroundColor: Colors.teal[100],
//                       ),
//                       Chip(
//                         label: const Text('Goal Setting'),
//                         backgroundColor: Colors.indigo[100],
//                       ),
//                       Chip(
//                         label: const Text('Gamification'),
//                         backgroundColor: Colors.red[100],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 64),
//                   // const Spacer(),
//                   // Expanded(child: Container()),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         print('Navigate to Login Page');
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue[800],
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(32),
//                         ),
//                       ),
//                       child: const Text(
//                         'Join Gem Study Today',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       // floatingActionButton: FloatingActionButton.extended(
//       //   onPressed: () {},
//       //   backgroundColor: Colors.blue[800]!,
//       //   icon: const Icon(
//       //     Icons.arrow_forward_rounded,
//       //     color: Colors.white,
//       //   ),
//       //   label: const Text(
//       //     'Join Gem Study Today',
//       //     style: TextStyle(
//       //       fontSize: 20,
//       //       fontWeight: FontWeight.bold,
//       //       color: Colors.white,
//       //     ),
//       //   ),
//       // ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:learingapp/login/register.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x770086ad9),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.60,
                child: Container(
                  child: Center(
                      child: Image.asset(
                    "asset/img1.png",
                    height: MediaQuery.of(context).size.height * 0.4,
                  )),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.40,
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.white),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.40,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Welcome to Gem Study!",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 33, 45, 51),
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Your personalized learning Gem",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 33, 45, 51),
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Gem Study's adaptive learning technology tailors your study experience to your individual needs, ensuring you learn at your own pace and focus on areas where you need the most support.",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black54),
                              ),
                            ),
                            // Spacer(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
                              child: _buildSubmitButton(),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RegisterScreen()));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 33, 45, 51),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Start With Gem !',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
