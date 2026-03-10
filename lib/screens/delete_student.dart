import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

class DeleteStudentScreen extends StatefulWidget {
  const DeleteStudentScreen({super.key});

  @override
  State<DeleteStudentScreen> createState() => _DeleteStudentScreenState();
}

class _DeleteStudentScreenState extends State<DeleteStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController idController = TextEditingController();

  final FirebaseService firebaseService = FirebaseService();

  Future<void> deleteStudent() async {
    String id = idController.text;

    await firebaseService.deleteStudent(id);

    idController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Student Deleted")),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delete Student"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            children: [
              TextFormField(
                controller: idController,
                decoration: const InputDecoration(
                  labelText: "Student ID",
                ),

                validator: (value) => 
                  value == null || value.isEmpty
                    ? "Enter Student ID"
                    : null,
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      deleteStudent();
                    }

                  },

                  child: const Text("Delete"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}