// ignore_for_file: non_constant_identifier_names

import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter{
  
  @override
  void paint(Canvas canvas, Size size) {
    
    

  // Layer 1
  
  Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(255, 8, 57, 12)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width*0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;
    paint_fill_0.shader = ui.Gradient.linear(Offset(size.width*-0.00,size.height*0.10),Offset(size.width*0.90,size.height*0.10),[const Color(0xff10673b),const Color(0xff347a80)],[0.00,1.00]); 
         
    Path path_0 = Path();
    path_0.moveTo(size.width*-0.0001200,size.height*0.0040000);
    path_0.lineTo(size.width*0.0004400,size.height*0.2006400);
    path_0.lineTo(size.width*0.8813800,size.height*0.2014800);
    path_0.lineTo(size.width*0.8818200,size.height*0.1514400);
    path_0.lineTo(size.width*0.8979700,size.height*0.0974800);
    path_0.lineTo(size.width*0.8801100,size.height*0.0508800);
    path_0.lineTo(size.width*0.8800000,size.height*-0.0018200);

    canvas.drawPath(path_0, paint_fill_0);
  
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}
