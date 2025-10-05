import 'package:flutter/material.dart';
import '../models/user.dart';

class UserTile extends StatelessWidget {
  final User user;
  final VoidCallback onTap;
  const UserTile({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(user.name),
        subtitle: Text(user.isOnline ? 'Online' : 'Offline'),
        leading: CircleAvatar(
          backgroundColor: user.isOnline ? Colors.green : Colors.grey,
          child: Text(user.name[0]),
        ),
        onTap: onTap,
      ),
    );
  }
}
