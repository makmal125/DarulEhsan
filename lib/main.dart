import 'dart:async';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return bottom_bar();
  }

  // ignore: non_constant_identifier_names
  Scaffold bottom_bar() {
    return Scaffold(
      body: Column(
        children: [
          titleSection,
          MarqueeWidget,
          _booksTitle("MAQALAT-E-HIKMAT")
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _pushAddTodoScreen,
      //   tooltip: 'Increment',
      //   elevation: 8.0,
      //   child: const Icon(Icons.add),
      // ),
      bottomNavigationBar: BottomAppBar(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // ignore: avoid_print
            Expanded(
              child: IconButton(
                icon: const Icon(Icons.book_online_rounded),
                onPressed: () => print('hello fareed'),
              ),
            ),
            // ignore: avoid_print
            Expanded(
              child: IconButton(
                icon: const Icon(Icons.settings_applications),
                onPressed: () => print('hello world'),
              ),
            ),
          ],
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _pushAddTodoScreen() {
    // ignore: avoid_print
    print("hello floating");
  }

  Widget titleSection = Container(
    margin: const EdgeInsets.only(top: 0),
    color: const Color.fromRGBO(248, 147, 0, 1),
    padding: const EdgeInsets.all(32),
    child: Row(
      children: [
        /*1*/
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ignore: sized_box_for_whitespace
            Container(
              width: 100,
              height: 40,
              margin: const EdgeInsets.only(top: 30),
              child: Image.asset('images/Yaqayyum.png'),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ignore: sized_box_for_whitespace
            Container(
                width: 160,
                height: 40,
                margin: const EdgeInsets.only(top: 20),
                child: Image.asset('images/bismillah.png')),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // ignore: sized_box_for_whitespace
            Container(
                width: 100,
                height: 40,
                margin: const EdgeInsets.only(top: 30),
                child: Image.asset('images//Yahayyo.png')),
          ],
        )
      ],
    ),
  );
  // ignore: non_constant_identifier_names, avoid_unnecessary_containers
  Widget MarqueeWidget = Container(
    color: const Color.fromRGBO(236, 196, 166, 100),
    padding: const EdgeInsets.only(top: 10, bottom: 20),
    child: Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 40,
            child: Marquee(
              text:
                  'الهم صلي علي سيدنا محمد النبي الامي و علي اله و اصحابه و عترته بعدد كل معلوم لك و استغفرالله الذي لا اله الا هو الحي القيوم و اتوب اليه يا حي يا قيوم',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.green),
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.end,
              textDirection: TextDirection.rtl,
              blankSpace: 400.0,
              velocity: 50.0,
              pauseAfterRound: const Duration(seconds: 1),
              startPadding: 20.0,
              accelerationDuration: const Duration(seconds: 1),
              accelerationCurve: Curves.linear,
              decelerationDuration: const Duration(milliseconds: 500),
              decelerationCurve: Curves.easeOut,
            ),
          ),
        ),
      ],
    ),
  );
  // ignore: non_constant_identifier_names
  _booksTitle(title) {
    // ignore: avoid_unnecessary_containers
    return Container(
      //padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(top: 20, left: 1, right: 10),
      child: Text(
                title,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  //decoration:TextDecoration.underline,
                  height: 2,
                  //leadingDistribution: TextLeadingDistribution.even,
                  fontFamily: "Agane55",
                  color: Colors.black,
                  shadows: [
                    Shadow(
                      color: Colors.amber,
                    ),
                    Shadow(
                      color: Colors.greenAccent,
                    )
                  ],
                ),
              ),
    );
  }
}
