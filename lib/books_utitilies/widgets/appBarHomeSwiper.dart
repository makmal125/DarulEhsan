
// ignore_for_file: file_names

import 'package:darulehsan/utilities/load_swiper_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class HomeAppBarSwiper extends StatelessWidget {
  const HomeAppBarSwiper({
    super.key,
  });
  
  

  @override
  Widget build(BuildContext context) {
    var images = [
      'http://www.darulehsan132.com/assets/img/portfolio/Thumbs/1-06.jpg',
      'http://www.darulehsan132.com/assets/img/portfolio/Thumbs/1-08.jpg',
      'http://www.darulehsan132.com/assets/img/portfolio/Thumbs/1-03.jpg',
      'http://www.darulehsan132.com/assets/img/portfolio/Thumbs/1-07.jpg',
      'http://www.darulehsan132.com/assets/img/portfolio/Thumbs/2-01.jpg',
      'http://www.darulehsan132.com/assets/img/portfolio/Thumbs/1-36.jpg',
      'http://www.darulehsan132.com/assets/img/portfolio/Thumbs/4-01.jpg',
      'http://www.darulehsan132.com/assets/img/portfolio/Thumbs/4-02.jpg',
      'https://dsngponqkfiomhhdlhgv.supabase.co/storage/v1/object/public/aditionalBooks/Taqwim_page-0006.jpg?t=2023-10-04T02%3A12%3A53.141Z'
    ];
    
    return Swiper(
      itemCount: images.length,
      itemBuilder: (BuildContext context, int index) {
       return SwiperServerLocalImage(baseUrl:images[index]);
      },
      
      autoplay: false,
    );
  }
}