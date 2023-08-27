import 'package:components/res/res.dart';
import 'package:flutter/material.dart';

class ImageUtils {
  static Image getAssetImageWithBandColor(String assetFilePath) {
    String newAssetFilePath = "";

    if (!assetFilePath.startsWith("assets")) {
      newAssetFilePath = "assets/$assetFilePath";
    }
    return getAssetImageWithColor(newAssetFilePath, AppColors.colorLink);
  }

  static Image getAssetImageWithColor(String assetFilePath, Color color) {
    String newAssetFilePath = "";
    if (!assetFilePath.startsWith("assets")) {
      newAssetFilePath = "assets/$assetFilePath";
    }
    return Image.asset(
      newAssetFilePath,
      color: color,
      scale: 3,
    );
  }

  static Image getAssetImage(String assetFilePath,
      {BoxFit? fit, bool gaplessPlayback = false}) {
    String newAssetFilePath = "";

    if (!assetFilePath.startsWith("assets")) {
      newAssetFilePath = "assets/$assetFilePath";
    }
    return Image.asset(
      newAssetFilePath,
      fit: fit,
      scale: 3,
      gaplessPlayback: gaplessPlayback,
    );
  }
}
