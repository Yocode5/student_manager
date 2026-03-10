import 'package:flutter/material.dart';
import 'create_student.dart';
import 'read_student.dart';
import 'delete_student.dart';

class HomeNavigation extends StatefulWidget {
  const HomeNavigation({super.key});

  @override
  State<HomeNavigation> createState() => _HomeNavigationState(); 
}

class _HomeNavigationState extends State<HomeNavigation> {
  
  int _currentIndex = 0;

  final List<Widget> pages = [
    const CreateStudentScreen(),
    const ReadStudentScreen(),
    const DeleteStudentScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      body: pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.indigoAccent,

        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Create",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Read",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.delete),
            label: "Delete",
          ),

        ],
      ),
    );
  }
}