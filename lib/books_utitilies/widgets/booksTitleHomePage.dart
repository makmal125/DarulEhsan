// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BooksTitleHomePage extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var title;

  BooksTitleHomePage({
    super.key, required this.title
  });

  @override
  Widget build(BuildContext context) {
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