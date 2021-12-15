//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:movieapp/style/theme.dart' as Style;

class Comments extends StatefulWidget {
  final int movieId;
  Comments({Key key, @required this.movieId}) : super(key: key);

  @override
  _CommentsState createState() => _CommentsState(movieId);
}

class _CommentsState extends State<Comments> {
  final int movieId;

  _CommentsState(this.movieId);
  @override
  void initState() {
    super.initState();
    //getCommentsById();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
    // CollectionReference commentRef =
    //     FirebaseFirestore.instance.collection('comments');
    // return Scaffold(
    //     appBar: AppBar(
    //         elevation: 0.3,
    //         centerTitle: true,
    //         backgroundColor: Style.Colors.mainColor,
    //         leading: IconButton(
    //             onPressed: goDetail,
    //             icon: Icon(
    //               Icons.arrow_back_ios_new_outlined,
    //               color: Colors.white,
    //               size: 25,
    //             ))),
    //     body: Column(
    //       children: [
    //         StreamBuilder<QuerySnapshot>(
    //           stream: commentRef.snapshots(),
    //           builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
    //             if (asyncSnapshot.hasError) {
    //               return Text(asyncSnapshot.error.toString());
    //             }
    //             if (!asyncSnapshot.hasData) return CircularProgressIndicator();

    //             List<DocumentSnapshot> listOfComment = asyncSnapshot.data.docs;

    //             return Flexible(
    //               child: ListView.builder(
    //                 itemCount: listOfComment.length,
    //                 // ignore: missing_return
    //                 itemBuilder: (context, index) {
    //                   return ListTile(
    //                     title: Text(
    //                       '${listOfComment[index]['$movieId']}',
    //                       style: TextStyle(
    //                         fontSize: 20.0,
    //                       ),
    //                     ),
    //                   );
    //                 },
    //               ),
    //             );
    //           },
    //         ),
    //       ],
    //     ));
  }

  goDetail() {
    Navigator.pop(context);
  }
}
