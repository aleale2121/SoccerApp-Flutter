import 'package:flutter/material.dart';
import 'package:soccer_app/blocs/user/user.dart';
import 'package:soccer_app/util/util.dart';
import 'login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soccer_app/models/model.dart';

class DeleteAccountPage extends StatelessWidget {
  static const String routeName = "user_delete_account";

  @override
  Widget build(BuildContext context) {
    // final us = BlocProvider.of<UserBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Delete Account"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              "Are You Sure You want to delete your Account??",
              style: TextStyle(color: Colors.redAccent),
            ),
            TextButton(
                onPressed: () async {
                  Util util = new Util();
                  UsersInfo? user = await util.getUserInformation();
                  if (user != null) {
                    context.read<UserBloc>().add(
                          DeleteUser(
                            userId: user.uuid!,
                          ),
                        );
                    Navigator.of(context).pushNamed(LoginScreen.routeName);
                  }
                },
                child: Text("YES")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("No"))
          ],
        ),
      ),
    );
  }
}
