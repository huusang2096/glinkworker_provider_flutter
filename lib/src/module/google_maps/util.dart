import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<BitmapDescriptor> createBitmapDescriptor(
    BuildContext context, String assetImage,
    {int width = 70}) async {
  final Uint8List markerIcon =
      await getBytesFromAsset(context, assetImage, width);
  return BitmapDescriptor.fromBytes(markerIcon);
}

Future<Uint8List> getBytesFromAsset(
    BuildContext context, String path, int width) async {
  ByteData data = await DefaultAssetBundle.of(context).load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
      .buffer
      .asUint8List();
}
