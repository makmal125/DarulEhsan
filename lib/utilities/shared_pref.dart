import 'package:shared_preferences/shared_preferences.dart';

class Helper {
 
// Write DATA
static Future<bool> saveUserData(valueSharedPreferences, value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setInt(valueSharedPreferences, value);
  }
   
// Read Data
static Future getUserData(valueSharedPreferences) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(valueSharedPreferences);
  }
}