import 'package:movie_app/model/movie_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../data.dart';
import 'movie_card.dart';
import 'movie_form.dart';

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    @required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final key = GlobalKey<AnimatedListState>();
  final List<MovieObject> items = List.from(Data.movieList);
  FirebaseUser _user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool isSignIn = false;
  bool google = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.deepPurple,
        appBar: AppBar(
          title: Text(widget.title,style: TextStyle(fontSize: 25.0),),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: AnimatedList(
                key: key,
                initialItemCount: items.length,
                itemBuilder: (context, index, animation) =>
                    buildItem(items[index], index, animation),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: buildInsertButton(),
            ),
          ],
        ),
      );

  Widget buildItem(item, int index, Animation<double> animation) => MovieCard(
        item: item,
        animation: animation,
        onDelete: () => removeItem(index),
        onEdit: () {
          editItem(index);
          setState(() {});
        },
      );

  Widget buildInsertButton() => ElevatedButton(
        child: Text(
          'Add Movie',
          style: TextStyle(fontSize: 20),
        ),
        onPressed: () => insertItem(
            0,
            MovieObject(
              title: 'Default',
              directorName: 'Default',
              movieImage:
                  'https://image.flaticon.com/icons/png/512/1804/1804486.png',
            )),
      );

  void insertItem(int index, MovieObject item) {
    if (_user!=null&&_user.isEmailVerified) {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  MovieForm(
                    movieObject: item,
                  )));
      items.insert(index, item);
      key.currentState.insertItem(index);
    } else {
      _showDialog(index, item);
    }
  }

  void removeItem(int index) {
    final item = items.removeAt(index);

    key.currentState.removeItem(
      index,
      (context, animation) => buildItem(item, index, animation),
    );
  }

  void editItem(int index) {
    var ele = items.elementAt(index);
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => MovieForm(
                  movieObject: ele,
                )));
  }

  Future<FirebaseUser> signInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();

    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    AuthResult authResult = await _auth.signInWithCredential(credential);

    _user = authResult.user;

    assert(!_user.isAnonymous);

    assert(await _user.getIdToken() != null);

    FirebaseUser currentUser = await _auth.currentUser();

    assert(_user.uid == currentUser.uid);

    print("User Name: ${_user.displayName}");
    print("User Email ${_user.email}");
    return _user;
  }

  void _showDialog(int index, MovieObject item) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Warning"),
          content: new Text("Need to Login to add movies"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("Sign-In"),
              onPressed: () async {
                try {
                  final user = await signInWithGoogle();
                  if (user != null) {
                    insertItem(index, item);
                  } else {
                    _showDialog2();
                    Navigator.pop(context);
                  }
                } catch (e) {
                  print(e);
                }
              },
            ),
            new TextButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialog2() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Warning"),
          content: new Text("Couldn't Login"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
