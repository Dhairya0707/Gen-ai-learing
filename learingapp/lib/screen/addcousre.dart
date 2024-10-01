import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learingapp/provider/course_provider.dart';

class AddCourseScreen extends StatefulWidget {
  const AddCourseScreen({Key? key}) : super(key: key);

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> difficultyLevels = [
    'Beginner',
    'Intermediate',
    'Advanced'
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<CourseProvider>(
      builder: (context, CourseProvider provider, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 10,
            title: const Text(
              "Add New Course",
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      _buildTextField('Enter course name', provider.courseName,
                          hint: 'e.g., Mathematics, Python, History'),
                      const SizedBox(height: 20),
                      _buildTextField(
                          'Specific focus (optional)', provider.specificFocus,
                          hint: 'e.g., Algebra, Web Scraping, World War II'),
                      const SizedBox(height: 20),
                      _buildDropdown('Difficulty Level', provider),
                      const SizedBox(height: 40),
                      const Spacer(),
                      _buildSubmitButton(provider),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {String? hint}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        if (label.contains('(optional)')) return null;
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  Widget _buildDropdown(String label, CourseProvider provider) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
      ),
      value: provider.difficultyLevel,
      items: difficultyLevels.map((String level) {
        return DropdownMenuItem<String>(
          value: level,
          child: Text(level),
        );
      }).toList(),
      onChanged: (String? newValue) {
        // if (newValue != null) {
        provider.setDifficultyLevel(newValue!);
        // }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a difficulty level';
        }
        return null;
      },
    );
  }

  Widget _buildSubmitButton(CourseProvider provider) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            provider.addCourse(context);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 33, 45, 51),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: provider.isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                'Create Course by AI',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
      ),
    );
  }
}
