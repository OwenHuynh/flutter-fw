import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ShotView extends StatefulWidget {
  ShotView({required this.child, this.controller});

  final Widget child;
  final ShotController? controller;

  @override
  _ShotViewState createState() => _ShotViewState();
}

class _ShotViewState extends State<ShotView> {
  GlobalKey<_OverRepaintBoundaryState> globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      widget.controller!.setGlobalKey(globalKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _OverRepaintBoundary(
      key: globalKey,
      child: RepaintBoundary(
        child: widget.child,
      ),
    );
  }
}

class _OverRepaintBoundary extends StatefulWidget {
  const _OverRepaintBoundary({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  _OverRepaintBoundaryState createState() => _OverRepaintBoundaryState();
}

class _OverRepaintBoundaryState extends State<_OverRepaintBoundary> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class ShotController {
  late GlobalKey<_OverRepaintBoundaryState> globalKey;

  Future<Uint8List> makeImageUInt8List() async {
    final RenderRepaintBoundary boundary =
        // ignore: cast_nullable_to_non_nullable
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final dpr = ui.window.devicePixelRatio;
    final ui.Image image = await boundary.toImage(pixelRatio: dpr);
    final ByteData byteData = await (image.toByteData(
        format: ui.ImageByteFormat.png) as Future<ByteData>);
    final Uint8List pngBytes = byteData.buffer.asUint8List();
    return pngBytes;
  }

  // ignore: use_setters_to_change_properties
  void setGlobalKey(GlobalKey<_OverRepaintBoundaryState> globalKey) {
    this.globalKey = globalKey;
  }
}
