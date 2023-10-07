import 'package:supabase_flutter/supabase_flutter.dart';

Stream getBooksStream(){
  final supabase = Supabase.instance.client;
  return supabase.from('books').stream(primaryKey: ['id']);
}
Stream getTasbeehStream(){
  final supabase = Supabase.instance.client;
  return supabase.from('tasbeeh').stream(primaryKey: ['id']).order('created_at').limit(1);
}