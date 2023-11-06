import 'dart:async';

import 'package:darulehsan/utilities/keys.dart';
import 'package:intl/intl.dart';

Future<List<String>> getTaqwimUrls() async {
  // final List<FileObject> objects = await supabase
  // .storage
  // .from(SUPABASE_BUCKET_ADITIONAL_BOOKS)
  // .list(searchOptions: const SearchOptions(limit: 280));
  List<String> taqwimUrls = [];
  NumberFormat formatter = NumberFormat("000");
  for (int i = 1; i < 281; i++) {
    //String imageUrl = '$SUPABASE_STORAGE_PUBLIC_URL/$SUPABASE_BUCKET_ADITIONAL_BOOKS/${objects[i].name}';
    if (i == 3 || i == 4 || i == 5) {
      //images hide
    } else {
      String imageUrl =
          '$SUPABASE_STORAGE_PUBLIC_URL/$SUPABASE_BUCKET_ADITIONAL_BOOKS/Taqwim_page_${formatter.format(i)}.jpg';
      taqwimUrls.add(imageUrl);
    }
  }
  return taqwimUrls;
}

StreamController<dynamic> streamController() {
  StreamController<String> controller = StreamController<String>();
  NumberFormat formatter = NumberFormat("000");
  for (int i = 1; i < 281; i++) {
    //String imageUrl = '$SUPABASE_STORAGE_PUBLIC_URL/$SUPABASE_BUCKET_ADITIONAL_BOOKS/${objects[i].name}';
    if (i != 2 || i != 3 || i != 4) {
      String imageUrl =
          '$SUPABASE_STORAGE_PUBLIC_URL/$SUPABASE_BUCKET_ADITIONAL_BOOKS/Taqwim_page_${formatter.format(i)}.jpg';
      controller.add(imageUrl);
    }
  }
  return controller;
}
