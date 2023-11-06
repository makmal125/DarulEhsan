// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:darulehsan/connection_status.dart';
import 'package:darulehsan/screens/home/tasbeeh_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeMainScreen();
}

class _HomeMainScreen extends State<HomeMainScreen> {
   // ignore: unused_field
   StreamSubscription? _connectionChangeStream;
  @override
  void initState(){
    super.initState();
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);
        connectionStatus.checkConnection();
  }
  void connectionChanged(dynamic hasConnection) {
    print(hasConnection);
    if(!hasConnection){

      Fluttertoast.showToast(
          msg: "Check your internet connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
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
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const TasbeehMainScreen()));
        },
      ),
      body: CustomScrollView(
      
        slivers: [
          SliverAppBar.medium(
            collapsedHeight: 130,
            expandedHeight: 130,
            backgroundColor: Colors.transparent,
            title: Stack(
              children: [
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromARGB(255, 49, 51, 120),
                  ),
                  child: Align(
                    alignment: const AlignmentDirectional(1, -1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 60,
                        ),
                        DefaultTextStyle(
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20.0,
                            //fontFamily: 'AlBayan',
                          ),
                          child: AnimatedTextKit(
                            repeatForever: true,
                            animatedTexts: [
                              RotateAnimatedText(
                                'قُل، عِشقُ مُحَمَّدٍﷺ مَذهَبِي وَ حُبُه مِلَّتِي و طاعَته مَنزلى',
                                textAlign: TextAlign.justify,
                                alignment: Alignment.center,
                                textDirection: TextDirection.rtl,
                                duration: const Duration(seconds: 10),
                              ),
                              RotateAnimatedText(
                                'کہہ، حضور اقدس ﷺ سے عشق میرا مذهب، محبت میری ملت اور اتباع میری منزل ہے',
                                textAlign: TextAlign.center,
                                alignment: Alignment.center,
                                textDirection: TextDirection.rtl,
                                duration: const Duration(seconds: 13),
                                textStyle: const TextStyle(fontSize: 13)
                              ),
                            ],
                            onTap: () {
                              print("Tap Event");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromARGB(255, 49, 51, 120),
                  ),
                  child: Align(
                    alignment: const AlignmentDirectional(1, -1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 60,
                        ),
                        DefaultTextStyle(
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20.0,
                            //fontFamily: 'AlBayan',
                          ),
                          child: AnimatedTextKit(
                            repeatForever: true,
                            animatedTexts: [
                              RotateAnimatedText(
                                'قُل، عِشقُ مُحَمَّدٍﷺ مَذهَبِي وَ حُبُه مِلَّتِي و طاعَته مَنزلى',
                                textAlign: TextAlign.justify,
                                alignment: Alignment.center,
                                textDirection: TextDirection.rtl,
                                duration: const Duration(seconds: 10),
                              ),
                              RotateAnimatedText(
                                'کہہ، حضور اقدس ﷺ سے عشق میرا مذهب، محبت میری ملت اور اتباع میری منزل ہے',
                                textAlign: TextAlign.center,
                                alignment: Alignment.center,
                                textDirection: TextDirection.rtl,
                                duration: const Duration(seconds: 13),
                                textStyle: const TextStyle(fontSize: 13)
                              ),
                            ],
                            onTap: () {
                              print("Tap Event");
                            },
                          ),
                        ),
                      ],
                    ),
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
