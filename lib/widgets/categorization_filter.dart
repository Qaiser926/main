
import 'package:flutter/material.dart';




class CategoryFilter extends StatefulWidget {
  CategoryFilter({super.key}) {}

  @override
  State<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  _CategoryFilterState() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // per category a drop down

        ListTile(
          leading: new Icon(Icons.photo),
          title: new Text('Photo'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: new Icon(Icons.music_note),
          title: new Text('Music'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: new Icon(Icons.videocam),
          title: new Text('Video'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: new Icon(Icons.share),
          title: new Text('Share'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
