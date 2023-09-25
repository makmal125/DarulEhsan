// ignore_for_file: unnecessary_new

import 'dart:async';
import 'package:darulehsan/customer_animation_bottom_bar.dart';
import 'package:darulehsan/home/books_title_more_1.dart';
import 'package:darulehsan/home/other_books.dart';
import 'package:darulehsan/home/widgets/appBarHomeSwiper.dart';
import 'package:darulehsan/home/widgets/booksTitleHomePage.dart';
import 'package:darulehsan/home/widgets/marqueeHomePage.dart';
import 'package:darulehsan/home/widgets/sliverDivider.dart';
import 'package:darulehsan/utilities/keys.dart';
import 'package:darulehsan/videos/video_main.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const rowDivider = SizedBox(width: 20);
const sliverColDivider = SizedBox(height: 10);
const tinySpacing = 3.0;
const smallSpacing = 10.0;
const double cardWidth = 115;
const double widthConstraint = 450;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: SUPABASE_URL,
      anonKey: SUPABASE_API_KEY);
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
  int _currentIndex = 0;
  Color _bottom_bar_color = Colors.white;

  final _inactiveColor = Colors.grey;
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
      backgroundColor: Colors.white,
      body: getBody(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _pushAddTodoScreen,
      //   tooltip: 'Increment',
      //   elevation: 8.0,
      //   child: const Icon(Icons.add),
      // ),
      bottomNavigationBar: _buildBottomBar(),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // ignore: unused_element
  void _pushAddTodoScreen() {
    // ignore: avoid_print
    print("hello floating");
  }

  Widget getBody() {
    List<Widget> pages = [
      CustomScrollView(slivers: [
        SliverAppBar(
          backgroundColor: const Color.fromRGBO(248, 147, 0, 1),
          elevation: 0,
          pinned: true,
          stretch: true,
          expandedHeight: 240,
          excludeHeaderSemantics: true,
          floating: false,
          flexibleSpace: FlexibleSpaceBar(
            title: Container(
              margin: const EdgeInsets.fromLTRB(60, 0, 60, 0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('images/header.png'),
                  ]),
            ),
            expandedTitleScale: 1,
            collapseMode: CollapseMode.pin,
            background: const HomeAppBarSwiper(),
            centerTitle: true,
          ),
        ),
        const HomePageMarquee(),
        BooksTitleHomePage(title: 'مقا لا تِ حکمت'),
        makalatBooksList('Read_Makalat_', 31, 'مقا لا تِ حکمت'),
        const SliverDivider(),
        BooksTitleHomePage(title: "ترتیب شریف"),
        makalatBooksList('Read_Tarteeb_', 6, "ترتیب شریف"),
        const SliverDivider(),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return otherBooks();
          }, childCount: 1),
        )
      ]),
      Container(
        alignment: Alignment.center,
        child: const Text(
          "Images",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      const YoutubeHomeScreen(),
      Container(
        alignment: Alignment.center,
        child: const Text(
          "Settings",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }

  Widget _buildBottomBar() {
    return CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: _bottom_bar_color,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() {
        _currentIndex = index;
        if(_currentIndex ==  2){
          _bottom_bar_color = const Color.fromRGBO(15, 15, 15, 1);
        }else{
          _bottom_bar_color = Colors.white;
        }
      }),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: const Icon(Icons.apps),
          title: const Text('Home'),
          activeColor: const Color.fromRGBO(248, 147, 0, 1),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(FontAwesomeIcons.image),
          title: const Text('Images'),
          activeColor: Colors.purpleAccent,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(FontAwesomeIcons.youtube),
          title: const Text(
            'Videos',
          ),
          activeColor: const Color.fromRGBO(255, 0, 0, 1),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.settings),
          title: const Text('Settings'),
          activeColor: Colors.green,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
