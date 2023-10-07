import 'package:flutter/material.dart';

class DuaViewPage extends StatelessWidget {
  const DuaViewPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo details page'),
      ),
      body: const Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Title',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 30.0,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Demo details page',
                  style: TextStyle(
                    color: Colors.black54,
                    height: 1.5,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
