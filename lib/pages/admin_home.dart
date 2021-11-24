import 'package:admin_control/data/db_helper.dart';
import 'package:admin_control/models/admin.dart';
import 'package:flutter/material.dart';

import 'admin_add_movie.dart';
import 'admin_login.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AdminHomeState();
  }
}

class AdminHomeState extends State {
  late Size size;
  Admin admin = Admin("0", "0");
  @override
  void initState() {
    super.initState();
    DbHelper.instance.getAdminData().then((result) {
      setState(() {
        admin = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Admin Home"),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                      onPressed: () {
                        deleteAdmin();
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                        backgroundColor: MaterialStateProperty.all(Colors.pink),
                      ),
                      child: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                      onPressed: () {
                        goToAddMovie();
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                        backgroundColor: MaterialStateProperty.all(Colors.pink),
                      ),
                      child: const Text(
                        "Add Movie",
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
            SizedBox(
              height: size.height - 200,
              child: Center(
                child:
                    // ignore: unnecessary_null_comparison
                    (admin == null)
                        ? null
                        : Text("Welcome Admin " + admin.name),
              ),
            ),
          ],
        ));
  }

  void deleteAdmin() async {
    await DbHelper.instance.deleteAdmin(admin.name).then((res) {
      if (res == 1) {
        goToLogin();
      }
    });
  }

  void goToLogin() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  Future<void> goToAddMovie() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MovieAdd()));
  }
}
