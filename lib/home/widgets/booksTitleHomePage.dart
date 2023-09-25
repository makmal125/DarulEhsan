import 'package:flutter/material.dart';

class BooksTitleHomePage extends StatelessWidget {
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