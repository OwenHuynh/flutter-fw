import 'package:cached_network_image/cached_network_image.dart';
import 'package:components/res/res.dart';
import 'package:flutter/material.dart';

class RoundImage extends StatelessWidget {
  const RoundImage(
    this.imageUrl, {
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholderImage,
    this.fadeInDuration = const Duration(milliseconds: 500),
  }) : super(key: key);

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadiusGeometry? borderRadius;
  final DecorationImage? placeholderImage;
  final Duration fadeInDuration;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fadeInDuration: fadeInDuration,
      imageUrl: imageUrl,
      fit: fit,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: AppColors.grey1,
        ),
      ),
      errorWidget: (_, __, dynamic error) => Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: AppColors.grey1,
          image: placeholderImage,
        ),
      ),
    );
  }
}
