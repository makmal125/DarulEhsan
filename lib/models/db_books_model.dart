// ignore_for_file: prefer_typing_uninitialized_variables

class DbBooksModel {
  var dbId;
  var dbChapter;
  var dbBookId;
  var dbBookNameUr;
  var dbBookNameEn;
  var dbBookHomePageUrl;
  var dbPages;
  DbBooksModel(
      {required this.dbId,
      required this.dbChapter,
      required this.dbBookId,
      required this.dbBookNameUr,
      required this.dbBookNameEn,
      required this.dbBookHomePageUrl,
      required this.dbPages});
  factory DbBooksModel.fromMap(Map<String, dynamic> item) {
    return DbBooksModel(
        dbId: item['id'],
        dbChapter: item['chapter'],
        dbBookId: item['bookId'],
        dbBookNameUr: item['bookNameUr'],
        dbBookNameEn: item['bookNameEn'],
        dbBookHomePageUrl: item['bookHomepageUrl'],
        dbPages: item['pages']);
  }
}