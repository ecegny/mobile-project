import 'package:flutter/foundation.dart';
import 'package:admin_control/data/db_helper.dart';
import 'package:admin_control/models/movie.dart';
import 'package:admin_control/models/user.dart';
import 'package:admin_control/pages/user_login.dart';
import 'package:flutter/material.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return UserHomeState();
  }
}

class UserHomeState extends State {
  late Size size;
  User user = User(" ", " ", " ", " ");
  late List<Movie> movies;
  int movieCount = 0;
  @override
  void initState() {
    super.initState();
    DbHelper.instance.getUserData().then((result) {
      setState(() {
        user = result;
      });
    });
    refreshMovies();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
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
                        deleteUser();
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
                )
              ],
            ),
            SizedBox(
              height: size.height - 200,
              child: Center(
                child:
                    // ignore: unnecessary_null_comparison
                    (user == null) ? null : Text("Welcome User " + user.email),
              ),
            ),
          ],
        ));
  }

  void deleteUser() async {
    await DbHelper.instance.deleteUser(user.email).then((res) {
      if (res == 1) {
        goToUserLogin();
      }
    });
  }

  void goToUserLogin() async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const UserLoginPage()));
  }

  void refreshMovies() async {
    //data dolunca statein etkilediği bütün alanlar çalışacak
    var moviesFuture = DbHelper.instance.getMovies();
    moviesFuture.then((data) {
      movies = data;
      movieCount = data.length;
      //bu data bizim db_Helper daki getProducts funcından dönen List<Movie>ımız
    });
    // ignore: avoid_print
    debugPrint('working');
    debugPrint('$movieCount');
    //ürünler geldiğinde = then
  }

  buildMovieList() {
    return ListView.builder(
        itemCount: movieCount,
        itemBuilder: (BuildContext context, int position) {
          return Card(
              //her bir elemanı return ediyo
              color: Colors.cyan,
              elevation: 2.0,
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.black12,
                  child: Text("p"),
                ),
                title: Text(movies[position].movieName),
                subtitle: Text(movies[position].description),
              ));
        });
  }
}
