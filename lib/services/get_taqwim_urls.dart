
import 'package:darulehsan/screens/books/book_pages_view.dart';
import 'package:darulehsan/utilities/keys.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<List<String>> getTaqwimUrls() async {
  final List<FileObject> objects = await supabase
  .storage
  .from(SUPABASE_BUCKET_ADITIONAL_BOOKS)
  .list(searchOptions: const SearchOptions(limit: 280));
  List<String> taqwimUrls = [];
  for (int i = 0; i < objects.length; i++){
    String imageUrl = '$SUPABASE_STORAGE_PUBLIC_URL/$SUPABASE_BUCKET_ADITIONAL_BOOKS/${objects[i].name}';  
    taqwimUrls.add(imageUrl);
  }
  return taqwimUrls;
}