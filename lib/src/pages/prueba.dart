


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nseguridad/src/controllers/prueba_controller.dart';
import 'package:provider/provider.dart';

// class Prueba extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ImagenCompress>(
//       builder: (context, imageProvider, _) {
//         final File? originalImage = imageProvider.originalImage;
//         final File? compressedImage = imageProvider.compressedImage;

//         return SafeArea(
//           child: Scaffold(
//             body: Column(
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     imageProvider.deleteImage();
//                   },
//                   child: Text('BORRAR'),
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: SizedBox(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "Original Image",
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             originalImage != null
//                                 ? Image.file(originalImage)
//                                 : TextButton(
//                                     onPressed: () {
//                                       imageProvider.pickImage();
//                                     },
//                                     child: Text("Pick an Image"),
//                                   ),
//                             if (originalImage != null)
//                               FutureBuilder<int>(
//                                 future: originalImage.length(),
//                                 builder: (context, snapshot) {
//                                   if (snapshot.connectionState ==
//                                       ConnectionState.waiting) {
//                                     return CircularProgressIndicator();
//                                   }
//                                   if (snapshot.hasError) {
//                                     return Text("Error: ${snapshot.error}");
//                                   }
//                                   final originalSizeMB =
//                                       _bytesToMB(snapshot.data!);
//                                   return Text(
//                                     "Size: ${originalSizeMB.toStringAsFixed(2)} MB",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   );
//                                 },
//                               ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: SizedBox(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "Compressed Image",
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             compressedImage != null
//                                 ? Image.file(compressedImage)
//                                 : TextButton(
//                                     onPressed: () {
//                                       imageProvider.compressImage();
//                                     },
//                                     child: Text("Compress Image"),
//                                   ),
//                             if (compressedImage != null)
//                               FutureBuilder<int>(
//                                 future: compressedImage.length(),
//                                 builder: (context, snapshot) {
//                                   if (snapshot.connectionState ==
//                                       ConnectionState.waiting) {
//                                     return CircularProgressIndicator();
//                                   }
//                                   if (snapshot.hasError) {
//                                     return Text("Error: ${snapshot.error}");
//                                   }
//                                   final compressedSizeMB =
//                                       _bytesToMB(snapshot.data!);
//                                   return Text(
//                                     "Size: ${compressedSizeMB.toStringAsFixed(2)} MB",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   );
//                                 },
//                               ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   double _bytesToMB(int bytes) {
//     return bytes / (1024 * 1024); // Convierte bytes a MB
//   }
// }


// class Prueba extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ImagenCompress>(
//       builder: (context, imageProvider, _) {
//         final File? compressedImage = imageProvider.compressedImage;

//         return SafeArea(
//           child: Scaffold(
//             body: Column(
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     imageProvider.deleteImage();
//                   },
//                   child: Text('BORRAR'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     imageProvider.pickAndCompressImage();
//                   },
//                   child: Text('Pick and Compress Image'),
//                 ),
//                 Expanded(
//                   child: Center(
//                     child: compressedImage != null
//                         ? Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Image.file(compressedImage),
//                               FutureBuilder<int>(
//                                 future: compressedImage.length(),
//                                 builder: (context, snapshot) {
//                                   if (snapshot.connectionState ==
//                                       ConnectionState.waiting) {
//                                     return CircularProgressIndicator();
//                                   }
//                                   if (snapshot.hasError) {
//                                     return Text("Error: ${snapshot.error}");
//                                   }
//                                   final compressedSizeMB =
//                                       _bytesToMB(snapshot.data!);
//                                   return Text(
//                                     "Compressed Size: ${compressedSizeMB.toStringAsFixed(2)} MB",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ],
//                           )
//                         : Text('No compressed image'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   double _bytesToMB(int bytes) {
//     return bytes / (1024 * 1024); // Convierte bytes a MB
//   }
// }
//********IMAGEN DESDE CAMARA O GALERIA *********/

class Prueba extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ImagenCompress>(
      builder: (context, imageProvider, _) {
        final File? compressedImage = imageProvider.compressedImage;

        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                TextButton(
                  onPressed: () {
                    imageProvider.deleteImage();
                  },
                  child: Text('BORRAR'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showImageSourceDialog(context, imageProvider);
                  },
                  child: Text('Pick or Capture Image'),
                ),
                Expanded(
                  child: Center(
                    child: compressedImage != null
                        ? SingleChildScrollView(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.file(compressedImage),
                                FutureBuilder<int>(
                                  future: compressedImage.length(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    }
                                    if (snapshot.hasError) {
                                      return Text("Error: ${snapshot.error}");
                                    }
                                    final compressedSizeMB =
                                        _bytesToMB(snapshot.data!);
                                    return Text(
                                      "Compressed Size: ${compressedSizeMB.toStringAsFixed(2)} MB",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    );
                                  },
                                ),
                             
                             
                             
                              ],
                            ),
                        )
                        : Text('No compressed image'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showImageSourceDialog(BuildContext context, ImagenCompress imageProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Image Source'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                imageProvider.pickOrCaptureImage(ImageSource.camera);
              },
              child: Text('Take Photo'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                imageProvider.pickOrCaptureImage(ImageSource.gallery);
              },
              child: Text('Pick from Gallery'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  double _bytesToMB(int bytes) {
    return bytes / (1024 * 1024); // Convierte bytes a MB
  }
}


//********* multiples imagenes independientes almacenadas en una LISTA Y EN LA GALERIA  **********/



// class Prueba extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ImagenCompress>(
//       builder: (context, imageProvider, _) {
//         final List<File> compressedImages = imageProvider.compressedImages;

//         return SafeArea(
//           child: Scaffold(
//             body: Column(
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     imageProvider.deleteAllImages();
//                   },
//                   child: Text('BORRAR TODOS'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     _showImageSourceDialog(context, imageProvider);
//                   },
//                   child: Text('Pick or Capture Image'),
//                 ),
//                 Expanded(
//                   child: compressedImages.isNotEmpty
//                       ? GridView.builder(
//                           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             crossAxisSpacing: 8,
//                             mainAxisSpacing: 8,
//                           ),
//                           itemCount: compressedImages.length,
//                           itemBuilder: (context, index) {
//                             final image = compressedImages[index];
//                             return Stack(
//                               fit: StackFit.expand,
//                               children: [
//                                 Image.file(image, fit: BoxFit.cover),
//                                 Positioned(
//                                   right: 8,
//                                   top: 8,
//                                   child: IconButton(
//                                     icon: Icon(Icons.delete, color: Colors.red),
//                                     onPressed: () {
//                                       imageProvider.deleteImage(image);
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                         )
//                       : Center(child: Text('No compressed images')),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _showImageSourceDialog(BuildContext context, ImagenCompress imageProvider) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Select Image Source'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 imageProvider.pickOrCaptureImage(ImageSource.camera);
//               },
//               child: Text('Take Photo'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 imageProvider.pickOrCaptureImage(ImageSource.gallery);
//               },
//               child: Text('Pick from Gallery'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Cancel'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }



//********** GUARDA EN GALERIA DE MANERA INDEPENDIENTE Y LA ELIMINA DEL DISPOSITIVO**********//


// class Prueba extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ImagenCompress>(
//       builder: (context, imageProvider, _) {
//         final File? compressedImage = imageProvider.compressedImage;

//         return SafeArea(
//           child: Scaffold(
//             appBar: AppBar(
//               title: Text('Image Compression Example'),
//             ),
//             body: Column(
//               children: [
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {
//                         imageProvider.pickOrCaptureImage(ImageSource.camera);
//                       },
//                       child: Text('Take a Photo'),
//                     ),
//                     SizedBox(width: 20),
//                     ElevatedButton(
//                       onPressed: () {
//                         imageProvider.pickOrCaptureImage(ImageSource.gallery);
//                       },
//                       child: Text('Pick from Gallery'),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 compressedImage != null
//                     ? Expanded(
//                         child: Column(
//                           children: [
//                             Text(
//                               "Compressed Image",
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             SizedBox(height: 20),
//                             Image.file(
//                               compressedImage,
//                               width: double.infinity,
//                               height: 300,
//                               fit: BoxFit.cover,
//                             ),
//                             SizedBox(height: 20),
//                             Text(
//                               "File size: ${compressedImage.lengthSync() / (1024 * 1024)} MB",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                             SizedBox(height: 20),
//                             ElevatedButton(
//                               onPressed: () {
//                                 imageProvider.deleteImage();
//                               },
//                               child: Text('Delete Image'),
//                             ),
//                           ],
//                         ),
//                       )
//                     : Center(
//                         child: Text(
//                           "No image selected or compressed",
//                           style: TextStyle(fontSize: 18),
//                         ),
//                       ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


// // import 'dart:io';
// // import 'package:file_picker/file_picker.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_pdfview/flutter_pdfview.dart';
// // import 'package:image_gallery_saver/image_gallery_saver.dart';
// // import 'package:nseguridad/src/controllers/home_ctrl.dart';
// // import 'package:permission_handler/permission_handler.dart';
// // import 'package:provider/provider.dart';
// // import 'package:nseguridad/src/controllers/home_controller.dart';

// // // // class Prueba extends StatelessWidget {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(title: Text(
// // // //                     'subir ARCHIVO',
// // // //                     style: Theme.of(context).textTheme.headline2,
// // // //                   ),),
// // // //       body:  Container(
// // // //       child: Column(
// // // //         mainAxisAlignment: MainAxisAlignment.center,
// // // //         children: [
// // // //           ElevatedButton(
// // // //             onPressed: () async {
// // // //                bool granted = await _requestPermission();
// // // //               if (granted) {
// // // //                 String? filePath = await _pickDocument();
// // // //                 if (filePath != null) {
// // // //                   Provider.of<HomeController>(context, listen: false)
// // // //                       .setFilePath(filePath);
// // // //                   // Aquí puedes agregar la lógica para subir el documento al servidor
// // // //                 }
// // // //               } else {
// // // //                 // Permiso denegado, manejar según sea necesario
// // // //               }
// // // //             },
// // // //             child: Text('Seleccionar Documento'),
// // // //           ),
// // // //           Consumer<HomeController>(
// // // //             builder: (context, provider, _) {
// // // //               if (provider.filePath != null) {
// // // //                 return Text('Documento Seleccionado: ${provider.filePath}');
// // // //               } else {
// // // //                 return SizedBox();
// // // //               }
// // // //             },
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     ),
// // // //     );
   
// // // //   }

// // // //   Future<bool> _requestPermission() async {
// // // //     var status = await Permission.storage.status;
// // // //     if (!status.isGranted) {
// // // //       status = await Permission.storage.request();
// // // //     }
// // // //     return status.isGranted;
// // // //   }

// // // //   Future<String?> _pickDocument() async {
// // // //     FilePickerResult? result = await FilePicker.platform.pickFiles(
// // // //       type: FileType.custom,
// // // //       allowedExtensions: ['pdf', 'doc', 'docx'], // Agrega las extensiones permitidas
// // // //     );

// // // //     if (result != null) {
// // // //       return result.files.single.path!;
// // // //     } else {
// // // //       return null;
// // // //     }
// // // //   }






// // // // }



// // // import 'package:flutter/material.dart';

// // // class Prueba extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       home: ColorScreen(),
// // //     );
// // //   }
// // // }

// // // class ColorScreen extends StatefulWidget {
// // //   @override
// // //   _ColorScreenState createState() => _ColorScreenState();
// // // }

// // // class _ColorScreenState extends State<ColorScreen> {
// // //   late Color color1;
// // //   late Color color2;
// // //   late List<Color> combinedColors;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     // Inicializar los colores
// // //     color1 = Color(0xFF0c7ee9); // Azul
// // //     color2 = Color(0xFF9d4343); // Rojo oscuro
// // //     combinedColors = combineColors(color1, color2);
// // //   }

// // //   // Función para construir un contenedor de color
// // //   Widget buildColorContainer(Color color, String label) {
// // //     return Container(
// // //       color: color,
// // //       height: 50,
// // //       width: 100,
// // //       margin: EdgeInsets.symmetric(vertical: 5),
// // //       child: Center(
// // //         child: Text(
// // //           label,
// // //           style: TextStyle(
// // //             color: Colors.white,
// // //             fontWeight: FontWeight.bold,
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(title: Text('Colores combinados')),
// // //       body: Center(
// // //         child: Column(
// // //           mainAxisAlignment: MainAxisAlignment.center,
// // //           children: [
// // //             buildColorContainer(color1, 'Color 1'),
// // //             buildColorContainer(color2, 'Color 2'),
// // //             for (var i = 0; i < combinedColors.length; i++)
// // //               buildColorContainer(combinedColors[i], 'Mix ${i + 1}'),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // // List<Color> combineColors(Color color1, Color color2) {
// // //   // Función para mezclar dos colores
// // //   Color mixColors(Color a, Color b, double t) {
// // //     return Color.lerp(a, b, t)!;
// // //   }

// // //   // Generar los colores resultantes
// // //   Color colorMix1 = mixColors(color1, color2, 0.25); // 25% rojo, 75% azul
// // //   Color colorMix2 = mixColors(color1, color2, 0.5);  // 50% rojo, 50% azul
// // //   Color colorMix3 = mixColors(color1, color2, 0.75); // 75% rojo, 25% azul
// // //   Color colorMix4 = mixColors(color1, color2, 1.0);  // 100% rojo (color2)

// // //   return [colorMix1, colorMix2, colorMix3, colorMix4];
// // // }




// // import 'dart:io';

// // import 'package:dio/dio.dart';
// // import 'package:file_picker/file_picker.dart';
// // import 'package:flutter/material.dart';
// // import 'package:nseguridad/src/utils/responsive.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// // class ViewsPDFs extends StatelessWidget {
// //   // final String infoPdf;
// //   // final String labelPdf;
// //    ViewsPDFs({Key? key, 
// //   //  required this.infoPdf, 
// //   //  required this.labelPdf
// //    }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     final Responsive size = Responsive.of(context);
// //     return SafeArea(
// //       child: Scaffold(
// //         backgroundColor: const Color(0xFFEEEEEE),
// //         appBar: AppBar(
// //           title:  Text('Vista PDF'),
// //           actions: [
// //              IconButton(
// //                       // splashRadius: 2.0,
// //                       icon:  Icon(
// //                               Icons.download_outlined,
// //                               size: size.iScreen(3.5),
// //                               color: Colors.white,
// //                             ),
// //                       onPressed: () {
// //                        downloadPDFToAlbum('https://conaldi.edu.co/wp_ES/wordpress/matematicas/wp-content/uploads/sites/5/2019/06/Ejercicios-de-factorizacion-en-clase-y-casa.pdf','labelPdf');
// //                       //  _openFiles();
// //                       //  downloadAndOpenPDFS(infoPdf,labelPdf);
              

// //                       }),
// //           ],
      
// //         ),
// //         body: Container(
// //             width: size.wScreen(100),
// //             height: size.hScreen(100),
// //             padding: EdgeInsets.symmetric(
// //                 horizontal: size.iScreen(1.0), vertical: size.iScreen(1.0)),
// //             color: Colors.grey[300],
// //             child: SfPdfViewer.network('https://conaldi.edu.co/wp_ES/wordpress/matematicas/wp-content/uploads/sites/5/2019/06/Ejercicios-de-factorizacion-en-clase-y-casa.pdf',
// //                 canShowScrollHead: true, canShowScrollStatus: true)),
// //       ),
// //     );
// //   }

// // //========================================//

// //   // Future openFile({required String url, String? fileName}) async {
// //   //   final name = fileName ?? url.split('/').last;
// //   //   final file = await pickFile();
// //   //   downloadFile(url,name);
// //   //   if (file == null) return;

// //   //   OpenFile.open(file.path);
// //   // }


// // // //========================================//
// //   // Future<File?> downloadFile(String url, String name) async {
// //   //   final appStorage = await getApplicationDocumentsDirectory();
// //   //   final file = File('${appStorage.path}/$name');

// //   //   print('Phat====>: ${file.path}');

// //   //   try {
// //   //     final response = await Dio().get(url,
// //   //         options: Options(
// //   //           responseType: ResponseType.bytes,
// //   //           followRedirects: false,
// //   //           receiveTimeout: 0,
// //   //         ));
// //   //     final raf = file.openSync(mode: FileMode.write);
// //   //     raf.writeFromSync(response.data);
// //   //     await raf.close();
// //   //     return file;
// //   //   } catch (e) {
// //   //     return null;
// //   //   }
// //   // }
// // Future<void> downloadPDF(String url, String filename) async {
// //   try {
// //     final downloadsDirectory = await getApplicationSupportDirectory();
// //     final file = File('${downloadsDirectory.path}/$filename');

// //     final response = await Dio().get(
// //       url,
// //       options: Options(
// //         responseType: ResponseType.bytes,
// //       ),
// //     );

// //     await file.writeAsBytes(response.data, flush: true);

// //     print('PDF descargado en: ${file.path}');
// //   } catch (e) {
// //     print('Error al descargar el PDF: $e');
// //   }
// // }


// // // Future<void> downloadPDFToPictures(String url, String filename) async {
// // //   try {
// // //     final downloadsDirectory = await getApplicationSupportDirectory();
// // //     final downloadsFile = File('${downloadsDirectory.path}/$filename');

// // //     final response = await Dio().get(
// // //       url,
// // //       options: Options(
// // //         responseType: ResponseType.bytes,
// // //       ),
// // //     );

// // //     await downloadsFile.writeAsBytes(response.data, flush: true);

// // //     final picturesDirectory = await getExternalStorageDirectory();
// // //     final picturesFile = File('${picturesDirectory!.path}/$filename');

// // //     await downloadsFile.copy(picturesFile.path);

// // //     print('PDF descargado en la carpeta de fotos: ${picturesFile.path}');
// // //      NotificatiosnService.showSnackBarSuccsses('Descarga realizada correctamente...');
// // //   } catch (e) {
// // //     print('Error al descargar el PDF: $e');
// // //     NotificatiosnService.showSnackBarError('No se pudo realizar la descarga');
// // //   }
// // // }



// // // Future<void> downloadPDFToDownloads(String url, String filename) async {
// // //   try {
// // //     final downloadsDirectory = await getDownloadsDirectory();
// // //     final file = File('${downloadsDirectory!.path}/$filename');

// // //     final response = await Dio().get(
// // //       url,
// // //       options: Options(
// // //         responseType: ResponseType.bytes,
// // //       ),
// // //     );

// // //     await file.writeAsBytes(response.data, flush: true);

// // //     print('PDF descargado en la carpeta de descargas: ${file.path}');
// // //       NotificatiosnService.showSnackBarSuccsses('Descarga realizada correctamente...');
// // //   } catch (e) {
// // //     print('Error al descargar el PDF: $e');
// // //       NotificatiosnService.showSnackBarError('No se pudo realizar la descarga');
// // //   }
// // // }
// // // Future<void> downloadPDFToDownloads(String url, String filename) async {
// // //   try {
// // //     final directory = Directory('/storage/emulated/0/Download');

// // //     if (!(await directory.exists())) {
// // //       directory.createSync(recursive: true);
// // //     }

// // //     final file = File('${directory.path}/$filename');

// // //     final response = await Dio().get(
// // //       url,
// // //       options: Options(
// // //         responseType: ResponseType.bytes,
// // //       ),
// // //     );

// // //     await file.writeAsBytes(response.data, flush: true);

// // //     print('PDF descargado en la carpeta de descargas: ${file.path}');
// // //       NotificatiosnService.showSnackBarSuccsses('Descarga realizada correctamente...');
// // //   } catch (e) {
// // //     print('Error al descargar el PDF: $e');
// // //      NotificatiosnService.showSnackBarError('No se pudo realizar la descarga');
// // //   }
// // // }

// // // Future<void> createAndSavePDF() async {
// // //   final pdf = pw.Document();

// // //   // Agrega contenido al PDF, por ejemplo:
// // //   pdf.addPage(
// // //     pw.Page(
// // //       build: (pw.Context context) {
// // //         return pw.Center(
// // //           child: pw.Text('¡Hola, mundo!'),
// // //         );
// // //       },
// // //     ),
// // //   );

// // //   final appDocDirectory = await getApplicationDocumentsDirectory();
// // //   final downloadsDirectory = await getDownloadsDirectory();
// // //   final pdfFile = File('${downloadsDirectory.path}/mi_pdf.pdf');

// // //   await pdfFile.writeAsBytes(await pdf.save());

// // //   print('PDF guardado en la carpeta de descargas: ${pdfFile.path}');
// // // }
// // // Future<void> downloadAndOpenPDF(String url, String filename) async {
// // //   try {
// // //     final appDocDirectory = await getApplicationDocumentsDirectory();
// // //     final pdfFile = File('${appDocDirectory.path}/$filename');

// // //     final dio = Dio();
// // //     final response = await dio.get(
// // //       url,
// // //       options: Options(responseType: ResponseType.bytes),
// // //     );

// // //     await pdfFile.writeAsBytes(response.data, flush: true);

// // //     if (await pdfFile.exists()) {
// // //       final filePath = pdfFile.path;
// // //       final pdfView = PDFView(
// // //         filePath: filePath,
// // //         pageSnap: true,
// // //       );

// // //       // Abre la vista de PDF en la aplicación
// // //       // Aquí debes agregar la vista de PDF a tu pantalla.
// // //     } else {
// // //       print('Error al descargar el PDF.');
// // //     }
// // //   } catch (e) {
// // //     print('Error al descargar y abrir el PDF: $e');
// // //   }
// // // }
// // //===============  GALERIA DE FOTOS =========================//
// // Future<void> downloadPDFToAlbum(String url, String filename) async {
// //   try {
// //     final response = await Dio().get(
// //       url,
// //       options: Options(
// //         responseType: ResponseType.bytes,
// //       ),
// //     );

// //     final result = await ImageGallerySaver.saveImage(
// //       response.data,
// //       name: filename,
// //     );

// //     if (result['isSuccess']) {
// //       print('PDF guardado en el álbum de fotos.');
// //     } else {
// //       print('Error al guardar el PDF en el álbum de fotos.');
// //     }
// //   } catch (e) {
// //     print('Error al descargar el PDF: $e');
// //   }
// // }
// // //========================================//


// //   //********************************************************************************************************************//

// // // Future<void> _openFiles() async {
// // //   FilePickerResult? resultFile= await FilePicker.platform.pickFiles();
// // //   if(resultFile!=null){
// // //     PlatformFile file=resultFile.files.first;
// // //     print('file.Name:${file.name}');
// // //     print('file.bytes:${file.bytes}');
// // //     print('file.extension:${file.extension}');
// // //     print('file.path:${file.path}');
// // //   }
// // // }
// // //========================================//

// // // Future<void> _downloadPdf() async {
// // //     final url = "URL_DEL_PDF"; // Reemplaza con la URL de tu PDF
// // //     final response = await http.get(Uri.parse(url));

// // //     if (response.statusCode == 200) {
// // //       final directory = await getApplicationDocumentsDirectory();
// // //       final filePath = "${directory.path}/my_pdf.pdf";
// // //       File pdfFile = File(filePath);

// // //       await pdfFile.writeAsBytes(response.bodyBytes);
// // //       setState(() {
// // //         pdfPath = filePath;
// // //       });
// // //     }
// // //   }

// // //========================================//
// // // Future<void> downloadAndOpenPDFS(String url, String filename) async {
// // //   try {
// // //     final appDocDirectory = await getApplicationDocumentsDirectory();
// // //     final pdfFile = File('${appDocDirectory.path}/$filename');

// // //     final dio = Dio();
// // //     final response = await dio.get(
// // //       url,
// // //       options: Options(responseType: ResponseType.bytes),
// // //     );

// // //     await pdfFile.writeAsBytes(response.data, flush: true);

// // //     if (await pdfFile.exists()) {
// // //       final filePath = pdfFile.path;
// // //       OpenFile.open(filePath);
// // //     } else {
// // //       print('Error al descargar el PDF.');
// // //     }
// // //   } catch (e) {
// // //     print('Error al descargar y abrir el PDF: $e');
// // //   }
// // // }
// // //========================================//

// // }


// // class PdfViewer extends StatelessWidget {
// //   final String pdfPath;

// //   PdfViewer({required this.pdfPath});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Visor de PDF'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: <Widget>[
// //             ElevatedButton(
// //               onPressed: () {
// //                 // Abre el PDF con el visor de PDF predeterminado del dispositivo
// //                 // o puedes utilizar una librería de visor de PDF personalizada.
// //               },
// //               child: Text('Abrir PDF'),
// //             ),
// //             ElevatedButton(
// //   onPressed: () async {
// //     // Obtiene el directorio de descargas del dispositivo
// //     final downloadsDirectory = await getDownloadsDirectory();

// //     if (downloadsDirectory != null) {
// //       // Crea una nueva ruta para el archivo en el directorio de descargas
// //       final fileName = 'my_pdf.pdf';
// //       final filePath = '${downloadsDirectory.path}/$fileName';

// //       try {
// //         // Copia el PDF generado a la ubicación de descargas
// //         File(pdfPath).copySync(filePath);
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(
// //             content: Text('PDF descargado en $filePath'),
// //           ),
// //         );
// //       } catch (e) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(
// //             content: Text('Error al descargar el PDF'),
// //           ),
// //         );
// //       }
// //     } else {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('No se pudo obtener el directorio de descargas'),
// //         ),
// //       );
// //     }
// //   },
// //   child: Text('Descargar PDF'),
// // ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_pdfview/flutter_pdfview.dart';
// // // import 'package:dio/dio.dart';
// // // import 'dart:io';
// // // import 'package:path_provider/path_provider.dart';
// // // import 'package:permission_handler/permission_handler.dart';



// // class PdfViewerScreen extends StatefulWidget {
// //   @override
// //   _PdfViewerScreenState createState() => _PdfViewerScreenState();
// // }

// // class _PdfViewerScreenState extends State<PdfViewerScreen> {
// //   String pdfPath = "";

// //   @override
// //   void initState() {
// //     super.initState();
// //     requestPermissions();
// //   }

// //   Future<void> requestPermissions() async {
// //     var status = await Permission.storage.status;
// //     if (!status.isGranted) {
// //       status = await Permission.storage.request();
// //     }

// //     if (status.isGranted) {
// //       downloadPdf();
// //     } else {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Permisos de almacenamiento denegados")),
// //       );
// //     }
// //   }

// //   Future<void> downloadPdf() async {
// //     final url = "https://conaldi.edu.co/wp_ES/wordpress/matematicas/wp-content/uploads/sites/5/2019/06/Ejercicios-de-factorizacion-en-clase-y-casa.pdf"; // Reemplaza con tu URL
// //     final directory = await getApplicationDocumentsDirectory();
// //     final filePath = "${directory.path}/sample.pdf";

// //     try {
// //       final response = await Dio().download(url, filePath);
// //       if (response.statusCode == 200) {
// //         setState(() {
// //           pdfPath = filePath;
// //         });
// //       } else {
// //         throw Exception("Error al descargar el PDF");
// //       }
// //     } catch (e) {
// //       print("Error al descargar el PDF: $e");
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Error al descargar el PDF: $e")),
// //       );
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("PDF Viewer"),
// //         actions: [
// //           IconButton(
// //             icon: Icon(Icons.download),
// //             onPressed: () async {
// //               final dir = await getApplicationDocumentsDirectory();
// //               final file = File("${dir.path}/sample.pdf");
// //               ScaffoldMessenger.of(context).showSnackBar(
// //                 SnackBar(content: Text("PDF descargado en: ${file.path}")),
// //               );
// //             },
// //           ),
// //         ],
// //       ),
// //       body: pdfPath.isNotEmpty
// //           ? PDFView(
// //               filePath: pdfPath,
// //             )
// //           : Center(child: CircularProgressIndicator()),
// //     );
// //   }
// // }


// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:nseguridad/src/utils/responsive.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// // class ViewsPDFs extends StatelessWidget {
// //   // final String infoPdf;
// //   // final String labelPdf;
// //    ViewsPDFs({Key? key, 
// //   //  required this.infoPdf, 
// //   //  required this.labelPdf
// //    }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     final Responsive size = Responsive.of(context);
// //     return SafeArea(
// //       child: Scaffold(
// //         backgroundColor: const Color(0xFFEEEEEE),
// //         appBar: AppBar(
// //           title:  Text('Vista PDF',style:  Theme.of(context).textTheme.headline2,),
// //           // actions: [
// //           //    IconButton(
// //           //             // splashRadius: 2.0,
// //           //             icon:  Icon(
// //           //                     Icons.download_outlined,
// //           //                     size: size.iScreen(3.5),
// //           //                     color: Colors.white,
// //           //                   ),
// //           //             onPressed: () {
// //           //             //  downloadAndOpenPDF(infoPdf,labelPdf);
// //           //             //  _openFiles();
// //           //             //  downloadAndOpenPDFS(infoPdf,labelPdf);
              

// //           //             }),
// //           // ],
      
// //         ),
// //         body: Container(
// //             width: size.wScreen(100),
// //             height: size.hScreen(100),
// //             padding: EdgeInsets.symmetric(
// //                 horizontal: size.iScreen(1.0), vertical: size.iScreen(1.0)),
// //             color: Colors.grey[300],
// //             child: SfPdfViewer.network('',
// //                 canShowScrollHead: true, canShowScrollStatus: true)),
// //       ),
// //     );
// //   }

// //========================================//

//   // Future openFile({required String url, String? fileName}) async {
//   //   final name = fileName ?? url.split('/').last;
//   //   final file = await pickFile();
//   //   downloadFile(url,name);
//   //   if (file == null) return;

//   //   OpenFile.open(file.path);
//   // }


// // //========================================//
//   // Future<File?> downloadFile(String url, String name) async {
//   //   final appStorage = await getApplicationDocumentsDirectory();
//   //   final file = File('${appStorage.path}/$name');

//   //   print('Phat====>: ${file.path}');

//   //   try {
//   //     final response = await Dio().get(url,
//   //         options: Options(
//   //           responseType: ResponseType.bytes,
//   //           followRedirects: false,
//   //           receiveTimeout: 0,
//   //         ));
//   //     final raf = file.openSync(mode: FileMode.write);
//   //     raf.writeFromSync(response.data);
//   //     await raf.close();
//   //     return file;
//   //   } catch (e) {
//   //     return null;
//   //   }
//   // }
// // Future<void> downloadPDF(String url, String filename) async {
// //   try {
// //     final downloadsDirectory = await getApplicationSupportDirectory();
// //     final file = File('${downloadsDirectory.path}/$filename');

// //     final response = await Dio().get(
// //       url,
// //       options: Options(
// //         responseType: ResponseType.bytes,
// //       ),
// //     );

// //     await file.writeAsBytes(response.data, flush: true);

// //     print('PDF descargado en: ${file.path}');
// //   } catch (e) {
// //     print('Error al descargar el PDF: $e');
// //   }
// // }


// // Future<void> downloadPDFToPictures(String url, String filename) async {
// //   try {
// //     final downloadsDirectory = await getApplicationSupportDirectory();
// //     final downloadsFile = File('${downloadsDirectory.path}/$filename');

// //     final response = await Dio().get(
// //       url,
// //       options: Options(
// //         responseType: ResponseType.bytes,
// //       ),
// //     );

// //     await downloadsFile.writeAsBytes(response.data, flush: true);

// //     final picturesDirectory = await getExternalStorageDirectory();
// //     final picturesFile = File('${picturesDirectory!.path}/$filename');

// //     await downloadsFile.copy(picturesFile.path);

// //     print('PDF descargado en la carpeta de fotos: ${picturesFile.path}');
// //      NotificatiosnService.showSnackBarSuccsses('Descarga realizada correctamente...');
// //   } catch (e) {
// //     print('Error al descargar el PDF: $e');
// //     NotificatiosnService.showSnackBarError('No se pudo realizar la descarga');
// //   }
// // }



// // Future<void> downloadPDFToDownloads(String url, String filename) async {
// //   try {
// //     final downloadsDirectory = await getDownloadsDirectory();
// //     final file = File('${downloadsDirectory!.path}/$filename');

// //     final response = await Dio().get(
// //       url,
// //       options: Options(
// //         responseType: ResponseType.bytes,
// //       ),
// //     );

// //     await file.writeAsBytes(response.data, flush: true);

// //     print('PDF descargado en la carpeta de descargas: ${file.path}');
// //       NotificatiosnService.showSnackBarSuccsses('Descarga realizada correctamente...');
// //   } catch (e) {
// //     print('Error al descargar el PDF: $e');
// //       NotificatiosnService.showSnackBarError('No se pudo realizar la descarga');
// //   }
// // }
// // Future<void> downloadPDFToDownloads(String url, String filename) async {
// //   try {
// //     final directory = Directory('/storage/emulated/0/Download');

// //     if (!(await directory.exists())) {
// //       directory.createSync(recursive: true);
// //     }

// //     final file = File('${directory.path}/$filename');

// //     final response = await Dio().get(
// //       url,
// //       options: Options(
// //         responseType: ResponseType.bytes,
// //       ),
// //     );

// //     await file.writeAsBytes(response.data, flush: true);

// //     print('PDF descargado en la carpeta de descargas: ${file.path}');
// //       NotificatiosnService.showSnackBarSuccsses('Descarga realizada correctamente...');
// //   } catch (e) {
// //     print('Error al descargar el PDF: $e');
// //      NotificatiosnService.showSnackBarError('No se pudo realizar la descarga');
// //   }
// // }

// // Future<void> createAndSavePDF() async {
// //   final pdf = pw.Document();

// //   // Agrega contenido al PDF, por ejemplo:
// //   pdf.addPage(
// //     pw.Page(
// //       build: (pw.Context context) {
// //         return pw.Center(
// //           child: pw.Text('¡Hola, mundo!'),
// //         );
// //       },
// //     ),
// //   );

// //   final appDocDirectory = await getApplicationDocumentsDirectory();
// //   final downloadsDirectory = await getDownloadsDirectory();
// //   final pdfFile = File('${downloadsDirectory.path}/mi_pdf.pdf');

// //   await pdfFile.writeAsBytes(await pdf.save());

// //   print('PDF guardado en la carpeta de descargas: ${pdfFile.path}');
// // }
// // Future<void> downloadAndOpenPDF(String url, String filename) async {
// //   try {
// //     final appDocDirectory = await getApplicationDocumentsDirectory();
// //     final pdfFile = File('${appDocDirectory.path}/$filename');

// //     final dio = Dio();
// //     final response = await dio.get(
// //       url,
// //       options: Options(responseType: ResponseType.bytes),
// //     );

// //     await pdfFile.writeAsBytes(response.data, flush: true);

// //     if (await pdfFile.exists()) {
// //       final filePath = pdfFile.path;
// //       final pdfView = PDFView(
// //         filePath: filePath,
// //         pageSnap: true,
// //       );

// //       // Abre la vista de PDF en la aplicación
// //       // Aquí debes agregar la vista de PDF a tu pantalla.
// //     } else {
// //       print('Error al descargar el PDF.');
// //     }
// //   } catch (e) {
// //     print('Error al descargar y abrir el PDF: $e');
// //   }
// // }
// //===============  GALERIA DE FOTOS =========================//
// // Future<void> downloadPDFToAlbum(String url, String filename) async {
// //   try {
// //     final response = await Dio().get(
// //       url,
// //       options: Options(
// //         responseType: ResponseType.bytes,
// //       ),
// //     );

// //     final result = await ImageGallerySaver.saveImage(
// //       response.data,
// //       name: filename,
// //     );

// //     if (result['isSuccess']) {
// //       print('PDF guardado en el álbum de fotos.');
// //     } else {
// //       print('Error al guardar el PDF en el álbum de fotos.');
// //     }
// //   } catch (e) {
// //     print('Error al descargar el PDF: $e');
// //   }
// // }
// //========================================//


//   //********************************************************************************************************************//

// // Future<void> _openFiles() async {
// //   FilePickerResult? resultFile= await FilePicker.platform.pickFiles();
// //   if(resultFile!=null){
// //     PlatformFile file=resultFile.files.first;
// //     print('file.Name:${file.name}');
// //     print('file.bytes:${file.bytes}');
// //     print('file.extension:${file.extension}');
// //     print('file.path:${file.path}');
// //   }
// // }
// //========================================//

// // Future<void> _downloadPdf() async {
// //     final url = "URL_DEL_PDF"; // Reemplaza con la URL de tu PDF
// //     final response = await http.get(Uri.parse(url));

// //     if (response.statusCode == 200) {
// //       final directory = await getApplicationDocumentsDirectory();
// //       final filePath = "${directory.path}/my_pdf.pdf";
// //       File pdfFile = File(filePath);

// //       await pdfFile.writeAsBytes(response.bodyBytes);
// //       setState(() {
// //         pdfPath = filePath;
// //       });
// //     }
// //   }

// //========================================//
// // Future<void> downloadAndOpenPDFS(String url, String filename) async {
// //   try {
// //     final appDocDirectory = await getApplicationDocumentsDirectory();
// //     final pdfFile = File('${appDocDirectory.path}/$filename');

// //     final dio = Dio();
// //     final response = await dio.get(
// //       url,
// //       options: Options(responseType: ResponseType.bytes),
// //     );

// //     await pdfFile.writeAsBytes(response.data, flush: true);

// //     if (await pdfFile.exists()) {
// //       final filePath = pdfFile.path;
// //       OpenFile.open(filePath);
// //     } else {
// //       print('Error al descargar el PDF.');
// //     }
// //   } catch (e) {
// //     print('Error al descargar y abrir el PDF: $e');
// //   }
// // }
// //========================================//

// // }

// // class SDSDSD extends StatefulWidget {
// //   // final dynamic pedido;
// //    const SDSDSD({Key? key,
// //     // required this.pedido
// //    }) : super(key: key);

// //   @override
// //   State<SDSDSD> createState() => _SDSDSDState();
// // }

// // class _SDSDSDState extends State<SDSDSD> {
  
// //   @override
// //   Widget build(BuildContext context) {
// //         Responsive size = Responsive.of(context);
// //     return Scaffold(
// //        backgroundColor: const Color(0xFFEEEEEE),
       
// //         appBar: AppBar(
// //           // backgroundColor: primaryColor,
// //           title: Text(
// //             'Reporte PDF',
// //             style: GoogleFonts.lexendDeca(
// //                 fontSize: size.iScreen(2.45),
// //                 color: Colors.white,
// //                 fontWeight: FontWeight.normal),
// //           ),
// //            flexibleSpace: Container(
// //               decoration: const BoxDecoration(
// //                 gradient: LinearGradient(
// //                   begin: Alignment.topLeft,
// //                   end: Alignment.bottomCenter,
// //                   colors: <Color>[
// //                     Color(0XFF153E76),
// //                     Color(0XFF0076A7),
                   
                   
                   
// //                     // Color(0XFF005B97),
// //                     // Color(0XFF0075BE),
// //                     // Color(0XFF1E9CD7),
// //                     // Color(0XFF3DA9F4),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //         ),
// //       body:  Container(
// //           width: size.wScreen(100.0),
// //             height: size.hScreen(100),
// //             // color:Colors.red,
// //         child: const 
// //         WebView(
// //         //  initialUrl: "https://backsigeop.neitor.com/api/reportes/pedido?disId=${widget.pedido['disId']}&rucempresa=${widget.pedido['disEmpresa']}",
// //         //  initialUrl: "https://backsigeop.neitor.com/api/reportes/carnet?perId=1042&rucempresa=PAZVISEG",
// //          initialUrl: "https://barajasvictor.wordpress.com/wp-content/uploads/2014/07/ejercicios-de-factorizacic3b3n-a.pdf",
// //     //  javascriptMode:JavascriptMode.unrestricted,
// //      ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';


// import 'package:path_provider/path_provider.dart';
// import 'package:provider/provider.dart';

// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// // import 'package:url_launcher/url_launcher.dart';

// import 'package:path_provider/path_provider.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';






// class ViewsPDFs extends StatelessWidget {
//   // final String infoPdf;
//   // final String labelPdf;
//    ViewsPDFs({Key? key, 
//   //  required this.infoPdf, 
//   //  required this.labelPdf
//    }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final Responsive size = Responsive.of(context);
//     //  final ctrlHome=context.read<HomeController>();
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color(0xFFEEEEEE),
//         appBar: AppBar(
//           title:  Text('Vista PDF',style:  Theme.of(context).textTheme.headline2,),
//         //   // actions: [
//         //   //    IconButton(
//         //   //             // splashRadius: 2.0,
//         //   //             icon:  Icon(
//         //   //                     Icons.download_outlined,
//         //   //                     size: size.iScreen(3.5),
//         //   //                     color: Colors.white,
//         //   //                   ),
//         //   //             onPressed: () {
//         //   //             //  downloadAndOpenPDF(infoPdf,labelPdf);
//         //   //             //  _openFiles();
//         //   //             //  downloadAndOpenPDFS(infoPdf,labelPdf);
              

//         //   //             }),
//         //   // ],
      
//         ),
//         body: Container(
//             width: size.wScreen(100),
//             height: size.hScreen(100),
//             padding: EdgeInsets.symmetric(
//                 horizontal: size.iScreen(1.0), vertical: size.iScreen(1.0)),
//             color: Colors.grey[300],
//             child: Column(
//               children: [
              
            
//                 Expanded(
//                   child: SfPdfViewer.network('https://barajasvictor.wordpress.com/wp-content/uploads/2014/07/ejercicios-de-factorizacic3b3n-a.pdf',
//                       canShowScrollHead: true, canShowScrollStatus: true),
//                 ),
//               ],
//             )),
//       ),
//     );
//   }

// //========================================//

//   // Future openFile({required String url, String? fileName}) async {
//   //   final name = fileName ?? url.split('/').last;
//   //   final file = await pickFile();
//   //   downloadFile(url,name);
//   //   if (file == null) return;

//   //   OpenFile.open(file.path);
//   // }


// // //========================================//
//   // Future<File?> downloadFile(String url, String name) async {
//   //   final appStorage = await getApplicationDocumentsDirectory();
//   //   final file = File('${appStorage.path}/$name');

//   //   print('Phat====>: ${file.path}');

//   //   try {
//   //     final response = await Dio().get(url,
//   //         options: Options(
//   //           responseType: ResponseType.bytes,
//   //           followRedirects: false,
//   //           receiveTimeout: 0,
//   //         ));
//   //     final raf = file.openSync(mode: FileMode.write);
//   //     raf.writeFromSync(response.data);
//   //     await raf.close();
//   //     return file;
//   //   } catch (e) {
//   //     return null;
//   //   }
//   // }
// Future<void> downloadPDF(String url, String filename) async {
//   try {
//     final downloadsDirectory = await getApplicationSupportDirectory();
//     final file = File('${downloadsDirectory.path}/$filename');

//     final response = await Dio().get(
//       url,
//       options: Options(
//         responseType: ResponseType.bytes,
//       ),
//     );

//     await file.writeAsBytes(response.data, flush: true);

//     print('PDF descargado en: ${file.path}');
//   } catch (e) {
//     print('Error al descargar el PDF: $e');
//   }
// }


// // Future<void> downloadPDFToPictures(String url, String filename) async {
// //   try {
// //     final downloadsDirectory = await getApplicationSupportDirectory();
// //     final downloadsFile = File('${downloadsDirectory.path}/$filename');

// //     final response = await Dio().get(
// //       url,
// //       options: Options(
// //         responseType: ResponseType.bytes,
// //       ),
// //     );

// //     await downloadsFile.writeAsBytes(response.data, flush: true);

// //     final picturesDirectory = await getExternalStorageDirectory();
// //     final picturesFile = File('${picturesDirectory!.path}/$filename');

// //     await downloadsFile.copy(picturesFile.path);

// //     print('PDF descargado en la carpeta de fotos: ${picturesFile.path}');
// //      NotificatiosnService.showSnackBarSuccsses('Descarga realizada correctamente...');
// //   } catch (e) {
// //     print('Error al descargar el PDF: $e');
// //     NotificatiosnService.showSnackBarError('No se pudo realizar la descarga');
// //   }
// // }



// // Future<void> downloadPDFToDownloads(String url, String filename) async {
// //   try {
// //     final downloadsDirectory = await getDownloadsDirectory();
// //     final file = File('${downloadsDirectory!.path}/$filename');

// //     final response = await Dio().get(
// //       url,
// //       options: Options(
// //         responseType: ResponseType.bytes,
// //       ),
// //     );

// //     await file.writeAsBytes(response.data, flush: true);

// //     print('PDF descargado en la carpeta de descargas: ${file.path}');
// //       NotificatiosnService.showSnackBarSuccsses('Descarga realizada correctamente...');
// //   } catch (e) {
// //     print('Error al descargar el PDF: $e');
// //       NotificatiosnService.showSnackBarError('No se pudo realizar la descarga');
// //   }
// // }
// // Future<void> downloadPDFToDownloads(String url, String filename) async {
// //   try {
// //     final directory = Directory('/storage/emulated/0/Download');

// //     if (!(await directory.exists())) {
// //       directory.createSync(recursive: true);
// //     }

// //     final file = File('${directory.path}/$filename');

// //     final response = await Dio().get(
// //       url,
// //       options: Options(
// //         responseType: ResponseType.bytes,
// //       ),
// //     );

// //     await file.writeAsBytes(response.data, flush: true);

// //     print('PDF descargado en la carpeta de descargas: ${file.path}');
// //       NotificatiosnService.showSnackBarSuccsses('Descarga realizada correctamente...');
// //   } catch (e) {
// //     print('Error al descargar el PDF: $e');
// //      NotificatiosnService.showSnackBarError('No se pudo realizar la descarga');
// //   }
// // }

// // Future<void> createAndSavePDF() async {
// //   final pdf = pw.Document();

// //   // Agrega contenido al PDF, por ejemplo:
// //   pdf.addPage(
// //     pw.Page(
// //       build: (pw.Context context) {
// //         return pw.Center(
// //           child: pw.Text('¡Hola, mundo!'),
// //         );
// //       },
// //     ),
// //   );

// //   final appDocDirectory = await getApplicationDocumentsDirectory();
// //   final downloadsDirectory = await getDownloadsDirectory();
// //   final pdfFile = File('${downloadsDirectory.path}/mi_pdf.pdf');

// //   await pdfFile.writeAsBytes(await pdf.save());

// //   print('PDF guardado en la carpeta de descargas: ${pdfFile.path}');
// // }
// // Future<void> downloadAndOpenPDF(String url, String filename) async {
// //   try {
// //     final appDocDirectory = await getApplicationDocumentsDirectory();
// //     final pdfFile = File('${appDocDirectory.path}/$filename');

// //     final dio = Dio();
// //     final response = await dio.get(
// //       url,
// //       options: Options(responseType: ResponseType.bytes),
// //     );

// //     await pdfFile.writeAsBytes(response.data, flush: true);

// //     if (await pdfFile.exists()) {
// //       final filePath = pdfFile.path;
// //       final pdfView = PDFView(
// //         filePath: filePath,
// //         pageSnap: true,
// //       );

// //       // Abre la vista de PDF en la aplicación
// //       // Aquí debes agregar la vista de PDF a tu pantalla.
// //     } else {
// //       print('Error al descargar el PDF.');
// //     }
// //   } catch (e) {
// //     print('Error al descargar y abrir el PDF: $e');
// //   }
// // }
// //===============  GALERIA DE FOTOS =========================//
// // Future<void> downloadPDFToAlbum(String url, String filename) async {
// //   try {
// //     final response = await Dio().get(
// //       url,
// //       options: Options(
// //         responseType: ResponseType.bytes,
// //       ),
// //     );

// //     final result = await ImageGallerySaver.saveImage(
// //       response.data,
// //       name: filename,
// //     );

// //     if (result['isSuccess']) {
// //       print('PDF guardado en el álbum de fotos.');
// //     } else {
// //       print('Error al guardar el PDF en el álbum de fotos.');
// //     }
// //   } catch (e) {
// //     print('Error al descargar el PDF: $e');
// //   }
// // }
// //========================================//


//   //********************************************************************************************************************//

// // Future<void> _openFiles() async {
// //   FilePickerResult? resultFile= await FilePicker.platform.pickFiles();
// //   if(resultFile!=null){
// //     PlatformFile file=resultFile.files.first;
// //     print('file.Name:${file.name}');
// //     print('file.bytes:${file.bytes}');
// //     print('file.extension:${file.extension}');
// //     print('file.path:${file.path}');
// //   }
// // }
// //========================================//

// // Future<void> _downloadPdf() async {
// //     final url = "URL_DEL_PDF"; // Reemplaza con la URL de tu PDF
// //     final response = await http.get(Uri.parse(url));

// //     if (response.statusCode == 200) {
// //       final directory = await getApplicationDocumentsDirectory();
// //       final filePath = "${directory.path}/my_pdf.pdf";
// //       File pdfFile = File(filePath);

// //       await pdfFile.writeAsBytes(response.bodyBytes);
// //       setState(() {
// //         pdfPath = filePath;
// //       });
// //     }
// //   }

// //========================================//
// // Future<void> downloadAndOpenPDFS(String url, String filename) async {
// //   try {
// //     final appDocDirectory = await getApplicationDocumentsDirectory();
// //     final pdfFile = File('${appDocDirectory.path}/$filename');

// //     final dio = Dio();
// //     final response = await dio.get(
// //       url,
// //       options: Options(responseType: ResponseType.bytes),
// //     );

// //     await pdfFile.writeAsBytes(response.data, flush: true);

// //     if (await pdfFile.exists()) {
// //       final filePath = pdfFile.path;
// //       OpenFile.open(filePath);
// //     } else {
// //       print('Error al descargar el PDF.');
// //     }
// //   } catch (e) {
// //     print('Error al descargar y abrir el PDF: $e');
// //   }
// // }
// //========================================//

// }


// class PdfViewer extends StatelessWidget {
//   final String pdfPath;

//   PdfViewer({required this.pdfPath});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Visor de PDF'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 // Abre el PDF con el visor de PDF predeterminado del dispositivo
//                 // o puedes utilizar una librería de visor de PDF personalizada.
//               },
//               child: Text('Abrir PDF'),
//             ),
//             ElevatedButton(
//   onPressed: () async {
//     // Obtiene el directorio de descargas del dispositivo
//     final downloadsDirectory = await getDownloadsDirectory();

//     if (downloadsDirectory != null) {
//       // Crea una nueva ruta para el archivo en el directorio de descargas
//       final fileName = 'my_pdf.pdf';
//       final filePath = '${downloadsDirectory.path}/$fileName';

//       try {
//         // Copia el PDF generado a la ubicación de descargas
//         File(pdfPath).copySync(filePath);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('PDF descargado en $filePath'),
//           ),
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error al descargar el PDF'),
//           ),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('No se pudo obtener el directorio de descargas'),
//         ),
//       );
//     }
//   },
//   child: Text('Descargar PDF'),
// ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:nseguridad/src/controllers/bitacora_controller.dart';

// import 'package:nseguridad/src/utils/responsive.dart';

// // import 'package:open_file/open_file.dart';
// import 'package:open_file_safe/open_file_safe.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// class ViewsPDFs extends StatefulWidget {
//   // final String infoPdf;
//   // final String labelPdf;
//   const ViewsPDFs({Key? key, 
//   // required this.infoPdf, required this.labelPdf
//   }) : super(key: key);

//   @override
//   State<ViewsPDFs> createState() => _ViewsPDFsState();
// }

//  Future<void> requestPermission() async {
//     if (await Permission.storage.request().isGranted) {
//       // Permiso concedido, puedes acceder al almacenamiento externo
//     } else {
//       // Permiso denegado, maneja esta situación adecuadamente
//     }
//   }
// class _ViewsPDFsState extends State<ViewsPDFs> {

// @override
//   void initState() {
//   requestPermission();
//     super.initState();
//   }



//   @override
//   Widget build(BuildContext context) {
//     final Responsive size = Responsive.of(context);
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title:  Text('Vista PDF',style:  Theme.of(context).textTheme.headline2,),
//           actions: [
//             IconButton(
//                 onPressed: () {
//                   openFile(url: 'https://barajasvictor.wordpress.com/wp-content/uploads/2014/07/ejercicios-de-factorizacic3b3n-a.pdf', fileName: 'labelPdf');
//                 },
//                 icon: const Icon(Icons.download))
//           ],
//         ),
//         body: Container(
//             width: size.wScreen(100),
//             height: size.hScreen(100),
//             padding: EdgeInsets.symmetric(
//                 horizontal: size.iScreen(1.0), vertical: size.iScreen(1.0)),
//             color: Colors.grey[300],
//             child: SfPdfViewer.network('https://barajasvictor.wordpress.com/wp-content/uploads/2014/07/ejercicios-de-factorizacic3b3n-a.pdf',
//                 canShowScrollHead: true, canShowScrollStatus: true)),
//       ),
//     );
//   }

// //========================================//
//   Future openFile({required String url, String? fileName}) async {
//     final name = fileName ?? url.split('/').last;
//     final file = await pickFile();
//     // downloadFile(url,name);
//     if (file == null) return;

//     print('Phat====>: ${file.path}');
//     OpenFile.open(file.path);
//   }

// //========================================//
//   Future<File?> downloadFile(String url, String name) async {
//     final appStorage = await getApplicationDocumentsDirectory();
//     final file = File('${appStorage.path}/$name');

//     print('Phat====>: ${file.path}');
// //  final nameFile='$file'.split('/').last;
// //  print('nameFile====>: $nameFile');

//     try {
//       final response = await Dio().get(url,
//           options: Options(
//             responseType: ResponseType.bytes,
//             followRedirects: false,
//             receiveTimeout: 0,
//           ));
//       final raf = file.openSync(mode: FileMode.write);
//       raf.writeFromSync(response.data);
//       await raf.close();
//       return file;
//     } catch (e) {
//       return null;
//     }
//   }

//   Future<File?> pickFile() async {
//     final result = await FilePicker.platform.pickFiles();
//     if (result == null) return null;
//     return File(result.files.first.path!);
//   }
// }

//*************************  VISTAS PDF *****************************//
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class ViewsPDFs extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'PDF Viewer',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('PDF Viewer'),
//         ),
//         body: Center(
//           child: ElevatedButton(
//             onPressed: () {
//               _launchPDF('https://barajasvictor.wordpress.com/wp-content/uploads/2014/07/ejercicios-de-factorizacic3b3n-a.pdf');
//             },
//             child: Text('Abrir PDF'),
//           ),
//         ),
//       ),
//     );
//   }

//  // Función para abrir el PDF usando url_launcher
//   _launchPDF(String url) async {
//     Uri uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     } else {
//       throw 'No se pudo abrir el PDF $url';
//     }
//   }
// }

//*************************  VISTAS PDF *****************************//

// class ViewsPDFs extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'PDF Viewer',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('PDF Viewer'),
//         ),
//         body: Center(
//           child: ElevatedButton(
//             onPressed: () {

//                 final _ctrl=context.read<BitacoraController>();
//               //     _ctrl.getALLEstudiantes();
//               // Navigator.of(context).push(
//               //                             MaterialPageRoute(
//               //                                 builder: (context) =>
//               //                                     ListaNotas(
//               //                                        )));
//             },
//             child: Text('VER LISTA'),
//           ),
//         ),
//       ),
//     );
//   }

//  // Función para abrir el PDF usando url_launcher
//   _launchPDF(String url) async {
//     Uri uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     } else {
//       throw 'No se pudo abrir el PDF $url';
//     }
//   }
// }