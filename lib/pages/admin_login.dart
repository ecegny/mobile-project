import 'package:admin_control/data/db_helper.dart';
import 'package:flutter/material.dart';

import 'admin_home.dart';
import 'admin_signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  late Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter name";
                        }
                        return null;
                      },
                      style: getTextStyle(),
                      decoration: customInputDecoration("Enter name"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Password";
                        }
                        return null;
                      },
                      style: getTextStyle(),
                      decoration: customInputDecoration("Enter password"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          DbHelper.instance
                              .checkAdminLogin(_nameController.text,
                                  _passwordController.text)
                              .then((result) {
                            if (result == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Please enter valid details")));
                            } else {
                              goToAdminHome();
                            }
                          });
                        }
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        )),
                        backgroundColor: MaterialStateProperty.all(Colors.pink),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    TextButton(
                      child: const Text("Don't have account, Signup?"),
                      onPressed: () {
                        goToSignup();
                      },
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }

  void goToSignup() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignupPage()));
  }

  Future<void> goToAdminHome() async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AdminHomePage()));
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
}
