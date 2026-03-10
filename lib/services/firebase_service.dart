import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/student_model.dart';

class FirebaseService {
  
  final CollectionReference students = 
    FirebaseFirestore.instance.collection('students');

  //Create 
  Future<void> addStudent(Student student) async {
    await students.doc(student.id).set(student.toMap());
  }

  //Read
  Stream<QuerySnapshot> getStudents() {
    return students.snapshots();
  }

  //Update
  Future<void> updateStudent(Student student) async {
    await students.doc(student.id).update(student.toMap());
  }

  //Delete
  Future<void> deleteStudent(String id) async {
    await students.doc(id).delete();
  }
}