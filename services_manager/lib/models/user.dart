import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:services_manager/models/task.dart';

class User {
  User(
      {this.confirmPassword = "",
      this.password = "",
      this.id = "",
      this.name = "",
      this.email = "",
      this.admin = false,
      this.tasks});
  // String confirmPassword;
  String id;
  String name;
  String email;
  String password;
  String confirmPassword;
  bool admin;
  List<Task>? tasks;

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('users/$id');

  Future<void> saveData() async {
    await firestoreRef.set(toMap());
  }

  factory User.fromDocument(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return User(
      id: document.id,
      name: data['name'],
      email: data['email'],
    );
  }

  // User.fromDocuemnt(DocumentSnapshot document) {
  //   Map<String, dynamic> data = document.data() as Map<String, dynamic>;
  //   id = document.id;
  //   name = data['name'];
  //   email = data['email'];
  // }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }
}
