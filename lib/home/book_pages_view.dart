import 'package:darulehsan/home/slide_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;
int pageNumber = 0;
int lastPage = 0;
String lastPageText = 'Last Page';
int pages = 0;
bool showScrollAnimation = true;

// ignore: must_be_immutable
class BookPageView extends StatefulWidget {
  int chapter;
  int bookId;
  String bookNameUr = "دارلاحسان";
  BookPageView(
      {super.key, required this.chapter, required this.bookId, bookNameUr});

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
  bool hasFocus = false;
  FocusNode focus = FocusNode();
  TextEditingController searchController = TextEditingController();
  ScrollController scrollViewController = ScrollController();
  PageController pageViewController = PageController(
    initialPage: pageNumber,
    viewportFraction: 6,
  );
  bool isVisibleTop = false;
  bool isVisibleDown = true;
  int pageIndex = 0;
  @override
  void initState() {
    super.initState();
    focus.addListener(() {
      onFocusChange();
    });
    searchController.addListener(() {
      //filterClints();
    });
    pageViewController.addListener(() {
      if (pageViewController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (pageIndex > 0) {
          setState(() {
            isVisibleDown = true;
            isVisibleTop = true;
          });
        }
        if (pageIndex == pages) {
          setState(() {
            isVisibleDown = false;
            isVisibleTop = true;
          });
        }
      }
      if (pageViewController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (pageIndex > 0) {
          setState(() {
            isVisibleDown = true;
            isVisibleTop = true;
          });
        }
        if (pageIndex == pages) {
          setState(() {
            isVisibleDown = false;
            isVisibleTop = true;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    focus.removeListener(onFocusChange);
    super.dispose();
  }

  void onFocusChange() {
    if (focus.hasFocus) {
      setState(() {
        hasFocus = true;
      });
    } else {
      setState(() {
        hasFocus = false;
      });
    }
  }

  _ContentScreenState(this.chapter, this.bookId, this.bookNameUr);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(248, 147, 0, 1),
        title: Text(bookNameUr),
        centerTitle: true,
      ),
      floatingActionButton: Wrap(
        children: [
          Container(
              margin: const EdgeInsets.fromLTRB(10, 15, 10, 10),
              width: 140,
              height: 50,
              child: Material(
                elevation: 5,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: TextField(
                  focusNode: focus,
                  onChanged: (value) {
                    setState(() {
                      if (value.isNotEmpty) {
                        int goPage = int.parse(value);
                        if (goPage > 0) {
                          goPage = goPage - 1;
                          pageViewController.animateToPage(goPage,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        }
                      }
                    });
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: const InputDecoration(
                    hintText: "Page No",
                    label: Text("Page No"),
                    labelStyle: TextStyle(color: Color.fromRGBO(248, 147, 0, 1), fontSize: 14),
                    filled: false, //<-- SEE HERE
                    fillColor: Color.fromRGBO(248, 147, 0, 1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(248, 147, 0, 1),
                      ),
                    ),
                  ),
                ),
              )),
          //down page
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Visibility(
              visible: isVisibleDown,
              child: FloatingActionButton(
                onPressed: () {
                  pageViewController.animateToPage(pages,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);
                  setState(() {
                    isVisibleTop = true;
                    isVisibleDown = false;
                  });
                },
                backgroundColor: const Color.fromRGBO(248, 147, 0, 1),
                child: const Icon(
                  Icons.arrow_downward,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          //top page
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Visibility(
              visible: isVisibleTop,
              child: FloatingActionButton(
                onPressed: () {
                  pageViewController.animateToPage(0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);
                  setState(() {
                    isVisibleDown = true;
                    isVisibleTop = false;
                  });
                },
                backgroundColor: const Color.fromRGBO(248, 147, 0, 1),
                child: const Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              children: [
                bookPagesBuilder(pageViewController),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Column ScrollUpAnimation() {
    if (showScrollAnimation) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70,
            color: Colors.transparent,
            child: Lottie.asset('animations/lottieup.json'),
          ),
        ],
      );
    }
    return const Column();
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
                isVisibleDown = true;
                isVisibleTop = false;
                pageIndex = 0;
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
                    pageIndex = value;
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
                    padding: const EdgeInsets.fromLTRB(26, 10, 26, 26),
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
