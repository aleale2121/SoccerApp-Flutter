import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:soccer_pp/screens/login_screen.dart';
void main(){
  testWidgets("login screen",(WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: LoginScreen(),));
    var usernameTextfield=find.byKey(Key("username"));
    var passwordTextfield=find.byKey(Key("password"));
    var login=find.byKey(Key("login"));
    await expect(usernameTextfield,findsOneWidget);
    await tester.enterText(usernameTextfield, "admin@gmail.com");
    await expect(passwordTextfield,findsOneWidget);
    await tester.enterText(passwordTextfield, "23782378");
    await tester.tap(login);
    await tester.pump(Duration(seconds: 20));







  });
}
