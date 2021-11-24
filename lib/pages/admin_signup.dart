import 'package:admin_control/data/db_helper.dart';
import 'package:admin_control/models/admin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'admin_login.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SignUpState();
  }
}

class SignUpState extends State {
  final _formKey = GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();
  final _nameEditController = TextEditingController();
  final _passwordEditController = TextEditingController();

  String passwordPattern = r'^[a-zA-Z0-9]{6,}$';

  late Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scafoldKey,
      body: Stack(
        children: <Widget>[
          Container(
            color: const Color(0x99FFFFFF),
          ),
          Container(
            height: 120,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.teal),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(size.width / 2),
                  topRight: Radius.circular(size.width / 2)),
              color: Colors.teal,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                // ignore: prefer_const_constructors
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.teal),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.teal,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Registration Form",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        //--------------Name FormFiled------------------------------------------
                        TextFormField(
                          controller: _nameEditController,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Name";
                            }
                            return null;
                          },
                          style: getTextStyle(),
                          decoration: customInputDecoration("Enter Name"),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //--------------Password FormFiled------------------------------------------
                        TextFormField(
                          controller: _passwordEditController,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            RegExp regex = RegExp(passwordPattern);
                            if (!regex.hasMatch(value!)) {
                              return 'Password should be in alphanumaric with 6 characters';
                            } else {
                              return null;
                            }
                          },
                          obscureText: true,
                          style: getTextStyle(),
                          decoration: customInputDecoration("Enter password"),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              addAdmin();
                            }
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            )),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.pink),
                          ),
                          child: const Text(
                            "Signup",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),

                        TextButton(
                          child: const Text("Already have account, Sign In?"),
                          onPressed: () {
                            goToLogin();
                          },
                        )
                      ],
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }

  void addAdmin() async {
    await DbHelper.instance
        .insertAdmin(
            Admin(_nameEditController.text, _passwordEditController.text))
        .then((result) {
      if (result == -1) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Admin with same name already existed $result')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Admin Registered Succesfully $result')));
        goToLogin();
      }
    });
  }

  TextStyle getTextStyle() {
    return const TextStyle(fontSize: 18, color: Colors.pink);
  }

  InputDecoration customInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.teal),
      contentPadding: const EdgeInsets.all(10),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.pink)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.pink)),
    );
  }

  void goToLogin() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}
