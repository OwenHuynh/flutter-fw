import 'package:components/res/res.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCircle extends StatelessWidget {
  const ShimmerCircle(this.size, {Key? key}) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerDefault,
      highlightColor: AppColors.shimmerAnimated,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(width: size, height: size, color: AppColors.primary),
      ),
    );
  }
}
