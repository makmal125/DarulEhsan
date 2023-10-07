import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderData extends ChangeNotifier {
  SharedPreferences? prefs;
  String pageIndexKey = '1-1';
  int? _pageIndex;
  int? get pageIndex => _pageIndex;

  ProviderData() {
    _pageIndex = 0;
    loadFromPrefs();
  }

  initPrefs() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  loadFromPrefs() async {
    await initPrefs();
    _pageIndex = prefs!.getInt(pageIndexKey) ?? 0;

    notifyListeners();
  }

  savePageIndexToPrefs({required String key, required int value}) async {
    await initPrefs();
    prefs!.setInt(key, value);
  }

  void changePageIndex(int newPageIndex) {
    _pageIndex = newPageIndex;
    savePageIndexToPrefs(key: pageIndexKey, value: _pageIndex!);
    notifyListeners();
  }
}