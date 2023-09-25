import 'package:supabase_flutter/supabase_flutter.dart';

import 'models/books_model.dart';

final books  = Supabase.instance.client.from('countries')
  .stream(primaryKey: ['id'])
  .listen((List<Map<String, dynamic>> data) {
  // Do something awesome with the data
  data.forEach((element) {
    print(element.keys.first);
    print(element.values.first);
  });
});