import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

//*****************//

// class ImagenCompress extends ChangeNotifier {
//   File? _originalImage;
//   File? _compressedImage;
//   String compressedImagePath = "/storage/emulated/0/Download/";

//   File? get originalImage => _originalImage;
//   File? get compressedImage => _compressedImage;

//   Future pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       _originalImage = File(pickedFile.path);
//       await compressImage();
//       notifyListeners();
//     }
//   }

//   Future compressImage() async {
//     if (_originalImage == null) return;

//     final compressedFile = await FlutterImageCompress.compressAndGetFile(
//       _originalImage!.path,
//       "$compressedImagePath/${DateTime.now().millisecondsSinceEpoch}.jpg",
//       quality: 15,
//     );

//     if (compressedFile != null) {
//       _compressedImage = compressedFile;
//       notifyListeners();

//       // Imprimir tamaños para depuración
//       final originalSizeMB = _bytesToMB(await _originalImage!.length());
//       final compressedSizeMB = _bytesToMB(await compressedFile.length());
//       print('Tamaño original: ${originalSizeMB.toStringAsFixed(2)} MB');
//       print('Tamaño comprimido: ${compressedSizeMB.toStringAsFixed(2)} MB');
//     }
//   }

//   void deleteImage() async {
//     // Elimina el archivo comprimido si existe
//     if (_compressedImage != null && _compressedImage!.existsSync()) {
//       await _compressedImage!.delete();
//     }
//     _originalImage = null;
//     _compressedImage = null;
//     notifyListeners();
//   }

//   double _bytesToMB(int bytes) {
//     return bytes / (1024 * 1024); // Convierte bytes a MB
//   }
// }

//********************//

// class ImagenCompress extends ChangeNotifier {
//   File? _compressedImage;
//   String compressedImagePath = "/storage/emulated/0/Download/";

//   File? get compressedImage => _compressedImage;

//   Future pickAndCompressImage() async {
//     final picker = ImagePicker();

//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       final originalImage = File(pickedFile.path);

//       // Comprime la imagen
//       final compressedFile = await FlutterImageCompress.compressAndGetFile(
//         originalImage.path,
//         "$compressedImagePath/${DateTime.now().millisecondsSinceEpoch}.jpg",
//         quality: 15,
//       );

//       if (compressedFile != null) {
//         _compressedImage = compressedFile;
//         notifyListeners();
//         await originalImage.delete(); // Elimina el archivo original
//       }
//     }
//   }

//   void deleteImage() {
//     _compressedImage = null;
//     notifyListeners();
//   }
// }


//***FUNCION GENERICA **/

// class ImagenCompress extends ChangeNotifier {
//   File? _compressedImage;
//   String compressedImagePath = "/storage/emulated/0/Download/";

//   File? get compressedImage => _compressedImage;

//   Future pickOrCaptureImage(ImageSource source) async {
//     final picker = ImagePicker();

//     final pickedFile = await picker.pickImage(source: source);

//     if (pickedFile != null) {
//       final originalImage = File(pickedFile.path);

//       // Comprime la imagen
//       final compressedFile = await FlutterImageCompress.compressAndGetFile(
//         originalImage.path,
//         "$compressedImagePath/${DateTime.now().millisecondsSinceEpoch}.jpg",
//         quality: 15,
//       );

//       if (compressedFile != null) {
//         _compressedImage = compressedFile;
//         notifyListeners();
//         await originalImage.delete(); // Elimina el archivo original
//       }
//     }
//   }

//   void deleteImage() {
//     _compressedImage = null;
//     notifyListeners();
//   }
// }


class ImagenCompress extends ChangeNotifier {
  File? _compressedImage;
  String compressedImagePath = "/storage/emulated/0/Download/";

  File? get compressedImage => _compressedImage;

  Future pickOrCaptureImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final originalImage = File(pickedFile.path);

      // Comprime la imagen
      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        originalImage.path,
        "$compressedImagePath/${DateTime.now().millisecondsSinceEpoch}.jpg",
        quality: 15,
      );

      if (compressedFile != null) {
        _compressedImage = compressedFile;
        notifyListeners();
        await originalImage.delete(); // Elimina el archivo original
      }
    }
  }

  Future<void> deleteImage() async {
    if (_compressedImage != null) {
      try {
        if (await _compressedImage!.exists()) {
          await _compressedImage!.delete(); // Elimina el archivo comprimido del dispositivo
        }
      } catch (e) {
        print("Error deleting image: $e");
      }
      _compressedImage = null;
      notifyListeners();
    }
  }
}
       
       //************GUARDA EN LA GALERIA************ */
// class ImagenCompress extends ChangeNotifier {
//   File? _compressedImage;

//   File? get compressedImage => _compressedImage;

//   Future pickOrCaptureImage(ImageSource source) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: source);

//     if (pickedFile != null) {
//       final originalImage = File(pickedFile.path);

//       // Comprime la imagen
//       final tempDir = await getTemporaryDirectory();
//       final compressedFile = await FlutterImageCompress.compressAndGetFile(
//         originalImage.path,
//         "${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg",
//         quality: 15,
//       );

