import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImagenCompress extends ChangeNotifier {
  File? _originalImage;
  File? _compressedImage;
  String compressedImagePath = "/storage/emulated/0/Download/";

  File? get originalImage => _originalImage;
  File? get compressedImage => _compressedImage;

  Future pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _originalImage = File(pickedFile.path);
       compressImage();
      notifyListeners();
    }
  }

  Future compressImage() async {
    if (_originalImage == null) return null;

    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      _originalImage!.path,
      "$compressedImagePath/file1.jpg",
      quality: 15,
    );

    if (compressedFile != null) {
      _compressedImage = compressedFile as File?;
      notifyListeners();
      print(await _originalImage!.length());
      print(await compressedFile.length());
    }
  }


 void deleteImage() {
    _originalImage = null;
    _compressedImage = null;
    notifyListeners();
  }
}
