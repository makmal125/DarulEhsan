import 'package:cached_network_image/cached_network_image.dart';
import 'package:darulehsan/services/get_taqwim_urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

int pageNumber = 0;
int lastPage = 0;
String lastPageText = 'Last Page';
int scrollPages = 0;
int totalPages = 0;
bool showScrollAnimation = true;

class TaqwimPageViewScreen extends StatefulWidget {
  const TaqwimPageViewScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TaqwimPageViewScreenState createState() => _TaqwimPageViewScreenState();
}

class _TaqwimPageViewScreenState extends State<TaqwimPageViewScreen>
    with TickerProviderStateMixin {
  List<String> bytes = [];
  int chapter = 0;
  int bookId = 0;
  String bookNameUr = 'دارُلاحسان';
  // ignore: non_constant_identifier_names
  bool hasFocus = false;
  FocusNode focus = FocusNode();
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  PageController pageViewController = PageController(
    initialPage: 0,
    viewportFraction: 6,
  );
  bool isVisibleTop = true;
  bool isVisibleDown = true;
  bool isPageNumberVisible = false;
  String sharePage = '';
  //int pageIndex = 0;
  int _counter = 0;

  String currentPageLabel = '0 / $totalPages';
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<AlignmentGeometry> _animation = Tween<AlignmentGeometry>(
    begin: Alignment.centerRight,
    end: Alignment.center,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ),
  );
  @override
  void initState() {
    downloadPDFFile();
    super.initState();

    _getCurrentPage('BookId=$bookId&Chapter=$chapter');
    _getScrollPages('BookId=$bookId&Chapter=$chapter&Pages');
    _getTotalPages('BookId=$bookId&Chapter=$chapter&TotalPages');

    focus.addListener(() {
      onFocusChange();
    });
    searchController.addListener(() {
      //filterClints();
    });

    pageViewController.addListener(() {});
  }

  void _getCurrentPage(valueSharedPreferences) async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _counter = (prefs.getInt(valueSharedPreferences) ?? 0);
      pageViewController = PageController(initialPage: _counter);
      if (_counter > 0) {
        isPageNumberVisible = true;
      }
    });
  }

  void _getScrollPages(valueSharedPreferences) async {
    final sharedStorage = await SharedPreferences.getInstance();

    setState(() {
      scrollPages = (sharedStorage.getInt(valueSharedPreferences) ?? 0);
    });
  }

  void _getTotalPages(valueSharedPreferences) async {
    final sharedStorage = await SharedPreferences.getInstance();

    setState(() {
      totalPages = (sharedStorage.getInt(valueSharedPreferences) ?? 0);
      if (totalPages > 0) {
        totalPages = totalPages - 1;
        int actualPageNumber = _counter + 1;
        currentPageLabel = '$actualPageNumber / $totalPages';
      }
    });
  }

  void _incrementCounter(valueSharedPreferences, value) async {
    final sharedStorage = await SharedPreferences.getInstance();
    setState(() {
      sharedStorage.setInt(valueSharedPreferences, value);
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

  Future<void> downloadPDFFile() async {
    final response = await getTaqwimUrls();
    setState(() {
      bytes = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          //backgroundColor: const Color.fromRGBO(248, 147, 0, 1),
          backgroundColor: const Color.fromRGBO(2, 67, 4, 1),
          title: Text(bookNameUr),
          centerTitle: true,
        ),
        floatingActionButton: Wrap(
          children: [
            
            //page number search
            Container(
              margin: const EdgeInsets.fromLTRB(10, 17, 10, 10),
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
                    });
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: const InputDecoration(
                    hintText: "صفحہ نمبر",
                    label: Text("صفحہ نمبر"),
                    labelStyle: TextStyle(
                        //color: Color.fromRGBO(248, 147, 0, 1), fontSize: 14),
                        color: Color.fromRGBO(2, 67, 4, 1),
                        fontSize: 14),
                    filled: false, //<-- SEE HERE
                    //fillColor: Color.fromRGBO(248, 147, 0, 1),
                    fillColor: Color.fromRGBO(2, 67, 4, 1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderSide: BorderSide(
                          //color: Color.fromRGBO(248, 147, 0, 1),
                          color: Color.fromRGBO(2, 67, 4, 1)),
                    ),
                  ),
                ),
              ),
            ),
            //share page
            Visibility(
              visible: isPageNumberVisible,
              child: Container(
                padding: const EdgeInsets.only(top: 12),
                child: Visibility(
                  visible: isVisibleDown,
                  child: FloatingActionButton(
                    onPressed: () async {
                      final result = await Share.shareWithResult(sharePage);

                      if (result.status == ShareResultStatus.success) {
                        SnackBar snackbar = const SnackBar(
                          backgroundColor: Colors.black,
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          content: Text(
                            "Thank you for sharing!",
                            style: TextStyle(color: Colors.white),
                          ),
                          duration: Duration(seconds: 3),
                        );
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }
                    },
                    //backgroundColor: const Color.fromRGBO(248, 147, 0, 1),
                    backgroundColor: const Color.fromRGBO(2, 67, 4, 1),
                    child: const Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            //top page
            Container(
              padding: const EdgeInsets.fromLTRB(10, 12, 10, 0),
              child: Visibility(
                visible: isVisibleTop,
                child: FloatingActionButton(
                  onPressed: () {
                    if (pageViewController.hasClients) {
                      pageViewController.animateToPage(0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    }
                  },
                  //backgroundColor: const Color.fromRGBO(248, 147, 0, 1),
                  backgroundColor: const Color.fromRGBO(2, 67, 4, 1),
                  child: const Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            //down page
            Container(
              padding: const EdgeInsets.only(top: 12),
              child: Visibility(
                visible: isVisibleDown,
                child: FloatingActionButton(
                  onPressed: () {
                    if (pageViewController.hasClients) {
                      pageViewController.animateToPage(totalPages,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease);
                    }
                  },
                  //backgroundColor: const Color.fromRGBO(248, 147, 0, 1),
                  backgroundColor: const Color.fromRGBO(2, 67, 4, 1),
                  child: const Icon(
                    Icons.arrow_downward,
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
              Visibility(
                visible: isPageNumberVisible,
                maintainAnimation: true,
                maintainState: true,
                child: AlignTransition(
                  alignment: _animation,
                  child: Align(
                    alignment: const AlignmentDirectional(1, -1),
                    child: Container(
                        width: 140,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: const Color.fromARGB(255, 49, 46, 46),
                          borderRadius: const BorderRadius.horizontal(
                              right: Radius.elliptical(50, 50)),
                        )),
                  ),
                ),
              ),
              Visibility(
                visible: isPageNumberVisible,
                maintainAnimation: true,
                maintainState: true,
                child: Align(
                  alignment: const AlignmentDirectional(0.89, -0.98),
                  child: Text(
                    currentPageLabel,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PageView bookPagesBuilder(controller) {
    // ignore: unused_local_variable

    // Return your widget with the data from the snapshot
    if (bytes.isNotEmpty) {
      var dbPages = (bytes.length) + 1;
      var dbChapter = 1;
      var dbBookId = bookNameUr;
      _incrementCounter('BookId=$bookId&Chapter=$chapter&Pages', dbPages);
      _incrementCounter('BookId=$bookId&Chapter=$chapter&TotalPages', dbPages);
      List<Widget> items = [];
      for (int i = 0; i < bytes.length; i++) {
        // ignore: prefer_typing_uninitialized_variables
        var width;
        items.add(SizedBox(
          width: width,
          child: Hero(
            tag: i == 0 ? 'taqwim' : "t_$i",
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                  onTap: () => {},
                  child: CachedNetworkImage(
                    imageUrl: bytes[i],
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.contain,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.darken,
                          ),
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(
                      value: 0,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )),
            ),
          ),
        ));
      }
      return PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: items.length,
        controller: controller,
        onPageChanged: (value) async {
          _incrementCounter('BookId=$dbBookId&Chapter=$dbChapter', value);

          setState(() {
            value = value + 1;
            var dPages = dbPages - 1;
            currentPageLabel = '$value / $dPages';
          });
          if (value == 1) {
            bookNameUr = "دارُلاحسان";
            isPageNumberVisible = false;
          } else {
            bookNameUr = "تقویمِ دارُلاحسان";
            isPageNumberVisible = true;
            sharePage = bytes[value];
          }
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
    return PageView(children: const [CircularProgressIndicator()]);
  }
}
