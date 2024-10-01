import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learingapp/main.dart';
import 'package:learingapp/provider/home_provider.dart';
import 'package:learingapp/screen/addcousre.dart';
import 'package:learingapp/screen/read_page.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _logout() async {
    await _auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const AuthGate()),
        (route) => false); // Replace with your login route
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, HomeProvider provider, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text(
              "Gem Study",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  provider.refreshCourses();
                },
              ),
            ],
          ),
          // Adding the drawer
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[800],
                  ),
                  child: const Text(
                    'Gem Study',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('About'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('About Gem Study'),
                          content: const Text(
                              'Gem Study is a learning platform where users can generate and manage their own courses with AI-generated content.'),
                          actions: [
                            TextButton(
                              child: const Text('Close'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: _logout, // Log out the user
                ),
              ],
            ),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('users')
                .doc(_auth.currentUser!.uid)
                .collection('course')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.school, size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'No courses available',
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddCourseScreen()),
                          );
                        },
                        child: const Text('Add Your First Course'),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var course = snapshot.data!.docs[index];
                  return _buildCourseCard(course);
                },
              );
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: const Color.fromARGB(255, 59, 128, 162),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddCourseScreen()),
              );
            },
            label: const Text(
              "Add Course",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  // Widget _buildCourseCard(DocumentSnapshot course) {
  //   final createdAtField = course['createdAt'];
  //   DateTime createdAt;

  //   // Check if the createdAtField is a Timestamp and then convert it to DateTime
  //   if (createdAtField is Timestamp) {
  //     createdAt = createdAtField.toDate();
  //   } else {
  //     // Fallback to DateTime.now() if createdAt is not a Timestamp
  //     createdAt = DateTime.now();
  //   }

  //   final formattedDate = DateFormat.yMMMd().format(createdAt);

  //   return Card(
  //     color: const Color.fromARGB(255, 33, 45, 51),
  //     elevation: 4,
  //     margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //     child: InkWell(
  //       onTap: () {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => MarkdownDisplayScreen(
  //               title: course['courseName'],
  //               markdownContent: course['generatedContent'],
  //               quizepage: false,
  //             ),
  //           ),
  //         );
  //       },
  //       child: Container(
  //         padding: const EdgeInsets.all(16),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Expanded(
  //                   child: Text(
  //                     course['courseName'],
  //                     style: const TextStyle(
  //                       fontSize: 20,
  //                       color: Colors.white,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                     maxLines: 1,
  //                     overflow: TextOverflow.ellipsis,
  //                   ),
  //                 ),
  //                 _buildDifficultyBadge(course['difficultyLevel']),
  //               ],
  //             ),
  //             const SizedBox(height: 8),
  //             Text(
  //               course['specificFocus'] ?? 'General',
  //               style: TextStyle(
  //                 fontSize: 16,
  //                 color: Colors.grey[600],
  //               ),
  //               maxLines: 1,
  //               overflow: TextOverflow.ellipsis,
  //             ),
  //             const SizedBox(height: 16),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   'Created on: $formattedDate',
  //                   style: TextStyle(
  //                     fontSize: 14,
  //                     color: Colors.grey[500],
  //                   ),
  //                 ),
  //                 const Icon(
  //                   Icons.arrow_forward_ios,
  //                   size: 16,
  //                   color: Colors.grey,
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildCourseCard(DocumentSnapshot course) {
    final createdAtField = course['createdAt'];
    DateTime createdAt;

    // Check if the createdAtField is a Timestamp and then convert it to DateTime
    if (createdAtField is Timestamp) {
      createdAt = createdAtField.toDate();
    } else {
      // Fallback to DateTime.now() if createdAt is not a Timestamp
      createdAt = DateTime.now();
    }

    final formattedDate = DateFormat.yMMMd().format(createdAt);

    return Card(
      color: const Color.fromARGB(255, 33, 45, 51),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MarkdownDisplayScreen(
                title: course['courseName'],
                markdownContent: course['generatedContent'],
                quizepage: false,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      course['courseName'],
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _buildDifficultyBadge(course['difficultyLevel']),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _showDeleteConfirmationDialog(course.id);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                course['specificFocus'] ?? 'General',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Created on: $formattedDate',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

// Function to show delete confirmation dialog
  void _showDeleteConfirmationDialog(String courseId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Course'),
          content: const Text('Are you sure you want to delete this course?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteCourse(courseId);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

// Function to delete the course from Firestore
  void _deleteCourse(String courseId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('course')
          .doc(courseId)
          .delete();
    }
  }

  Widget _buildDifficultyBadge(String level) {
    Color badgeColor;
    switch (level) {
      case '3':
        badgeColor = Colors.green;
        break;
      case '4':
        badgeColor = Colors.orange;
        break;
      case '5':
        badgeColor = Colors.red;
        break;
      default:
        badgeColor = Colors.blue;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'Level $level',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
