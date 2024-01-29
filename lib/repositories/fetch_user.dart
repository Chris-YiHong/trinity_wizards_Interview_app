import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:trinity_wizards_interview_app/models/user.dart';

Future<List<User>> fetchUsers() async {
  try {
    String jsonString = await rootBundle.loadString('assets/data.json');

    List<dynamic> jsonData = jsonDecode(jsonString);

    List<User> users = jsonData.map((json) => User.fromMap(json)).toList();

    return users;
  } catch (e) {
    print('Error fetching users: $e');
    rethrow;
  }
}