//       if (compressedFile != null) {
//         _compressedImage = compressedFile;
//         notifyListeners();
//         await originalImage.delete(); // Elimina el archivo original

//         // Guarda la imagen comprimida en la galería
//         final result = await GallerySaver.saveImage(compressedFile.path);
//         if (!result!) {
//           print("Failed to save image to gallery");
//         }
//       }
//     }
//   }

//   Future<void> deleteImage() async {
//     if (_compressedImage != null) {
//       try {
//         if (await _compressedImage!.exists()) {
//           await _compressedImage!.delete(); // Elimina el archivo comprimido del dispositivo
//         }
//       } catch (e) {
//         print("Error deleting image: $e");
//       }
//       _compressedImage = null;
//       notifyListeners();
//     }
//   }
// }

//****** VARIAS IMAGENES INDEPENDIENTES  ********//

// class ImagenCompress extends ChangeNotifier {
//   List<File> _compressedImages = [];
//   String compressedImagePath = "/storage/emulated/0/Download/";

//   List<File> get compressedImages => _compressedImages;

//   Future pickOrCaptureImage(ImageSource source) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: source);

//     if (pickedFile != null) {
//       final originalImage = File(pickedFile.path);

//       // Comprime la imagen
//       final compressedFile = await FlutterImageCompress.compressAndGetFile(
//         originalImage.path,
//         "$compressedImagePath/${DateTime.now().millisecondsSinceEpoch}.jpg",
//         quality: 15,
//       );

//       if (compressedFile != null) {
//         _compressedImages.add(compressedFile);
//         notifyListeners();
//         await originalImage.delete(); // Elimina el archivo original
//       }
//     }
//   }

//   void deleteImage(File image) {
//     _compressedImages.remove(image);
//     notifyListeners();
//   }

//   void deleteAllImages() {
//     _compressedImages.clear();
//     notifyListeners();
//   }
// }

//******** ELIMINA LAS IMAGENES DE LA LISTA Y DEL DISPOSITIVO  ************//
// class ImagenCompress extends ChangeNotifier {
//   List<File> _compressedImages = [];
//   String compressedImagePath = "/storage/emulated/0/Download/";

//   List<File> get compressedImages => _compressedImages;

//   Future pickOrCaptureImage(ImageSource source) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: source);

//     if (pickedFile != null) {
//       final originalImage = File(pickedFile.path);

//       // Comprime la imagen
//       final compressedFile = await FlutterImageCompress.compressAndGetFile(
//         originalImage.path,
//         "$compressedImagePath/${DateTime.now().millisecondsSinceEpoch}.jpg",
//         quality: 15,
//       );

//       if (compressedFile != null) {
//         _compressedImages.add(compressedFile);
//         notifyListeners();
//         await originalImage.delete(); // Elimina el archivo original
//       }
//     }
//   }

//   void deleteImage(File image) async {
//     try {
//       if (await image.exists()) {
//         await image.delete(); // Elimina el archivo del dispositivo
//       }
//     } catch (e) {
//       print("Error deleting image: $e");
//     }
//     _compressedImages.remove(image);
//     notifyListeners();
//   }

//   void deleteAllImages() async {
//     for (var image in _compressedImages) {
//       try {
//         if (await image.exists()) {
//           await image.delete(); // Elimina cada archivo del dispositivo
//         }
//       } catch (e) {
//         print("Error deleting image: $e");
//       }
//     }
//     _compressedImages.clear();
//     notifyListeners();
//   }
// }


//***********guarda la imagen en la galeria**********//
// class ImagenCompress extends ChangeNotifier {
//   List<File> _compressedImages = [];

//   List<File> get compressedImages => _compressedImages;

//   Future pickOrCaptureImage(ImageSource source) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: source);

//     if (pickedFile != null) {
//       final originalImage = File(pickedFile.path);

//       // Comprime la imagen
//       final compressedFile = await FlutterImageCompress.compressAndGetFile(
//         originalImage.path,
//         await _getGalleryPath() + "/${DateTime.now().millisecondsSinceEpoch}.jpg",
//         quality: 15,
//       );

//       if (compressedFile != null) {
//         _compressedImages.add(compressedFile);
//         notifyListeners();
//         await originalImage.delete(); // Elimina el archivo original
//         // Guarda la imagen comprimida en la galería
//         await GallerySaver.saveImage(compressedFile.path);
//       }
//     }
//   }

//   Future<String> _getGalleryPath() async {
//     final directory = await getExternalStorageDirectory();
//     return directory?.path ?? '/storage/emulated/0/Pictures';
//   }

//   void deleteImage(File image) async {
//     try {
//       if (await image.exists()) {
//         await image.delete(); // Elimina el archivo del dispositivo
//       }
//     } catch (e) {
//       print("Error deleting image: $e");
//     }
//     _compressedImages.remove(image);
//     notifyListeners();
//   }

//   void deleteAllImages() async {
//     for (var image in _compressedImages) {
//       try {
//         if (await image.exists()) {
//           await image.delete(); // Elimina cada archivo del dispositivo
//         }
//       } catch (e) {
//         print("Error deleting image: $e");
//       }
//     }
//     _compressedImages.clear();
//     notifyListeners();
//   }
// }
