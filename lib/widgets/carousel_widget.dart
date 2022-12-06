import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'filtered_image_stack.dart';

class PictureCarousel extends StatefulWidget {
  List<FilteredImageStack> imageList = [];

  PictureCarousel({required List<FilteredImageStack> images, super.key}) {
    imageList = images;
  }

  @override
  State<PictureCarousel> createState() => _PictureCarouselState(imageList);
}

class _PictureCarouselState extends State<PictureCarousel> {
  int _currentIndex = 0;
  var imageList;

  _PictureCarouselState(List<FilteredImageStack> images) {
    imageList = images;
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: this.imageList,
      options: CarouselOptions(
        onPageChanged: (index, reason) {
          setState(() {
            print(index);
            _currentIndex = index;
          });
        },
        height: 500,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
