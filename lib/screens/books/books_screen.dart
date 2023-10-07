import 'package:darulehsan/books_utitilies/books_title_more_1.dart';
import 'package:darulehsan/books_utitilies/other_books.dart';
import 'package:darulehsan/books_utitilies/widgets/appBarHomeSwiper.dart';
import 'package:darulehsan/books_utitilies/widgets/booksTitleHomePage.dart';
import 'package:darulehsan/books_utitilies/widgets/marqueeHomePage.dart';
import 'package:darulehsan/books_utitilies/widgets/sliverDivider.dart';
import 'package:darulehsan/services/supabase_api_service.dart';
import 'package:flutter/material.dart';

class BooksMainScreen extends StatefulWidget {
  const BooksMainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _BooksMainScreen();
}

class _BooksMainScreen extends State<BooksMainScreen> {
  final bookStream = getBooksStream();
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: const Color.fromRGBO(248, 147, 0, 1),
          elevation: 0,
          pinned: true,
          stretch: true,
          expandedHeight: 240,
          excludeHeaderSemantics: true,
          floating: false,
          flexibleSpace: FlexibleSpaceBar(
            title: Container(
              margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('images/header.png'),
                  ]),
            ),
            expandedTitleScale: 1,
            collapseMode: CollapseMode.pin,
            background: const HomeAppBarSwiper(),
            centerTitle: true,
          ),
        ),
        const HomePageMarquee(),
        BooksTitleHomePage(title: 'مقا لا تِ حکمت'),
        makalatBooksList('Read_Makalat_', 31, 'مقا لا تِ حکمت', bookStream),
        const SliverDivider(),
        BooksTitleHomePage(title: "ترتیب شریف"),
        makalatBooksList('Read_Tarteeb_', 6, "ترتیب شریف", bookStream),
        const SliverDivider(),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return otherBooks(bookStream);
          }, childCount: 1),
        )
      ],
    );
  }
}
