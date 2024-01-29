import 'package:flutter/material.dart';
import 'package:trinity_wizards_interview_app/constants/app_color.dart';
import 'package:trinity_wizards_interview_app/models/user.dart';

class UserDetailsPage extends StatelessWidget {
  final User user;
  const UserDetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: FlexibleSpaceBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  // Handle cancel action
                },
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Handle save action
                },
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.grey.withOpacity(0.1),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Divider(
            height: 1.0,
            color: Colors.grey,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          const CircleAvatar(
            radius: 40.0,
            backgroundColor: AppColors.primaryColor,
          ),
          const SizedBox(
            height: 24,
          ),
          const TitleWidget(title: 'Main Information'),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                text: user.firstName,
                title: 'FisrtName',
              ),
              const SizedBox(
                height: 4,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Divider(),
              ),
              const SizedBox(
                height: 4,
              ),
              TextFieldWidget(
                text: user.lastName,
                title: 'Last Name',
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Divider(),
              ),
            ],
          ),
          const TitleWidget(title: 'Sub Information'),
          Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                text: user.email,
                title: 'Email',
              ),
              const SizedBox(
                height: 4,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Divider(),
              ),
              const SizedBox(
                height: 4,
              ),
              TextFieldWidget(
                text: user.dob,
                title: 'DOB',
                icon: Icons.calendar_month,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Divider(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget(
      {super.key, required this.title, required this.text, this.icon});
  final String title;
  final String text;
  final IconData? icon;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();

    _textEditingController = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 8,
        ),
        Expanded(
          flex: 2,
          child: Text(
            widget.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          flex: 4,
          child: TextField(
            controller: _textEditingController,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              suffixIcon: Icon(
                widget.icon,
                color: Colors.grey,
              ),
              hintText: 'Enter Text',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey
                      .withOpacity(0.1), // Border color when not focused
                  width: 1.0,
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
      ],
    );
  }
}

class TitleWidget extends StatelessWidget {
  final String title;
  const TitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.grey.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
