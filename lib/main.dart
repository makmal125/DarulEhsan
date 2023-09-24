// ignore_for_file: unnecessary_new

import 'dart:async';
import 'package:darulehsan/home/books_title_more_1.dart';
import 'package:darulehsan/home/other_books.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:marquee/marquee.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const rowDivider = SizedBox(width: 20);
const sliverColDivider = SizedBox(height: 10);
const tinySpacing = 3.0;
const smallSpacing = 10.0;
const double cardWidth = 115;
const double widthConstraint = 450;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: 'https://dsngponqkfiomhhdlhgv.supabase.co', anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRzbmdwb25xa2Zpb21oaGRsaGd2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTUzMDM4NTgsImV4cCI6MjAxMDg3OTg1OH0.EwRd3vTPhIOCytV3Rm5aJYN7oKYloZ--bDsPEY3gJF4');
  runApp(const MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;
  @override
  void initState() {
    _getAuth();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
Future<void> _getAuth() async {
    setState(() {
      user = Supabase.instance.client.auth.currentUser;
    });
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      setState(() {
        user = data.session?.user;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return bottom_bar();
  }

  // ignore: non_constant_identifier_names
  Scaffold bottom_bar() {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          backgroundColor: const Color.fromRGBO(248, 147, 0, 1),
          elevation: 0,
          pinned: true,
          stretch: true,
          expandedHeight: 260,
          excludeHeaderSemantics: true,
          floating: false,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text(
              "دارلاحسان",
              style: TextStyle(
                  color: Color.fromRGBO(49, 9, 9, 1),
                  fontWeight: FontWeight.bold,
                  fontFamily: "AlBayan",
                  fontSize: 40),
            ),
            expandedTitleScale: 2,
            collapseMode: CollapseMode.pin,
            background: appBarSwiper(),
          ),
        ),
        TitleSection(),
        MarqueeWidget(),
        booksTitle('مقا لا تِ حکمت'),
        makalatBooksList('Read_Makalat_', 31, 'مقا لا تِ حکمت'),
        sliverDivider(),
        booksTitle("ترتیب شریف"),
        makalatBooksList('Read_Tarteeb_', 6, "ترتیب شریف"),
        sliverDivider(),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return otherBooks();
          }, childCount: 1),
        )
      ]),
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
                // ignore: avoid_print
                onPressed: () => print('hello fareed'),
              ),
            ),
            // ignore: avoid_print
            Expanded(
              child: IconButton(
                icon: const Icon(Icons.settings_applications),
                // ignore: avoid_print
                onPressed: () => print('hello world'),
              ),
            ),
          ],
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  SliverToBoxAdapter sliverDivider() {
    return const SliverToBoxAdapter(
      child: Divider(
        height: 20,
        thickness: 5,
        indent: 20,
        endIndent: 20,
        color: Color.fromRGBO(248, 147, 0, 1),
      ),
    );
  }

  Swiper appBarSwiper() {
    var images = [
      'http://darulehsan.pk/assets/img/portfolio/Thumbs/1-06.jpg',
      'http://darulehsan.pk/assets/img/portfolio/Thumbs/1-08.jpg',
      'http://darulehsan.pk/assets/img/portfolio/Thumbs/1-09.jpg',
      'http://darulehsan.pk/assets/img/portfolio/Thumbs/1-26.jpg',
      'http://darulehsan.pk/assets/img/portfolio/Thumbs/4-02.jpg',
    ];
    return Swiper(
      itemCount: images.length,
      itemBuilder: (BuildContext context, int index) => Image.network(
        images[index],
        fit: BoxFit.cover,
      ),
      autoplay: true,
    );
  }

  // ignore: unused_element
  void _pushAddTodoScreen() {
    // ignore: avoid_print
    print("hello floating");
  }

  // ignore: non_constant_identifier_names
  TitleSection() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(top: 0),
        color: const Color.fromRGBO(248, 147, 0, 1),
        padding: const EdgeInsets.fromLTRB(32, 10, 32, 10),
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
                  margin: const EdgeInsets.only(top: 20),
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
                    margin: const EdgeInsets.only(top: 10),
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
                    margin: const EdgeInsets.only(top: 20),
                    child: Image.asset('images//Yahayyo.png')),
              ],
            )
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names, avoid_unnecessary_containers
  MarqueeWidget() {
    return SliverToBoxAdapter(
      child: Container(
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
      ),
    );
  }

  // ignore: non_constant_identifier_names
  booksTitle(title) {
    // ignore: avoid_unnecessary_containers
    return SliverToBoxAdapter(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          alignment: Alignment.topRight,
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.only(top: 5, right: 10),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                //decoration:TextDecoration.underline,
                height: 2,
                //leadingDistribution: TextLeadingDistribution.even,
                fontFamily: "AlBayan",
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
          ),
        ),
      ),
    );
  }
}
