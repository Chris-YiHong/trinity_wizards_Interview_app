import 'package:flutter/material.dart';
import 'package:trinity_wizards_interview_app/constants/app_color.dart';
import 'package:trinity_wizards_interview_app/pages/user_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
      ),
      home: UserListPage(),
    );
  }
}
