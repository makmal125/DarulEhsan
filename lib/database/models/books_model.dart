

class BookModel {
   int? id;
   int? bookId;
   String? bookNameUr;
   String? bookNameEn;
   String? bookHomepageUrl;
   int? chapter;
   int? pages;
  BookModel(
      {required id,
      required bookId,
      required bookNameUr,
      required bookNameEn,
      required bookHomepageUrl,
      required chapter,
      required pages});
  
  
}