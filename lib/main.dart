// ignore_for_file: unnecessary_new

import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:darulehsan/connection_status.dart';
import 'package:darulehsan/customer_animation_bottom_bar.dart';
import 'package:darulehsan/screens/books/books_screen.dart';
import 'package:darulehsan/screens/home/home_screen.dart';
import 'package:darulehsan/screens/more/more_screen.dart';
import 'package:darulehsan/utilities/keys.dart';
import 'package:darulehsan/screens/youtube/channel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

const rowDivider = SizedBox(width: 20);
const sliverColDivider = SizedBox(height: 10);
const tinySpacing = 3.0;
const smallSpacing = 10.0;
const double cardWidth = 115;
const double widthConstraint = 450;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: SUPABASE_URL, anonKey: SUPABASE_API_KEY);
  runApp(Directionality(
    textDirection: TextDirection.rtl,
    child: MaterialApp(
      theme: ThemeData(
        fontFamily: 'Nastaliq',
      ),
      home: AnimatedSplashScreen(
        duration: 1500,
        splashIconSize: 300,
        splash: Image.asset(
          'images/splash.png',
          width: 400,
        ),
        nextScreen: const MyApp(),
        splashTransition: SplashTransition.scaleTransition,
        pageTransitionType: PageTransitionType.bottomToTop,
        backgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
    ),
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
  // ignore: non_constant_identifier_names
  Color _bottom_bar_color = Colors.white;
  
  final _inactiveColor = const Color.fromARGB(255, 123, 122, 122);
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
  Directionality bottom_bar() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
      ),
    );
  }

  // ignore: unused_element
  void _pushAddTodoScreen() {
    // ignore: avoid_print
    print("hello floating");
  }

  Widget getBody() {
    List<Widget> pages = [
      const HomeMainScreen(),
      const BooksMainScreen(),
      const YoutubeHomeScreen(),
      const MoreMainScreen(),
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
        if (_currentIndex == 0) {
          _bottom_bar_color = const Color.fromARGB(255, 49, 51, 120);
        } else if (_currentIndex == 1) {
          _bottom_bar_color = Colors.white;
        } else if (_currentIndex == 2) {
          _bottom_bar_color = const Color.fromRGBO(15, 15, 15, 1);
        } else if (_currentIndex == 3) {
          _bottom_bar_color = const Color.fromARGB(255, 2, 67, 4);
        } else {
          _bottom_bar_color = Colors.white;
        }
      }),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: const Icon(FontAwesomeIcons.houseUser),
          title: const Text(
            'مرکز',
          ),
          //activeColor: const Color.fromRGBO(127, 130, 213, 1),
          activeColor: const Color.fromRGBO(124, 127, 208, 1),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(FontAwesomeIcons.bookOpenReader),
          title: const Text(
            'کتابیں',
          ),
          activeColor: const Color.fromRGBO(248, 147, 0, 1),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(FontAwesomeIcons.youtube),
          title: const Text(
            'ویڈیوز',
          ),
          activeColor: const Color.fromRGBO(255, 0, 0, 1),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.apps),
          title: const Text(
            'مزید',
          ),
          activeColor: Colors.green,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
