// ignore_for_file: non_constant_identifier_names

import 'package:darulehsan/screens/home/tasbeeh_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeMainScreen();
}

class _HomeMainScreen extends State<HomeMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(124, 127, 208, 1),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color.fromARGB(255, 49, 51, 120),
        heroTag: 'tesbeehTag',
        label: const Row(
          children: [
            ImageIcon(
              AssetImage("images/tespih.png"),
              color: Colors.red,
              size: 24,
            ),
            Text('عالمی ذکر')
          ],
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const TasbeehMainScreen()));
        },
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              width: 1000,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color.fromARGB(255, 49, 51, 120),
              ),
              child: const Align(
                alignment: AlignmentDirectional(-0.5, 0.4),
                child: Text(
                  '''Hazrat Muhammad Barkat Ali 
                  (Quddes Sirra-ul-Aziz)''',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
