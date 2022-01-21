import 'package:flutter/material.dart';
import '../models/user.dart';

class UserComponent extends StatelessWidget {
  final UsersInfo user;

  UserComponent({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.person),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.displayName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(user.email),
            SizedBox(
              height: 5.0,
            ),
          ],
        ),
        subtitle: Text(user.role),
      ),
    );
  }
}
