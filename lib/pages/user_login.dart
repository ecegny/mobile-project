import 'package:admin_control/data/db_helper.dart';
import 'package:admin_control/pages/user_home.dart';
import 'package:admin_control/pages/user_signup.dart';
import 'package:flutter/material.dart';

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return UserLoginState();
  }
}

class UserLoginState extends State {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailEditController = TextEditingController();
  final _passwordEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    buildEmailField(),
                    const SizedBox(
                      height: 20,
                    ),
                    buildPasswordField(),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          login();
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
                        goToUserSignup();
                      },
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }

  buildEmailField() {
    return TextFormField(
      controller: _emailEditController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          return "Enter email";
        }
        return null;
      },
      style: getTextStyle(),
      decoration: customInputDecoration("Enter email"),
    );
  }

  buildPasswordField() {
    return TextFormField(
      textInputAction: TextInputAction.done,
      controller: _passwordEditController,
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
    );
  }

  void login() {
    DbHelper.instance
        .checkUserLogin(_emailEditController.text, _passwordEditController.text)
        .then((result) {
      if (result == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please enter valid details")));
      } else {
        goToUserHome();
      }
    });
  }

  void goToUserHome() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const UserHomePage()));
  }

  void goToUserSignup() async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const UserSignupPage()));
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
