import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:simplest/simplest.dart';

class ImagePickerHelper {
  /// Select image from device
  static Future<File> onSelectImageFromDevice(BuildContext context) async {
    final picker = ImagePicker();
    File fileImage;
    ImageSource source = await showSelectImageSource(context);
    if (source != null) {
      final pickedFile = await picker.getImage(source: source);
      fileImage = File(pickedFile.path);
    }
    return fileImage;
  }

  static Future<ImageSource> showSelectImageSource(BuildContext context) async {
    return showCupertinoModalPopup<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text('camera'.tr),
              onPressed: () {
                Navigator.pop(context, ImageSource.camera);
              },
            ),
            CupertinoActionSheetAction(
              child: Text('gallery'.tr),
              onPressed: () {
                Navigator.pop(context, ImageSource.gallery);
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text('cancel'.tr),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}
