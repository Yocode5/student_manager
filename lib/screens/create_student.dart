import 'package:flutter/material.dart';
import '../models/student_model.dart';
import '../services/firebase_service.dart';

class CreateStudentScreen extends StatefulWidget {
  const CreateStudentScreen({super.key});

  @override
  State<CreateStudentScreen> createState() => _CreateStudentScreenState();
}

class _CreateStudentScreenState extends State<CreateStudentScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController courseController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  final FirebaseService firebaseService = FirebaseService();

  Future<void> addStudent() async {
    Student student = Student(
      id: idController.text,
      name: nameController.text,
      email: emailController.text,
      course: courseController.text,
      age: int.parse(ageController.text),
    );

    await firebaseService.addStudent(student);

    idController.clear();
    nameController.clear();
    emailController.clear();
    courseController.clear();
    ageController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Student Added")),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Student"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              const SizedBox(height: 10),

              TextFormField(
                controller: idController,
                decoration: const InputDecoration(labelText: "Student ID"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Students ID is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                  if (!value.contains("@")) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: courseController,
                decoration: const InputDecoration(labelText: "Course"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Course is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: ageController,
                decoration: const InputDecoration(labelText: "Age"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Age is requied";
                  }

                  final age = int.tryParse(value);
                  if (age == null) {
                    return "Enter a valid number";
                  }

                  if (age < 16 || age > 100) {
                    return "Enter a realistic age";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      addStudent();  
                    }
                  }, 
                  child: const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}