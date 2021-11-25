//import 'package:admin_control/pages/admin_login.dart';

import 'package:admin_control/pages/user_login.dart';
import 'package:flutter/material.dart';

//bilalth schbth123 admin
//a@gmail.com abc123 user
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: UserLoginPage(),
    );
  }
}
