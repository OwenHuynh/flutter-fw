import 'package:components/res/res.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerRectangle extends StatelessWidget {
  const ShimmerRectangle({Key? key, required this.size, this.radius = 4})
      : super(key: key);

  final Size size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerDefault,
      highlightColor: AppColors.shimmerAnimated,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
        ),
      ),
    );
  }
}
