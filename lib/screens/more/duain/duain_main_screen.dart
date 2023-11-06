// ignore_for_file: prefer_final_fields

import 'package:animations/animations.dart';
import 'package:darulehsan/screens/more/duain/dua_view_screen.dart';
import 'package:flutter/material.dart';

class DuainMainScreen extends StatefulWidget {
  const DuainMainScreen({super.key});

  @override
  // ignore: no_logic_in_create_state, library_private_types_in_public_api
  _DuainMainScreen createState() => _DuainMainScreen();
  }
class _DuainMainScreen extends State<DuainMainScreen>{
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: const Text('Duain'),),
      body: ListView(
            padding: const EdgeInsets.all(8.0),
              children: <Widget>[
          ...List<Widget>.generate(10, (int index) {
            return OpenContainer<bool>(
              openBuilder: (BuildContext _, openContainer) {
                return const DuaViewPage();
              },
              closedShape: const RoundedRectangleBorder(),
              closedElevation: 0.0,
              closedBuilder: (BuildContext _, VoidCallback openContainer) {
                return ListTile(
                  onTap: openContainer,
                  title: const Text('Title item {index + 1}'),
                  subtitle: const Text('subtitle text'),
                );
              },
            );
          }),
        ],
      ),
    );
    
            
  }

}