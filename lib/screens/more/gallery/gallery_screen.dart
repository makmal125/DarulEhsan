import 'package:cached_network_image/cached_network_image.dart';
import 'package:darulehsan/screens/more/gallery/gallery_image_view.dart';
import 'package:darulehsan/screens/more/gallery/images_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GalleryMainScreen extends StatefulWidget {
  const GalleryMainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GalleryMainScreenState createState() => _GalleryMainScreenState();
}

class _GalleryMainScreenState extends State<GalleryMainScreen> {
  GenerateGalleryList galleryListObject = GenerateGalleryList.get();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(2, 67, 4, 1),
            title: const Text("تصاویر"),
            centerTitle: true,
          ),
          body: Container(
            margin: const EdgeInsets.all(12),
            child: StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 12,
                itemCount: galleryListObject.galleryList.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => GallerySlideCard(
                                  cardImage:
                                      galleryListObject.galleryList[index]),
                            ),
                          );
                        },
                        child: Hero(
                          tag: galleryListObject.galleryList[index],
                          child: Image(
                            image: CachedNetworkImageProvider(
                              galleryListObject.galleryList[index],
                              cacheKey: galleryListObject.galleryList[index]
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (index) {
                  return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
                }),
          ),
        ),
      ),
    );
  }
}
