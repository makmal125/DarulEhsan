import 'package:darulehsan/screens/books/book_pages_view.dart';
import 'package:darulehsan/services/supabase_api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  final tasbeehStream = getTasbeehStream();
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
    return Scaffold(
      backgroundColor: const Color.fromRGBO(124, 127, 208, 1),
      appBar: AppBar(
        title: const Text("عالمی ذکر"),
        backgroundColor: const Color.fromARGB(255, 49, 51, 120),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: const Color.fromARGB(255, 49, 51, 120),
        heroTag: 'tesbeehTag',
        child: const Icon(
          Icons.add_circle,
        ),
        onPressed: () async {
          await supabase
              .rpc('increment_function', params: {'x': 1, 'row_id': rowId});
        },
      ),
      body: Column(children: <Widget>[
        const SizedBox(height: 100.0),
        Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(10),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color.fromARGB(255, 49, 51, 120),
                width: 2,
              ),
            ),
          ),
          child: Center(
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
        ),
        const SizedBox(height: 50.0),
        Container(
          
          child: Center(
            child: RichText(
              text: TextSpan(
                text:
                    '${NumberFormat.decimalPattern('hi').format(globalCounter)} ',
                style: const TextStyle(color: Colors.white),
                children: <TextSpan>[
                  const TextSpan(
                      text: '/',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 49, 51, 120))),
                  TextSpan(
                      text:
                          ' ${NumberFormat.decimalPattern('hi').format(globalTargetCounter)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
