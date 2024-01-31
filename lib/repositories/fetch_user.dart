import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:trinity_wizards_interview_app/models/user.dart';

Future<List<User>> fetchUsers() async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/data.json');

    String jsonString = await file.readAsString();

    List<dynamic> jsonData = jsonDecode(jsonString);

    List<User> users = jsonData.map((json) => User.fromMap(json)).toList();

    return users;
  } catch (e) {
    print('Error fetching users: $e');
    rethrow;
  }
}

Future<void> updateUser(User updatedUser) async {
  try {
    List<User> users = await fetchUsers();

    int index = users.indexWhere((user) => user.id == updatedUser.id);

    if (index != -1) {
      users[index] = updatedUser;
      await saveUsers(users);
    }
  } catch (e) {
    print('Error updating user: $e');
    rethrow;
  }
}

Future<void> saveUsers(List<User> users) async {
  try {
    List<Map<String, dynamic>> jsonData =
        users.map((user) => user.toMap()).toList();
    String jsonString = jsonEncode(jsonData);

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/data.json');

    await file.writeAsString(jsonString);
  } catch (e) {
    print('Error saving users: $e');
    rethrow;
  }
}

Future<void> addNewUser(User newUser) async {
  try {
    List<User> users = await fetchUsers();

    // Generate a unique ID
    String newId = UniqueKey()
        .toString(); // You can use any other method to generate a unique ID

    newUser = newUser.copyWith(id: newId);

    users.add(newUser);

    await saveUsers(users);
  } catch (e) {
    print('Error adding new user: $e');
    rethrow;
  }
}
