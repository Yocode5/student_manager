import 'package:flutter/material.dart';
import 'package:student_manager/models/student_model.dart';
import 'package:student_manager/services/firebase_service.dart';

class UpdateStudentScreen extends StatefulWidget{
  final Student student;

  const UpdateStudentScreen({super.key, required this.student});

  @override
  State<UpdateStudentScreen> createState() => _UpdateStudentScreenState();
}

class _UpdateStudentScreenState extends State<UpdateStudentScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController idController;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController courseController;
  late TextEditingController ageController;

  final FirebaseService firebaseService = FirebaseService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    idController = TextEditingController(text: widget.student.id);
    nameController = TextEditingController(text: widget.student.name);
    emailController = TextEditingController(text: widget.student.email);
    courseController = TextEditingController(text: widget.student.course);
    ageController = TextEditingController(text: widget.student.age.toString());
  }

  Future<void> updateStudent() async {
    String newId = idController.text;

    Student updatedStudent = Student(
      id: newId,
      name: nameController.text,
      email: emailController.text,
      course: courseController.text,
      age: int.parse(ageController.text),
    );

    if (newId != widget.student.id) {
      await firebaseService.addStudent(updatedStudent);

      await firebaseService.deleteStudent(widget.student.id);
    }
    else {
      await firebaseService.updateStudent(updatedStudent);
    }

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Student Updated")),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Student"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            children: [
              TextFormField(
                controller: idController,
                decoration: const InputDecoration(labelText: "ID"),
                validator: (value) => 
                  value == null || value.isEmpty ? "Enter ID": null,
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) => 
                  value == null || value.isEmpty ? "Enter Name": null,
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) => 
                  value == null || value.isEmpty ? "Enter Email": null,
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: courseController,
                decoration: const InputDecoration(labelText: "Course"),
                validator: (value) => 
                  value == null || value.isEmpty ? "Enter Course": null,
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: ageController,
                decoration: const InputDecoration(labelText: "Age"),
                validator: (value) => 
                  value == null || value.isEmpty ? "Enter Age": null,
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      updateStudent();
                    }

                  },
                  child: const Text("Update"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}