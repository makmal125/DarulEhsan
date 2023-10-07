// ignore_for_file: must_be_immutable

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

var dataBytes;

class SwiperServerLocalImage extends StatefulWidget {
  String baseUrl;
  SwiperServerLocalImage({super.key, required this.baseUrl});

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _LoadImages createState() => (_LoadImages(baseUrl));
}

class _LoadImages extends State<SwiperServerLocalImage> {
  String baseUrl =
      'http://www.darulehsan132.com/assets/img/portfolio/Thumbs/1-06.jpg';

  _LoadImages(this.baseUrl);
  @override
  void initState() {
    super.initState();
    images(this.baseUrl);
  }
  Future<void> images(String imageUrl) async {
  Uint8List bytes = Uint8List.fromList([0, 2, 5 ,7]);
  final cacheManager = DefaultCacheManager();
  final file = await cacheManager.getSingleFile(imageUrl);
  // ignore: unnecessary_null_comparison
  if (file != null && file.existsSync()) {
    bytes = file.readAsBytesSync();
    setState(() {
     dataBytes = bytes;
   });
  }
}

  @override
  Widget build(BuildContext context) {
    if (dataBytes != null) {
      return Image.memory(
        dataBytes,
        fit: BoxFit.fill, // You can adjust the fit as needed.
      );
    } else {
      return const CircularProgressIndicator();
    }
  }
}



Future<void> saveNetworkImage(String imageUrl) async {
  final cacheManager = DefaultCacheManager();
  await cacheManager.downloadFile(imageUrl);
}
