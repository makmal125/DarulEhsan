import 'package:darulehsan/screens/books/book_pages_view.dart';
import 'package:darulehsan/services/supabase_api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:lottie/lottie.dart';

class TasbeehMainScreen extends StatefulWidget {
  const TasbeehMainScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TasbeehMainScreen createState() => _TasbeehMainScreen();
}

class _TasbeehMainScreen extends State<TasbeehMainScreen> {
  String tasbeehAr = '';
  double globalCounter = 0.0;
  double globalTargetCounter = 0.0;
  int rowId = 1;
  bool isCelebration = false;
  final tasbeehStream = getTasbeehStream();
  // ignore: non_constant_identifier_names
  void FetchData() {
    tasbeehStream.listen((event) {
      var localTashbeehAr = '';
      double localTashbeehCounter = 0;
      double localTashbeehTargetCounter = 0;
      int localRowId = 1;
      for (dynamic item in event) {
        localTashbeehAr = item['tasbeeh_ar'];
        localTashbeehCounter = double.parse(item['global_counter'].toString());
        localTashbeehTargetCounter =
            double.parse(item['global_target_counter'].toString());
        localRowId = int.parse(item['id'].toString());
      }
      setState(() {
        if (mounted) {
          tasbeehAr = localTashbeehAr;
          globalCounter = localTashbeehCounter;
          globalTargetCounter = localTashbeehTargetCounter;
          rowId = localRowId;
          if (globalCounter >= globalTargetCounter) {
            isCelebration = true;
          }
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    FetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(124, 127, 208, 1),
        appBar: AppBar(
          title: const Text("عالمی ذکر"),
          backgroundColor: const Color.fromARGB(255, 49, 51, 120),
          centerTitle: true,
        ),
        //floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Container(
          margin: const EdgeInsets.fromLTRB(40, 500, 0, 0),
          child: isCelebration == true
              ? const SizedBox()
              : Center(
                  child: FloatingActionButton.large(
                    elevation: 5,
                    backgroundColor: const Color.fromARGB(255, 49, 51, 120),
                    heroTag: 'tesbeehTag',
                    child: const ImageIcon(
                      AssetImage("images/tespih.png"),
                      color: Colors.white,
                      size: 44,
                    ),
                    onPressed: () async {
                      await supabase.rpc('increment_function',
                          params: {'x': 1, 'row_id': rowId});
                     
                    },
                  ),
                ),
        ),
        body: Column(children: <Widget>[
          const SizedBox(height: 50.0),
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromARGB(255, 49, 51, 120),
                  width: 2,
                ),
              ),
            ),
            child: RichText(
              text: TextSpan(
                text: tasbeehAr,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 50.0),
          Center(
            child: RichText(
              text: TextSpan(
                text:
                    '${intl.NumberFormat.decimalPattern('hi').format(globalCounter)} ',
                style: isCelebration == true
                    ? const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )
                    : const TextStyle(
                        color: Colors.white,
                      ),
                children: <TextSpan>[
                  const TextSpan(
                    text: '/',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 49, 51, 120),
                        fontSize: 20),
                  ),
                  TextSpan(
                    text:
                        ' ${intl.NumberFormat.decimalPattern('hi').format(globalTargetCounter)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: isCelebration,
            child: Container(
              child:
                  Lottie.asset('animations/celebration.json', fit: BoxFit.cover),
            ),
          ),
        ]),
      ),
    );
  }
}
