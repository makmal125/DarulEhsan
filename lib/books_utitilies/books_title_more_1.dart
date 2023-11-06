// ignore: file_names

// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:darulehsan/screens/books/book_pages_view.dart';
import 'package:darulehsan/books_utitilies/photo_hero.dart';
import 'package:darulehsan/utilities/keys.dart';
import 'package:flutter/material.dart';

// ignore: unused_element

makalatBooksList(bookName, totalChapters, bookTitle, bookStream) {
  int bookId = 1;
  if (bookName == 'Read_Tarteeb_') {
    bookId = 2;
  }

  return SliverToBoxAdapter(
    child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        height: 180,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView.builder(
              // This next line does the trick.
              scrollDirection: Axis.horizontal,
              itemCount: totalChapters,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return const SizedBox();
                }
                if (index >= 1 && index <= 9) {
                  return Container(
                    margin: const EdgeInsets.all(5),
                    width: 150,
                    child: PhotoHero(
                      // ignore: prefer_interpolation_to_compose_strings
                      photo: '${'$DOMAIN_URL/$SUB_URL/' + bookName}0$index.jpg',
                      width: 150.0,
                      onTap: () {
                        // ignore: prefer_interpolation_to_compose_strings
                        _openDetail(context, index, bookId, bookStream);
                      },
                    ),
                  );
                } else {
                  return Container(
                    margin: const EdgeInsets.all(5),
                    width: 150,
                    child: PhotoHero(
                      
                      // ignore: prefer_interpolation_to_compose_strings
                      photo: '${'$DOMAIN_URL/$SUB_URL/' + bookName}$index.jpg',
                      width: 150.0,
                      onTap: () {
                        // ignore: prefer_interpolation_to_compose_strings
                        _openDetail(context, index, bookId, bookStream);
                      },
                    ),
                  );
                }
              }
              // ignore: avoid_unnecessary_containers

              ),
        )),
  );
}

 _openDetail(context, chapter, bookId, bookStream) {
// Navigator.of(context).push(
//         PageRouteBuilder(
//           transitionDuration: const Duration(seconds: 2),
//           pageBuilder: (_, __, ___) => BookPageView(
//         chapter: chapter,
//         bookId: bookId,
//         BookStream: bookStream,
//       )
//         )
//       );

//   return Navigator.of(context).push(
//     MaterialPageRoute(
//       builder: (context) => BookPageView(
//         chapter: chapter,
//         bookId: bookId,
//         BookStream: bookStream,
//       ),
//     ),
//   );
   return Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              BookPageView(chapter: chapter, bookId: bookId, BookStream: bookStream)));
}
