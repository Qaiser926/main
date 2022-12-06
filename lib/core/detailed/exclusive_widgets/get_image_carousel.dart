import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/services/data_handling/data_handling.dart';
import '../../../widgets/carousel_widget.dart';
import '../../../widgets/filtered_image_stack.dart';


class getImageCarousel extends StatelessWidget {
  List<String>? pictures;
  String categoryId;
  getImageCarousel({super.key, required this.pictures, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    List images = [];
    if (pictures != null) {
      pictures!.forEach((element) {
        images.add(getPhotoNullSave(categoryId: categoryId, photo: element));
      });
    } else {
      images.add(getPhotoNullSave(categoryId: categoryId));
    }
    return Container(
      // height of picture
      height: 327.h,
      width: double.infinity,
      //decoration: BoxDecoration(
      //borderRadius:
      // radius of the picture
      //BorderRadius.vertical(bottom: Radius.circular(22.h)),
      //image: DecorationImage(
      // image: AssetImage(
      //    "${Constant.assetImagePath}white.jpg"),
      //fit: BoxFit.fill)),
      alignment: Alignment.topCenter,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.zero,
            topRight: Radius.zero,
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)),
        child: PictureCarousel(images: getFilteredImages(unfilteredImages: images)),
      ),
    );
  }}