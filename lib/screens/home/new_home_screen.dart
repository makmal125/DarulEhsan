import 'package:darulehsan/screens/home/home_screen.dart';
import 'package:darulehsan/screens/home/tasbeeh_screen.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: DraggableHome(
        fullyStretchable:true,
        title: Container(),
       
        headerWidget: headerWidget(context),
        //headerBottomBar: headerBottomBarWidget(),
        body: [
          listView(),
        ],
        expandedBody: const HomeMainScreen(),
        backgroundColor: Colors.white,
        appBarColor: Colors.teal,
      ),
    );
  }

  Row headerBottomBarWidget() {
    return const Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.settings,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget headerWidget(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 49, 51, 120),
      child: Center(
        child: Text(
          "Title",
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(color: Colors.black),
        ),
      ),
    );
  }

  ListView listView() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 20,
      shrinkWrap: true,
      itemBuilder: (context, index) => Card(
        color: Colors.white70,
        child: ListTile(
          leading: CircleAvatar(
            child: Text("$index"),
          ),
          title: const Text("Title"),
          subtitle: const Text("Subtitle"),
        ),
      ),
    );
  }
}