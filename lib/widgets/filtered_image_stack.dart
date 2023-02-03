import 'package:flutter/material.dart';

List<FilteredImageStack> getFilteredImages({required List unfilteredImages}) {
  List<FilteredImageStack> filteredPictures = [];
  unfilteredImages.forEach(
      (image) => filteredPictures.add(FilteredImageStack(image: image)));
  return filteredPictures;
}

class FilteredImageStack extends StatelessWidget {
  final Image image;

  const FilteredImageStack({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Container(
          margin: const EdgeInsets.all(0.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: image.image,
              fit: BoxFit.cover,
            ),
          ),
        )),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Colors.grey.withOpacity(0.7),
                  Colors.grey.withOpacity(0.7),
                  Colors.grey.withOpacity(0.6),
                  Colors.grey.withOpacity(0.5),
                  Colors.grey.withOpacity(0.4),
                  Colors.grey.withOpacity(0.3),
                  Colors.grey.withOpacity(0.2),
                  Colors.grey.withOpacity(0.1),
                  Colors.grey.withOpacity(0.08),
                  Colors.grey.withOpacity(0.05),
                  Colors.grey.withOpacity(0.025),
                  Colors.grey.withOpacity(0.0),
                  Colors.grey.withOpacity(0.0),
                  Colors.grey.withOpacity(0.0),
                  Colors.grey.withOpacity(0.0),
                  Colors.grey.withOpacity(0.0),
                  Colors.grey.withOpacity(0.0),
                  Colors.grey.withOpacity(0.0),
                  Colors.grey.withOpacity(0.0),
                  Colors.grey.withOpacity(0.0),
                  Colors.grey.withOpacity(0.0),
                  const Color(0x00000000),
                  const Color(0x00000000),
                  const Color(0x00000000),
                  const Color(0x00000000),
                  const Color(0x00000000),
                  const Color(0x00000000),
                  const Color(0x00000000),
                  const Color(0x00000000),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
