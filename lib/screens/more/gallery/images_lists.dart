import 'package:darulehsan/utilities/keys.dart';
import 'package:intl/intl.dart' as intl;

class GenerateGalleryList {
  List<String> galleryList = [];

  GenerateGalleryList();
  GenerateGalleryList.get() {
    intl.NumberFormat formatter = intl.NumberFormat("00");
    for (int i = 1; i < 45; i++) {
      if (i == 13 ||
          i == 11 ||
          i == 4 ||
          i == 19 ||
          i == 34 ||
          i == 43 ||
          i == 42) {
      } else {
        galleryList.add(
            '$DOMAIN_URL/$SUB_URL/portfolio/Thumbs/1-${formatter.format(i)}.jpg');
      }
    }
    for (int i = 1; i < 18; i++) {
      galleryList.add(
          '$DOMAIN_URL/$SUB_URL/portfolio/Thumbs/2-${formatter.format(i)}.jpg');
    }
    for (int i = 1; i < 49; i++) {
      if (i == 2 ||
          i == 3 ||
          i == 31 ||
          i == 35 ||
          i == 36 ||
          i == 38 ||
          i == 44) {
      } else {
        galleryList.add(
            '$DOMAIN_URL/$SUB_URL/portfolio/Thumbs/3-${formatter.format(i)}.jpg');
      }
    }
    for (int i = 1; i < 3; i++) {
      galleryList.add(
          '$DOMAIN_URL/$SUB_URL/portfolio/Thumbs/4-${formatter.format(i)}.jpg');
    }
  }
}
