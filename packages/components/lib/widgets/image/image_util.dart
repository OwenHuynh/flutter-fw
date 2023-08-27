import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class ImageUtil {
  static ui.Image? kline_logo;

  static Future loadImage(String path, int width, int height) async {
    final data = await rootBundle.load(path);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: height, targetWidth: width);
    final info = await codec.getNextFrame();
    return info.image;
  }

  static String getImgPath(String name,
      {ImageFormat format = ImageFormat.png}) {
    return 'assets/images/$name.${format.value}';
  }
}

enum ImageFormat { png, jpg, gif, webp }

extension ImageFormatExtension on ImageFormat {
  String get value => ['png', 'jpg', 'gif', 'webp'][index];
}
