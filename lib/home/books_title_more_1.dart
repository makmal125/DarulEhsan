// ignore: file_names

import 'package:flutter/material.dart';

const url = "http://darulehsan.pk";
const suburl = "assets/img";
// ignore: unused_element

makalatBooksList(bookName, totalChapters) {
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
                    child: Card(
                      elevation: 5,
                      margin: const EdgeInsets.all(2),
                      child: Image.network(
                        // ignore: prefer_interpolation_to_compose_strings
                        '${'$url/$suburl/' + bookName}0$index.jpg',
                      ),
                    ),
                  );
                } else {
                  return Container(
                    margin: const EdgeInsets.all(5),
                    width: 150,
                    child: Card(
                      elevation: 5,
                      margin: const EdgeInsets.all(2),
                      child: Image.network(
                        // ignore: prefer_interpolation_to_compose_strings
                        '${'$url/$suburl/' + bookName}$index.jpg',
                      ),
                    ),
                  );
                }
              }
              // ignore: avoid_unnecessary_containers

              ),
        )),
  );
}
