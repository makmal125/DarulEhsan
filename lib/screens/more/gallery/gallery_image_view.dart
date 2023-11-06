import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

// ignore: must_be_immutable
class GallerySlideCard extends StatefulWidget {
  String cardImage = '';

  GallerySlideCard({super.key, required this.cardImage});
  
  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _GallerySlideCard(cardImage);
}

class _GallerySlideCard extends State<GallerySlideCard> {
  final String _cardImage;
  double _scale = 1.0;
  double _previousScale = 0;
  _GallerySlideCard(this._cardImage);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
              backgroundColor: const Color.fromRGBO(2, 67, 4, 1),
              title: const Text(""),
              centerTitle: true,
            ),
        body: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Expanded(
             child: PhotoView(
                 heroAttributes: PhotoViewHeroAttributes(tag: _cardImage),
                 minScale: PhotoViewComputedScale.contained * 0.8,
                 maxScale: PhotoViewComputedScale.covered * 2,
                 wantKeepAlive: true,
                 imageProvider: CachedNetworkImageProvider(
                   _cardImage,
                   cacheKey: _cardImage
                 ),
                 backgroundDecoration: const BoxDecoration(color: Colors.black),
                 loadingBuilder: (context, event) => Center(
                       // ignore: sized_box_for_whitespace
                       child: Container(
                         width: 30.0,
                         height: 30.0,
                         child: const CircularProgressIndicator(
                           backgroundColor: Color.fromRGBO(248, 147, 0, 1),
                         ),
                       ),
                     )),
           ),
         ],
       ),
      ),
    );

    //   return Column(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       Expanded(
    //         child: PhotoView(
    //             heroAttributes: PhotoViewHeroAttributes(tag: cardImage),
    //             minScale: PhotoViewComputedScale.contained * 0.8,
    //             maxScale: PhotoViewComputedScale.covered * 2,
    //             wantKeepAlive: true,
    //             imageProvider: CachedNetworkImageProvider(
    //               cardImage,
    //             ),
    //             backgroundDecoration: const BoxDecoration(color: Colors.white),
    //             loadingBuilder: (context, event) => Center(
    //                   // ignore: sized_box_for_whitespace
    //                   child: Container(
    //                     width: 30.0,
    //                     height: 30.0,
    //                     child: const CircularProgressIndicator(
    //                       backgroundColor: Color.fromRGBO(248, 147, 0, 1),
    //                     ),
    //                   ),
    //                 )),
    //       ),
    //     ],
    //   );
  }
}
