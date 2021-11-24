import 'package:admin_control/data/db_helper.dart';
import 'package:admin_control/models/movie.dart';
import 'package:flutter/material.dart';

import 'admin_home.dart';

class MovieAdd extends StatefulWidget {
  const MovieAdd({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MovieAddState();
  }
}

class MovieAddState extends State {
  final _formKey = GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();
  final _nameEditController = TextEditingController();
  final _descriptionEditController = TextEditingController();
  final _actorsEditController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                              "Add New Movie",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        buildNameField(),
                        const SizedBox(
                          height: 20,
                        ),
                        buildDescriptionField(),
                        const SizedBox(
                          height: 20,
                        ),
                        buildActorsField(),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              addMovie();
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
                            "Add Movie",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }

  buildNameField() {
    return TextFormField(
        controller: _nameEditController,
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter Movie Name";
          }
          return null;
        },
        style: getTextStyle(),
        decoration: customInputDecoration("Enter Movie Name"));
  }

  buildDescriptionField() {
    return TextFormField(
        controller: _descriptionEditController,
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter Movie Descrition";
          }
          return null;
        },
        style: getTextStyle(),
        decoration: customInputDecoration("Movie Description"));
  }

  buildActorsField() {
    return TextFormField(
        controller: _actorsEditController,
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter Movie Actors";
          }
          return null;
        },
        style: getTextStyle(),
        decoration: customInputDecoration("Movie Actors"));
  }

  void addMovie() async {
    await DbHelper.instance
        .insertMovie(Movie(
            actors: _actorsEditController.text,
            description: _descriptionEditController.text,
            movieName: _nameEditController.text))
        .then((result) {
      if (result == -1) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('The movie could not be add $result')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('The movie Added Succesfully $result')));
        goToAdminHome();
      }
    });
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
