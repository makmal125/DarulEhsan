import 'package:darulehsan/screens/books/book_pages_view.dart';
import 'package:darulehsan/books_utitilies/photo_hero.dart';
import 'package:darulehsan/screens/more/taqwim/taqwim_pages_view.dart';
import 'package:darulehsan/utilities/keys.dart';
import 'package:flutter/material.dart';

const rowDivider = SizedBox(width: 20);
Builder otherBooks(Stream booStream) {
  var indexStart = [
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30
  ];
  var indexBookId = [
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28
  ];
  return Builder(builder: (context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        // ignore: avoid_unnecessary_containers
        Container(
          margin: const EdgeInsets.only(top: 30),
          child: GridView.count(
            padding: EdgeInsets.zero,
            crossAxisCount: 2,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            // ignore: prefer_const_constructors
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 1.2,
            children: List.generate(
              26,
              (index) {
                // if (index == 26) {
                //   return Container(
                //     padding: const EdgeInsets.all(8),
                //     // ignore: prefer_const_constructors
                //     child: PhotoHero(
                //       // ignore: prefer_interpolation_to_compose_strings
                //       photo: '$SUPABASE_STORAGE_PUBLIC_URL/$SUPABASE_BUCKET_ADITIONAL_BOOKS/Taqwim_page-0001-min.jpg',
                //       width: 150.0,
                //       onTap: () {
                //         // ignore: prefer_interpolation_to_compose_strings
                //         _openTaqwim(context);
                //       },
                //     ),
                //   );
                //   //TaqwimPageViewScreen
                // } else {
                  int homePageIndex = indexStart[index];
                  int bookId = indexBookId[index];
                  // ignore: avoid_unnecessary_containers
                  return Container(
                    padding: const EdgeInsets.all(8),
                    // ignore: prefer_const_constructors
                    child: PhotoHero(
                      // ignore: prefer_interpolation_to_compose_strings
                      photo: '${'$DOMAIN_URL/$SUB_URL/'}$homePageIndex.jpg',
                      width: 150.0,
                      onTap: () {
                        // ignore: prefer_interpolation_to_compose_strings
                        _openDetail(context, 1, bookId, booStream);
                      },
                    ),
                  );
               // }
              },
            ),
          ),
        ),
      ],
    );
  });
}

_openDetail(context, chapter, bookId, bookStream) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BookPageView(
        chapter: chapter,
        bookId: bookId,
        BookStream: bookStream,
      ),
    ),
  );
}

_openTaqwim(context) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const TaqwimPageViewScreen(),
    ),
  );
}
