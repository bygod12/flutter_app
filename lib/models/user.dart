import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  int id;
  String name;
  String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      name: json['user']['name'],
      email: json['user']['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return { 'user':{
      'id': id,
      'name': name,
      'email': email,}
    };
  }

}
