import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movieapp/style/theme.dart' as Style;
import 'home_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _emailEditController = TextEditingController();
  final _passwordEditController = TextEditingController();
  bool isloading = false;
  String passwordPattern = r'^[a-zA-Z0-9]{6,}$';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      body: isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light,
                child: Stack(
                  children: [
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      //color: Colors.black,
                      child: SingleChildScrollView(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Sign In",
                              style: TextStyle(
                                  fontSize: 50,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                              controller: _emailEditController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) => (value.isEmpty)
                                  ? ' Please enter email'
                                  : null,
                              textAlign: TextAlign.center,
                              decoration: customInputDecoration("Enter email"),
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                              controller: _passwordEditController,
                              obscureText: true,
                              validator: (value) {
                                RegExp regex = RegExp(passwordPattern);
                                if (!regex.hasMatch(value)) {
                                  return 'Password should be in alphanumaric with 6 characters';
                                } else {
                                  return null;
                                }
                              },
                              textAlign: TextAlign.center,
                              decoration:
                                  customInputDecoration("Enter password"),
                            ),
                            SizedBox(height: 80),
                            ElevatedButton(
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: login,
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => SignupScreen(),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Don't have an Account ?",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  SizedBox(width: 10),
                                  Hero(
                                    tag: '1',
                                    child: Text(
                                      'Sign up',
                                      style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600]),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> login() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isloading = true;
      });
      try {
        await _auth.signInWithEmailAndPassword(
            email: _emailEditController.text,
            password: _passwordEditController.text);
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (contex) => HomeScreen(),
          ),
        );
        setState(() {
          isloading = false;
        });
      } on FirebaseAuthException catch (e) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Login Failed"),
            content: Text('${e.message}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Okay'),
              )
            ],
          ),
        );
        print(e);
      }
      setState(() {
        isloading = false;
      });
    }
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
