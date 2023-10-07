import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatelessWidget {
  final String index;

  final String bookTitle;

  const DetailPage({super.key, required this.index, required this.bookTitle});

  @override
  Widget build(BuildContext context) {
    
    List<String> imagesStrings = [];
    NumberFormat formatter = NumberFormat("0000");
    
    if (bookTitle == 'مقا لا تِ حکمت') {
      imagesStrings.add('http://www.darulehsan.pk/Books/1/1/a0001.jpg');
    }
    
     else {
      imagesStrings.add('http://www.darulehsan.pk/Books/1/1/a0001.jpg');
    }
    for (var i = 2; i < 491; i++) {
      imagesStrings.add(
          'http://www.darulehsan.pk/Books/1/1/d${formatter.format(i)}.jpg');
    }
    //imagesStrings = imagesStrings.reversed.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(bookTitle),
      ),
      body: Center(
        child: Swiper(
          containerHeight: 400,
          itemHeight: MediaQuery.of(context).size.height * 0.25,
          itemCount: imagesStrings.length,
          itemBuilder: (BuildContext context, int index) => Image.network(
            imagesStrings[index],
            fit: BoxFit.contain,
            height:MediaQuery.of(context).size.height - 10.25,
          ),
          autoplay: false,
          //index: 490,
          control: const SwiperControl(),
          indicatorLayout: PageIndicatorLayout.SCALE,
          scrollDirection: Axis.vertical,
          pagination:
              const SwiperPagination(builder: SwiperPagination.fraction,alignment: Alignment.bottomRight,),
        ),
      ),
    );
  }
}

