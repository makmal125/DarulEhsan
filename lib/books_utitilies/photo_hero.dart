import 'package:cached_network_image/cached_network_image.dart';
import 'package:darulehsan/utilities/load_swiper_images.dart';
import 'package:flutter/material.dart';

class PhotoHero extends StatelessWidget {
   const PhotoHero(
      {Key? key, required this.photo, required this.onTap, required this.width})
      : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: 
            //ServerLocalImage(baseUrl: photo,)
             CachedNetworkImage(
                 imageUrl: photo,
                 imageBuilder: (context, imageProvider) => Container(
                   decoration: BoxDecoration(
                     image: DecorationImage(
                       image: imageProvider,
                       fit: BoxFit.contain,
                       colorFilter: const ColorFilter.mode(
                         Colors.white,
                         BlendMode.darken,
                       ),
                     ),
                   ),
                 ),
                 placeholder: (context, url) =>
                     const CircularProgressIndicator(value: 0,),
                 errorWidget: (context, url, error) => const Icon(Icons.error),
               )
            
          ),
        ),
      ),
    );
  }
}