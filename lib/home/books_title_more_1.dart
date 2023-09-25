// ignore: file_names

import 'package:darulehsan/home/book_pages_view.dart';
import 'package:darulehsan/home/photo_hero.dart';
import 'package:flutter/material.dart';

const url = "http://www.darulehsan132.com";
const suburl = "assets/img";
// ignore: unused_element

makalatBooksList(bookName, totalChapters, bookTitle) {
  int bookId = 1;
   if(bookName == 'Read_Tarteeb_'){
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
                        photo: '${'$url/$suburl/' + bookName}0$index.jpg',
                        width: 150.0,
                        onTap: () {
                          // ignore: prefer_interpolation_to_compose_strings
                          _openDetail(context, index,bookId);
                        },
                  
                      ),
                  
                  );
                } else {
                  return Container(
                      margin: const EdgeInsets.all(5),
                      width: 150,
                      child: PhotoHero(
                        // ignore: prefer_interpolation_to_compose_strings
                        photo: '${'$url/$suburl/' + bookName}$index.jpg',
                        width: 150.0,
                        onTap: () {
                          // ignore: prefer_interpolation_to_compose_strings
                          _openDetail(context, index, bookId);
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
_openDetail(context, chapter,bookId) {
  
    return Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BookPageView(chapter:chapter,bookId: bookId)));
  }
