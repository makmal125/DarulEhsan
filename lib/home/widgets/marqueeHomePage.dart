import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class HomePageMarquee extends StatelessWidget {
  const HomePageMarquee({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
    child: Container(
      color: const Color.fromRGBO(236, 196, 166, 100),
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 40,
              child: Marquee(
                text:
                    '.الهم صلي علي سيدنا محمد النبي الامي و علي اله و اصحابه و عترته بعدد كل معلوم لك و استغفرالله الذي لا اله الا هو الحي القيوم و اتوب اليه يا حي يا قيوم',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.green),
                scrollAxis: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.end,
                textDirection: TextDirection.rtl,
                blankSpace: 400.0,
                velocity: 50.0,
                pauseAfterRound: const Duration(seconds: 1),
                startPadding: 20.0,
                accelerationDuration: const Duration(seconds: 1),
                accelerationCurve: Curves.linear,
                decelerationDuration: const Duration(milliseconds: 500),
                decelerationCurve: Curves.easeOut,
              ),
            ),
          ),
        ],
      ),
    ),
  );
  }
}