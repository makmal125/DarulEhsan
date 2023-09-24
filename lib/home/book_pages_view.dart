import 'dart:async';
import 'dart:convert';

import 'package:darulehsan/database/models/books_model.dart';
import 'package:darulehsan/home/slide_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

final supabase = Supabase.instance.client;
int pageNumber = 0;
int lastPage = 0;
String lastPageText = 'Last Page';
int pages = 0;
class BookPageView extends StatefulWidget {
  int chapter;
  int bookId;
  String bookNameUr = "دارلاحسان";
  BookPageView(
      {super.key,
      required this.chapter,
      required this.bookId,
      bookNameUr});

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() =>
      // ignore: no_logic_in_create_state
      _ContentScreenState(chapter, bookId, bookNameUr);
}

class _ContentScreenState extends State<BookPageView> {
  final _stream = supabase.from('books').stream(primaryKey: ['id']);
  int chapter;
  int bookId;
  
  String bookNameUr;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _ContentScreenState(this.chapter, this.bookId, this.bookNameUr);
  PageController controller = PageController(
    initialPage: pageNumber,
    viewportFraction: 6,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(248, 147, 0, 1),
        title: Text(bookNameUr),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          
          if (lastPage == pages) {
            setState(() {
              lastPage = 0;
            lastPageText = 'Last Page';
            }); 
          }else{
            setState(() {
              lastPage = pages;
            lastPageText = 'First Page';
            }); 
          }
          controller.animateToPage(lastPage,
              duration: const Duration(milliseconds: 500), curve: Curves.easeInOutSine);
        },
        icon: const Icon(Icons.save),
        label: Text(lastPageText),
      ),
      body: PageView(
        children: [bookPagesBuilder(controller)],
      ),
    );
  }

  StreamBuilder bookPagesBuilder(controller) {
    return StreamBuilder(
      stream: _stream,
      builder: (context, snapshot) {
        // Return your widget with the data from the snapshot
        if (snapshot.hasData) {
          List<Map<String, dynamic>> data = snapshot.data;
          for (Map<String, dynamic> item in data) {
            var dbChapter = item['chapter'];
            var dbBookId = item['bookId'];
            var dbBookNameUr = item['bookNameUr'];

            if (chapter == dbChapter && bookId == dbBookId) {
              var dbBookHomePageUrl = item['bookHomepageUrl'];
              var dbPages = item['pages'];
              setState(e) {
                pages = dbPages;
              }

              List<Widget> items = [];
              NumberFormat formatter = NumberFormat("0000");
              items.add(SlideCard(cardImage: dbBookHomePageUrl));
              for (var i = 2; i < dbPages; i++) {
                items.add(SlideCard(
                    cardImage:
                        'http://www.darulehsan132.com/Books/$dbBookId/$dbChapter/d${formatter.format(i)}.jpg'));
              }
              return PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: items.length,
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    print(value);
                    if (value == 0) {
                      bookNameUr = "دارلاحسان";
                    } else {
                      bookNameUr = dbBookNameUr;
                    }
                  });
                },
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(26),
                    child: items[index],
                  );
                },
              );
            }
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
