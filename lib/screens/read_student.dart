import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_manager/models/student_model.dart';
import 'package:student_manager/screens/update_student.dart';
import '../services/firebase_service.dart';

class ReadStudentScreen extends StatelessWidget {
  const ReadStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final FirebaseService firebaseService = FirebaseService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Students"),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: firebaseService.getStudents(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No students found",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          var students = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: students.length,

            itemBuilder: (context, index) {
              var student = students[index];
              var data = student.data() as Map<String, dynamic>? ?? {};

              return Card(
                color: const Color.fromARGB(255, 58, 127, 247),
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(16),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text(
                            (data['name'] ?? "unknown").toString(),
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),

                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Student selectedStudent = Student(
                                id: student.id,
                                name: data['name'],
                                email: data['email'],
                                course: data['course'],
                                age: data['age'],
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateStudentScreen(
                                    student: selectedStudent,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Student ID: ${student.id}",
                        style: const TextStyle(fontSize: 16, color: Colors.white,),
                        
                      ),

                      const SizedBox(height: 4),

                      Text(
                        "Email: ${data['email'] ?? "N/A"}",
                        style: const TextStyle(fontSize: 16, color: Colors.white,), 
                      ),

                      const SizedBox(height: 4),

                      Text(
                        "Course: ${data['course'] ?? "N/A"}",
                        style: const TextStyle(fontSize: 16, color: Colors.white,),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        "Age: ${data['age'] ?? "N/A"}",
                        style: const TextStyle(fontSize: 16, color: Colors.white,),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}