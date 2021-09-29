import 'package:movie_app/model/movie_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class MovieCard extends StatelessWidget {
  final MovieObject item;
  final Animation animation;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const MovieCard({
    @required this.item,
    @required this.animation,
    @required this.onDelete,
    @required this.onEdit,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ScaleTransition(
        scale: animation,
        child: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Card(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(item.movieImage),
                  ),
                ),
                Column(
                  children: [
                    Text(item.title,style: TextStyle(fontSize: 20.0),),
                    Text("Directed By:" + " " + item.directorName)
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.green, size: 16),
                        onPressed: onDelete,
                      ),
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.green, size: 16),
                        onPressed: onEdit,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ), /*ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              leading: CircleAvatar(
                radius: 32,
                backgroundImage: NetworkImage(item.movieImage),
              ),
              title: Text(item.title, style: TextStyle(fontSize: 20)),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.green, size: 16),
                onPressed: onEdit,
              )),*/
        ),
      );
}
