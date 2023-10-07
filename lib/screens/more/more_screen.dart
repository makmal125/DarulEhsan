import 'package:darulehsan/screens/more/duain/duain_main_screen.dart';
import 'package:darulehsan/screens/more/taqwim/taqwim_pages_view.dart';
import 'package:darulehsan/services/google_signin.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MoreMainScreen extends StatefulWidget {
  const MoreMainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MoreMainScreen();
}

class _MoreMainScreen extends State<MoreMainScreen> {
  @override
  void initState() => super.initState();

  @override
  void dispose() {
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(2, 67, 4, 1),
        actions: [
          // ElevatedButton(
          //   onPressed:() => googleSignin(),
          //   style: ElevatedButton.styleFrom(
          //     shape: const CircleBorder(),
          //     padding: const EdgeInsets.all(10),
          //     backgroundColor: Colors.green, // <-- Button color
          //     foregroundColor: Colors.green, // <-- Splash color
          //   ),
          //   child: const Icon(FontAwesomeIcons.solidUser, color: Colors.white),
          // ),
        ],
        flexibleSpace: const FlexibleSpaceBar(
          title: Text('More'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          children: [
            const ListTile(
              textColor: Colors.black,
              iconColor: Colors.black,
              leading: CircleAvatar(
                child: Icon(FontAwesomeIcons.personPraying),
              ),
              title: Text("Some title"),
              subtitle: Text("Some subtitle"),
              style: ListTileStyle.drawer,
            ),
            const Divider(
              height: 3,
              thickness: 1,
              indent: 15,
              endIndent: 15,
              color: Color.fromRGBO(2, 67, 4, 1),
            ),
             ListTile(
               textColor: Colors.black,
               iconColor: Colors.green,
               leading: const CircleAvatar(
                 backgroundColor: Color.fromRGBO(2, 67, 4, 1),
                 radius: 20,
                 foregroundColor: Color.fromRGBO(2, 67, 4, 1),
                 child:
                     Icon(FontAwesomeIcons.personPraying, color: Colors.white),
               ),
               title: const Text(
                 "Duain",
                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
               ),
               subtitle: const Text("Daily prayers"),
               trailing: const Icon(FontAwesomeIcons.circleArrowRight),
               onTap: () {
                 Navigator.push(context,
                     MaterialPageRoute(builder: (context) => const DuainMainScreen()));
               },
             ),
             const Divider(
              height: 3,
              thickness: 1,
              indent: 15,
              endIndent: 15,
              color: Color.fromRGBO(2, 67, 4, 1),
            ),
             ListTile(
               textColor: Colors.black,
               iconColor: Colors.green,
               leading: const CircleAvatar(
                 backgroundColor: Color.fromRGBO(2, 67, 4, 1),
                 radius: 20,
                 foregroundColor: Color.fromRGBO(2, 67, 4, 1),
                 child:
                     Icon(FontAwesomeIcons.bookOpenReader, color: Colors.white),
               ),
               title: const Text(
                 "Taqwim",
                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
               ),
               subtitle: const Text("Taqwim"),
               trailing: const Icon(FontAwesomeIcons.circleArrowRight),
               onTap: () async {
                 Navigator.push(context,
                     MaterialPageRoute(builder: (context) => const TaqwimPageViewScreen()));
               },
             ),
            const Divider(
              height: 3,
              thickness: 1,
              indent: 15,
              endIndent: 15,
              color: Color.fromRGBO(2, 67, 4, 1),
            ),
            const ListTile(
              textColor: Colors.white,
              iconColor: Colors.white,
              leading: CircleAvatar(
                child: Icon(FontAwesomeIcons.photoFilm),
              ),
              title: Text("Gallery"),
              subtitle: Text("Photo gallery"),
              trailing: Icon(Icons.arrow_right),
            ),
            const Divider(
              height: 3,
              thickness: 1,
              indent: 15,
              endIndent: 15,
              color: Color.fromRGBO(2, 67, 4, 1),
            ),
          ],
        ),
      ),
    );
  }
}
