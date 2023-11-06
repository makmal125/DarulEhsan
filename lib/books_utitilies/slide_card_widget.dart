import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class SlideCard extends StatelessWidget {
  const SlideCard({super.key, required this.cardImage});
  final String cardImage;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         
        Expanded(
          child: PhotoView(
            heroAttributes: PhotoViewHeroAttributes(tag: cardImage),
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.covered * 2,
              wantKeepAlive: true,
              imageProvider: CachedNetworkImageProvider(
                cardImage,
                cacheKey: cardImage
                            
              ),
              backgroundDecoration: const BoxDecoration(color: Colors.white),
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
    );
  }
}
