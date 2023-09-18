import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageProcessing {
  Future<File> takePicureCamera() async {
    // print("Start camera");
    final XFile? imagePicked = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 30,
      maxHeight: 500,
      maxWidth: 500,
    );
    return File(imagePicked!.path);
  }

  Future<File> takePicureGallery() async {
    final XFile? imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return File(imagePicked!.path);
  }
}
