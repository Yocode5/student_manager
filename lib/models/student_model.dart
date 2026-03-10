class Student {
  String id;
  String name;
  String email;
  String course;
  int age;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.course,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'course': course,
      'age': age,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map, String documentId) {
    return Student(
      id: documentId,
      name: map['name'],
      email: map['email'],
      course: map['course'],
      age: map['age'],
    );
  }
}