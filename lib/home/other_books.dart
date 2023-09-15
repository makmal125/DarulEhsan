
import 'package:flutter/material.dart';
const url = "http://darulehsan.pk";
const suburl = "assets/img";
Column otherBooks() {
  var indexStart = [5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30];
    return Column(
            mainAxisAlignment:MainAxisAlignment.start,
            children: <Widget>[
              // ignore: avoid_unnecessary_containers
              Container(
                margin: const EdgeInsets.only(top:30),
                child: GridView.count(
                  padding: EdgeInsets.zero,
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  // ignore: prefer_const_constructors
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.2,
                  children: List.generate(
                    26,
                    (index) {
                        int i = indexStart[index];
                        // ignore: avoid_unnecessary_containers
                        return Container(
                          padding:const EdgeInsets.all(8),
                        // ignore: prefer_const_constructors
                        child: Card(
                          elevation: 5,
                          margin: const EdgeInsets.all(2),
                          child:Image.network(
                        // ignore: prefer_interpolation_to_compose_strings
                        '${'$url/$suburl/'}$i.jpg',
                      )
                        ),
                      );
                      
                      
                    },
                  ),
                ),
              ),
            ],
          );
  }