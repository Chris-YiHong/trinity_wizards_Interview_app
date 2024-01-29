import 'package:flutter/material.dart';
import 'package:trinity_wizards_interview_app/constants/app_color.dart';
import 'package:trinity_wizards_interview_app/models/user.dart';
import 'package:trinity_wizards_interview_app/pages/user_details_page.dart';
import 'package:trinity_wizards_interview_app/repositories/fetch_user.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<User> users = [];
  String error = '';
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  void _fetchUsers() async {
    try {
      setState(() => loading = true);
      users = await fetchUsers();
      error = '';
    } catch (e) {
      error = e.toString();
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.1),
        title: const Text(
          'Contacts',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.search,
            color: AppColors.primaryColor,
            size: 36,
          ),
          onPressed: () {
            //TODO: For now no actions
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: AppColors.primaryColor,
              size: 36,
            ),
            onPressed: () {},
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Divider(
            height: 1.0,
            color: Colors.grey,
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return GridUser(
            user: user,
          );
        },
      ),
    );
  }
}

class GridUser extends StatelessWidget {
  final User user;

  GridUser({required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => UserDetailsPage(user: user),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 40.0,
              backgroundColor: AppColors.primaryColor,
            ),
            const SizedBox(height: 8.0),
            Text(
              '${user.firstName} ${user.lastName}',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
