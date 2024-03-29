import 'package:flutter/material.dart';
import 'package:trinity_wizards_interview_app/constants/app_color.dart';
import 'package:trinity_wizards_interview_app/models/user.dart';
import 'package:trinity_wizards_interview_app/repositories/fetch_user.dart';
import 'package:intl/intl.dart';
import 'package:trinity_wizards_interview_app/widgets/date_picker_text_field.dart';
import 'package:trinity_wizards_interview_app/widgets/text_field.dart';

class UserDetailsPage extends StatefulWidget {
  final User user;
  final Function onRefresh;

  const UserDetailsPage(
      {super.key, required this.user, required this.onRefresh});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  late TextEditingController _fisrtNameTextEditingController;
  late TextEditingController _lastNameTextEditingController;
  late TextEditingController _emailTextEditingController;
  late TextEditingController _dobTextEditingController;
  String error = '';
  bool loading = false;
  late DateTime initialDate;
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    initialDate = dateFormat.parse(widget.user.dob);
    _fisrtNameTextEditingController =
        TextEditingController(text: widget.user.firstName);
    _lastNameTextEditingController =
        TextEditingController(text: widget.user.lastName);
    _emailTextEditingController =
        TextEditingController(text: widget.user.email);
    _dobTextEditingController = TextEditingController(text: widget.user.dob);
  }

  @override
  void dispose() {
    _fisrtNameTextEditingController.dispose();
    _lastNameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _dobTextEditingController.dispose();

    super.dispose();
  }

  Future<void> _updateUser() async {
    try {
      setState(() => loading = true);

      User newUser = widget.user.copyWith(
        firstName: _fisrtNameTextEditingController.text,
        lastName: _lastNameTextEditingController.text,
        email: _emailTextEditingController.text,
        dob: _dobTextEditingController.text,
      );
      await updateUser(newUser);
      error = '';
    } catch (e) {
      error = e.toString();
    } finally {
      setState(() => loading = false);
      widget.onRefresh();
      Navigator.pop(context);
    }
  }

  Widget buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              error,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: _updateUser,
              child: const Text(
                'Retry',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
                onPressed: () {},
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
                onPressed: () async {
                  await _updateUser();
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
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
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
                        text: widget.user.firstName,
                        title: 'FisrtName',
                        textEditingController: _fisrtNameTextEditingController,
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
                        text: widget.user.lastName,
                        title: 'Last Name',
                        textEditingController: _lastNameTextEditingController,
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
                        text: widget.user.email,
                        title: 'Email',
                        textEditingController: _emailTextEditingController,
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
                      DatePickerTextFieldWidget(
                          textEditingController: _dobTextEditingController,
                          title: 'DOB',
                          text: '',
                          icon: Icons.date_range,
                          initialDate: DateTime.now(),
                          onDateChanged: (_) {}),
                      const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Divider(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
    );
  }
}
