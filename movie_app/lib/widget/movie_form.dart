import 'package:movie_app/db_operations.dart';
import 'package:movie_app/model/movie_item.dart';
import 'package:movie_app/str_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieForm extends StatefulWidget {
  final int index;
  MovieObject movieObject;

  MovieForm({Key key, this.index, this.movieObject}) : super(key: key);

  @override
  _MovieFormState createState() => _MovieFormState();
}

class _MovieFormState extends State<MovieForm> {
  //final _auth = FirebaseAuth.instance;
  String movieName;
  String movieDirector;
  String movieUrl;
  Map<String, dynamic> movieMap={};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Movie/ Edit Movie'),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.text,
              onChanged: (value) {
                movieName = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter Movie Name',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              onChanged: (value) {
                movieDirector = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter Director Name',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              onChanged: (value) {
                movieUrl = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter Image Url',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () async {
                    try {
                      if (movieName != null) {
                        widget.movieObject.title = movieName;
                      }
                      if (movieDirector != null) {
                        widget.movieObject.directorName = movieDirector;
                      }
                      if (movieUrl != null) {
                        widget.movieObject.movieImage = movieUrl;
                      }
                      movieMap[kMovieName] = movieName;
                      movieMap[kDirectorName] = movieDirector;
                      movieMap[kMovieUrl] = movieUrl;
                      await DbOperations.insertMovieRecords(movieMap);
                      Navigator.pop(context);
                      /*final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                      if (newUser != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }*/
                    } catch (e) {
                      print(e);
                    }
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
