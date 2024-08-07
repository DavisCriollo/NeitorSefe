import 'dart:io';

import 'package:dio/dio.dart';
// import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/theme/themes_app.dart';

import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;



// Future<void> requestPermissions() async {
//   await Permission.storage.request();
// }

// Future<String> downloadPDFToExternalStorage(String url, String fileName) async {
//   try {
//     // Solicita permisos
//     await requestPermissions();
    
//     // Obtiene el directorio de almacenamiento externo
//     Directory? externalDir = await getExternalStorageDirectory();
//     String downloadsPath = "${externalDir!.path}/Download";
    
//     // Crea la carpeta de descargas si no existe
//     Directory downloadsDir = Directory(downloadsPath);
//     if (!downloadsDir.existsSync()) {
//       downloadsDir.createSync(recursive: true);
//     }
    
//     // Define la ruta completa para el archivo PDF
//     String fullPath = "$downloadsPath/$fileName.pdf";
    
//     // Usa Dio para descargar el archivo PDF
//     Dio dio = Dio();
//     await dio.download(url, fullPath);
    
//     return fullPath;
//   } catch (e) {
//     print("Error descargando el archivo: $e");
//     return '';
//   }
// }
// Future<String> downloadPDFToPicturesDirectory(String url, String fileName) async {
//   try {
//     // Solicita permisos
//     await requestPermissions();

//     // Obtiene el directorio de almacenamiento externo para imágenes
//     Directory? externalDir = await getExternalStorageDirectory();
//     String picturesPath = "${externalDir!.path}/Pictures";

//     // Crea la carpeta de imágenes si no existe
//     Directory picturesDir = Directory(picturesPath);
//     if (!picturesDir.existsSync()) {
//       picturesDir.createSync(recursive: true);
//     }

//     // Define la ruta completa para el archivo PDF
//     String fullPath = "$picturesPath/$fileName.pdf";

//     // Usa Dio para descargar el archivo PDF
//     Dio dio = Dio();
//     await dio.download(url, fullPath);

//     return fullPath;
//   } catch (e) {
//     print("Error descargando el archivo: $e");
//     return '';
//   }
// }
// Future<String> downloadPDFToGallery(String url, String fileName) async {
//   try {
//     // Solicita permisos
//     await requestPermissions();

//     // Obtiene el directorio de almacenamiento externo público para imágenes
//     Directory? picturesDir = await getExternalStorageDirectory();
//     String galleryPath = "${picturesDir!.path}/Download";

//     // Crea la carpeta de imágenes si no existe
//     Directory galleryDir = Directory(galleryPath);
//     if (!galleryDir.existsSync()) {
//       galleryDir.createSync(recursive: true);
//     }

//     // Define la ruta completa para el archivo PDF
//     String fullPath = "$galleryPath/$fileName.pdf";

//     // Usa Dio para descargar el archivo PDF
//     Dio dio = Dio();
//     await dio.download(url, fullPath);

//     return fullPath;
//   } catch (e) {
//     print("Error descargando el archivo: $e");
//     return '';
//   }
// }
// Future<String> downloadPDFToGallery(String url, String fileName) async {
//   try {
//     // Solicita permisos
//     await requestPermissions();

//     // Ruta común de la carpeta DCIM en muchos dispositivos Android
//     String galleryPath = "/storage/emulated/0/DCIM";

//     // Define la ruta completa para el archivo PDF
//     String fullPath = "$galleryPath/$fileName.pdf";

//     // Usa Dio para descargar el archivo PDF
//     Dio dio = Dio();
//     await dio.download(url, fullPath);

//     return fullPath;
//   } catch (e) {
//     print("Error descargando el archivo: $e");
//     return '';
//   }
// }


// class ViewsPDFs extends StatelessWidget {
//   final String infoPdf;
//   final String labelPdf;
//    ViewsPDFs({Key? key, required this.infoPdf, required this.labelPdf}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final Responsive size = Responsive.of(context);
//       final ctrlTheme = context.read<ThemeApp>();
       
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color(0xFFEEEEEE),
//         appBar: AppBar(
           
//          flexibleSpace: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: <Color>[
//                   ctrlTheme.primaryColor,
//                   ctrlTheme.secondaryColor,
//                 ],
//               ),
//             ),
//           ),
//           title:  Text('Vista PDF',
//           // style:  Theme.of(context).textTheme.headline2,
//           ),
//           // actions: [
//           //    IconButton(
//           //             // splashRadius: 2.0,
//           //             icon:  Icon(
//           //                     Icons.download_outlined,
//           //                     size: size.iScreen(3.5),
//           //                     color: Colors.white,
//           //                   ),
//           //             onPressed: () {
//           //             //  downloadAndOpenPDF(infoPdf,labelPdf);
//           //             //  _openFiles();
//           //             //  downloadAndOpenPDFS(infoPdf,labelPdf);
              

//           //             }),
//           // ],
      
//         ),
//         body: Container(
//             width: size.wScreen(100),
//             height: size.hScreen(100),
//             padding: EdgeInsets.symmetric(
//                 horizontal: size.iScreen(1.0), vertical: size.iScreen(1.0)),
//             color: Colors.grey[300],
//             child: SfPdfViewer.network(infoPdf,
//                 canShowScrollHead: true, canShowScrollStatus: true)),
//       ),
//     );
//   }

// class ViewsPDFs extends StatelessWidget {
//   final String infoPdf;
//   final String labelPdf;

//   ViewsPDFs({Key? key, required this.infoPdf, required this.labelPdf}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final Responsive size = Responsive.of(context);
//     final ctrlTheme = context.read<ThemeApp>();
    
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color(0xFFEEEEEE),
//         appBar: AppBar(
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: <Color>[
//                   ctrlTheme.primaryColor,
//                   ctrlTheme.secondaryColor,
//                 ],
//               ),
//             ),
//           ),
//           title: Text('Vista PDF',
//             // style: Theme.of(context).textTheme.headline2,
//           ),
//           actions: [
//             IconButton(
//               icon: Icon(
//                 Icons.download_outlined,
//                 size: size.iScreen(3.5),
//                 color: Colors.white,
//               ),
//               onPressed: () async {
//                 String downloadPath = await downloadPDFToExternalStorage(infoPdf, labelPdf);
                
//                 if (downloadPath != null) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text("PDF descargado en $downloadPath"))
//                   );
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text("Error al descargar el PDF"))
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//         body: Container(
//           width: size.wScreen(100),
//           height: size.hScreen(100),
//           padding: EdgeInsets.symmetric(
//             horizontal: size.iScreen(1.0), 
//             vertical: size.iScreen(1.0)
//           ),
//           color: Colors.grey[300],
//           child: SfPdfViewer.network(
//             infoPdf,
//             canShowScrollHead: true, 
//             canShowScrollStatus: true
//           ),
//         ),
//       ),
//     );
//   }
// }
// class ViewsPDFs extends StatelessWidget {
//   final String infoPdf;
//   final String labelPdf;

//   ViewsPDFs({Key? key, required this.infoPdf, required this.labelPdf}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final Responsive size = Responsive.of(context);
//     final ctrlTheme = context.read<ThemeApp>();
    
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color(0xFFEEEEEE),
//         appBar: AppBar(
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: <Color>[
//                   ctrlTheme.primaryColor,
//                   ctrlTheme.secondaryColor,
//                 ],
//               ),
//             ),
//           ),
//           title: Text('Vista PDF',
//             // style: Theme.of(context).textTheme.headline2,
//           ),
//           actions: [
//             IconButton(
//               icon: Icon(
//                 Icons.download_outlined,
//                 size: size.iScreen(3.5),
//                 color: Colors.white,
//               ),
//               onPressed: () async {
//                 String downloadPath = await downloadPDFToPicturesDirectory(infoPdf, labelPdf);
                
//                 if (downloadPath != null) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text("PDF descargado en $downloadPath"))
//                   );
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text("Error al descargar el PDF"))
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//         body: Container(
//           width: size.wScreen(100),
//           height: size.hScreen(100),
//           padding: EdgeInsets.symmetric(
//             horizontal: size.iScreen(1.0), 
//             vertical: size.iScreen(1.0)
//           ),
//           color: Colors.grey[300],
//           child: SfPdfViewer.network(
//             infoPdf,
//             canShowScrollHead: true, 
//             canShowScrollStatus: true
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ViewsPDFs extends StatelessWidget {
//   final String infoPdf;
//   final String labelPdf;

//   ViewsPDFs({Key? key, required this.infoPdf, required this.labelPdf}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final Responsive size = Responsive.of(context);
//     final ctrlTheme = context.read<ThemeApp>();
    
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color(0xFFEEEEEE),
//         appBar: AppBar(
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: <Color>[
//                   ctrlTheme.primaryColor,
//                   ctrlTheme.secondaryColor,
//                 ],
//               ),
//             ),
//           ),
//           title: Text('Vista PDF',
//             // style: Theme.of(context).textTheme.headline2,
//           ),
//           actions: [
//             IconButton(
//               icon: Icon(
//                 Icons.download_outlined,
//                 size: size.iScreen(3.5),
//                 color: Colors.white,
//               ),
//               onPressed: () async {
//                 String downloadPath = await downloadPDFToGallery(infoPdf, labelPdf);
                
//                 if (downloadPath != null) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text("PDF descargado en $downloadPath"))
//                   );
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text("Error al descargar el PDF"))
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//         body: Container(
//           width: size.wScreen(100),
//           height: size.hScreen(100),
//           padding: EdgeInsets.symmetric(
//             horizontal: size.iScreen(1.0), 
//             vertical: size.iScreen(1.0)
//           ),
//           color: Colors.grey[300],
//           child: SfPdfViewer.network(
//             infoPdf,
//             canShowScrollHead: true, 
//             canShowScrollStatus: true
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ViewsPDFs extends StatelessWidget {
//   final String infoPdf;
//   final String labelPdf;

//   ViewsPDFs({Key? key, required this.infoPdf, required this.labelPdf}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final Responsive size = Responsive.of(context);
//     final ctrlTheme = context.read<ThemeApp>();
    
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color(0xFFEEEEEE),
//         appBar: AppBar(
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: <Color>[
//                   ctrlTheme.primaryColor,
//                   ctrlTheme.secondaryColor,
//                 ],
//               ),
//             ),
//           ),
//           title: Text('Vista PDF',
//             // style: Theme.of(context).textTheme.headline2,
//           ),
//           actions: [
//             IconButton(
//               icon: Icon(
//                 Icons.download_outlined,
//                 size: size.iScreen(3.5),
//                 color: Colors.white,
//               ),
//               onPressed: () async {
//                 String downloadPath = await downloadPDFToGallery(infoPdf, labelPdf);
                
//                 if (downloadPath != null) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text("PDF descargado en $downloadPath"))
//                   );
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text("Error al descargar el PDF"))
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//         body: Container(
//           width: size.wScreen(100),
//           height: size.hScreen(100),
//           padding: EdgeInsets.symmetric(
//             horizontal: size.iScreen(1.0), 
//             vertical: size.iScreen(1.0)
//           ),
//           color: Colors.grey[300],
//           child: SfPdfViewer.network(
//             infoPdf,
//             canShowScrollHead: true, 
//             canShowScrollStatus: true
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ViewsPDFs extends StatelessWidget {
//   final String infoPdf;
//   final String labelPdf;

//   ViewsPDFs({Key? key, required this.infoPdf, required this.labelPdf}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final Responsive size = Responsive.of(context);
//     final ctrlTheme = context.read<ThemeApp>();
    
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color(0xFFEEEEEE),
//         appBar: AppBar(
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: <Color>[
//                   ctrlTheme.primaryColor,
//                   ctrlTheme.secondaryColor,
//                 ],
//               ),
//             ),
//           ),
//           title: Text('Vista PDF',
//             // style: Theme.of(context).textTheme.headline2,
//           ),
//           actions: [
//             IconButton(
//               icon: Icon(
//                 Icons.download_outlined,
//                 size: size.iScreen(3.5),
//                 color: Colors.white,
//               ),
//               onPressed: () async {
//                 String downloadPath = await downloadPDFToGallery(infoPdf, labelPdf);
                
//                 if (downloadPath != null) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text("PDF descargado en $downloadPath"))
//                   );
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text("Error al descargar el PDF"))
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//         body: Container(
//           width: size.wScreen(100),
//           height: size.hScreen(100),
//           padding: EdgeInsets.symmetric(
//             horizontal: size.iScreen(1.0), 
//             vertical: size.iScreen(1.0)
//           ),
//           color: Colors.grey[300],
//           child: SfPdfViewer.network(
//             infoPdf,
//             canShowScrollHead: true, 
//             canShowScrollStatus: true
//           ),
//         ),
//       ),
//     );
//   }
// }

//========================================//

  // Future openFile({required String url, String? fileName}) async {
  //   final name = fileName ?? url.split('/').last;
  //   final file = await pickFile();
  //   downloadFile(url,name);
  //   if (file == null) return;

  //   OpenFile.open(file.path);
  // }


// //========================================//
  // Future<File?> downloadFile(String url, String name) async {
  //   final appStorage = await getApplicationDocumentsDirectory();
  //   final file = File('${appStorage.path}/$name');

  //   print('Phat====>: ${file.path}');

  //   try {
  //     final response = await Dio().get(url,
  //         options: Options(
  //           responseType: ResponseType.bytes,
  //           followRedirects: false,
  //           receiveTimeout: 0,
  //         ));
  //     final raf = file.openSync(mode: FileMode.write);
  //     raf.writeFromSync(response.data);
  //     await raf.close();
  //     return file;
  //   } catch (e) {
  //     return null;
  //   }
  // }
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


// Future<void> downloadPDFToPictures(String url, String filename) async {
//   try {
//     final downloadsDirectory = await getApplicationSupportDirectory();
//     final downloadsFile = File('${downloadsDirectory.path}/$filename');

//     final response = await Dio().get(
//       url,
//       options: Options(
//         responseType: ResponseType.bytes,
//       ),
//     );

//     await downloadsFile.writeAsBytes(response.data, flush: true);

//     final picturesDirectory = await getExternalStorageDirectory();
//     final picturesFile = File('${picturesDirectory!.path}/$filename');

//     await downloadsFile.copy(picturesFile.path);

//     print('PDF descargado en la carpeta de fotos: ${picturesFile.path}');
//      NotificatiosnService.showSnackBarSuccsses('Descarga realizada correctamente...');
//   } catch (e) {
//     print('Error al descargar el PDF: $e');
//     NotificatiosnService.showSnackBarError('No se pudo realizar la descarga');
//   }
// }



// Future<void> downloadPDFToDownloads(String url, String filename) async {
//   try {
//     final downloadsDirectory = await getDownloadsDirectory();
//     final file = File('${downloadsDirectory!.path}/$filename');

//     final response = await Dio().get(
//       url,
//       options: Options(
//         responseType: ResponseType.bytes,
//       ),
//     );

//     await file.writeAsBytes(response.data, flush: true);

//     print('PDF descargado en la carpeta de descargas: ${file.path}');
//       NotificatiosnService.showSnackBarSuccsses('Descarga realizada correctamente...');
//   } catch (e) {
//     print('Error al descargar el PDF: $e');
//       NotificatiosnService.showSnackBarError('No se pudo realizar la descarga');
//   }
// }
// Future<void> downloadPDFToDownloads(String url, String filename) async {
//   try {
//     final directory = Directory('/storage/emulated/0/Download');

//     if (!(await directory.exists())) {
//       directory.createSync(recursive: true);
//     }

//     final file = File('${directory.path}/$filename');

//     final response = await Dio().get(
//       url,
//       options: Options(
//         responseType: ResponseType.bytes,
//       ),
//     );

//     await file.writeAsBytes(response.data, flush: true);

//     print('PDF descargado en la carpeta de descargas: ${file.path}');
//       NotificatiosnService.showSnackBarSuccsses('Descarga realizada correctamente...');
//   } catch (e) {
//     print('Error al descargar el PDF: $e');
//      NotificatiosnService.showSnackBarError('No se pudo realizar la descarga');
//   }
// }

// Future<void> createAndSavePDF() async {
//   final pdf = pw.Document();

//   // Agrega contenido al PDF, por ejemplo:
//   pdf.addPage(
//     pw.Page(
//       build: (pw.Context context) {
//         return pw.Center(
//           child: pw.Text('¡Hola, mundo!'),
//         );
//       },
//     ),
//   );

//   final appDocDirectory = await getApplicationDocumentsDirectory();
//   final downloadsDirectory = await getDownloadsDirectory();
//   final pdfFile = File('${downloadsDirectory.path}/mi_pdf.pdf');

//   await pdfFile.writeAsBytes(await pdf.save());

//   print('PDF guardado en la carpeta de descargas: ${pdfFile.path}');
// }
// Future<void> downloadAndOpenPDF(String url, String filename) async {
//   try {
//     final appDocDirectory = await getApplicationDocumentsDirectory();
//     final pdfFile = File('${appDocDirectory.path}/$filename');

//     final dio = Dio();
//     final response = await dio.get(
//       url,
//       options: Options(responseType: ResponseType.bytes),
//     );

//     await pdfFile.writeAsBytes(response.data, flush: true);

//     if (await pdfFile.exists()) {
//       final filePath = pdfFile.path;
//       final pdfView = PDFView(
//         filePath: filePath,
//         pageSnap: true,
//       );

//       // Abre la vista de PDF en la aplicación
//       // Aquí debes agregar la vista de PDF a tu pantalla.
//     } else {
//       print('Error al descargar el PDF.');
//     }
//   } catch (e) {
//     print('Error al descargar y abrir el PDF: $e');
//   }
// }
//===============  GALERIA DE FOTOS =========================//
// Future<void> downloadPDFToAlbum(String url, String filename) async {
//   try {
//     final response = await Dio().get(
//       url,
//       options: Options(
//         responseType: ResponseType.bytes,
//       ),
//     );

//     final result = await ImageGallerySaver.saveImage(
//       response.data,
//       name: filename,
//     );

//     if (result['isSuccess']) {
//       print('PDF guardado en el álbum de fotos.');
//     } else {
//       print('Error al guardar el PDF en el álbum de fotos.');
//     }
//   } catch (e) {
//     print('Error al descargar el PDF: $e');
//   }
// }
//========================================//


  //********************************************************************************************************************//

// Future<void> _openFiles() async {
//   FilePickerResult? resultFile= await FilePicker.platform.pickFiles();
//   if(resultFile!=null){
//     PlatformFile file=resultFile.files.first;
//     print('file.Name:${file.name}');
//     print('file.bytes:${file.bytes}');
//     print('file.extension:${file.extension}');
//     print('file.path:${file.path}');
//   }
// }
//========================================//

// Future<void> _downloadPdf() async {
//     final url = "URL_DEL_PDF"; // Reemplaza con la URL de tu PDF
//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       final directory = await getApplicationDocumentsDirectory();
//       final filePath = "${directory.path}/my_pdf.pdf";
//       File pdfFile = File(filePath);

//       await pdfFile.writeAsBytes(response.bodyBytes);
//       setState(() {
//         pdfPath = filePath;
//       });
//     }
//   }

//========================================//
// Future<void> downloadAndOpenPDFS(String url, String filename) async {
//   try {
//     final appDocDirectory = await getApplicationDocumentsDirectory();
//     final pdfFile = File('${appDocDirectory.path}/$filename');

//     final dio = Dio();
//     final response = await dio.get(
//       url,
//       options: Options(responseType: ResponseType.bytes),
//     );

//     await pdfFile.writeAsBytes(response.data, flush: true);

//     if (await pdfFile.exists()) {
//       final filePath = pdfFile.path;
//       OpenFile.open(filePath);
//     } else {
//       print('Error al descargar el PDF.');
//     }
//   } catch (e) {
//     print('Error al descargar y abrir el PDF: $e');
//   }
// }
//========================================//

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


import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Future<void> requestPermissions() async {
//   await Permission.storage.request();
// }

// Future<String> getPicturesDirectoryPath() async {
//   List<Directory>? externalDirs = await getExternalStorageDirectories();
//   String picturesPath = externalDirs![0].path + "/Pictures";
//   return picturesPath;
// }

// Future<String> downloadPDFToGallery(String url, String fileName) async {
//   try {
//     // Solicita permisos
//     await requestPermissions();

//     // Obtiene la ruta de la carpeta de imágenes
//     String picturesPath = await getPicturesDirectoryPath();

//     // Define la ruta completa para el archivo PDF
//     String fullPath = "$picturesPath/$fileName.pdf";

//     // Usa Dio para descargar el archivo PDF
//     Dio dio = Dio();
//     await dio.download(url, fullPath);

//     return fullPath;
//   } catch (e) {
//     print("Error descargando el archivo: $e");
//     return '';
//   }
// }

class ViewsPDFs extends StatelessWidget {
  final String infoPdf;
  final String labelPdf;

  ViewsPDFs({Key? key, required this.infoPdf, required this.labelPdf}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final ctrlTheme = context.read<ThemeApp>();
     final ctrlHome = context.read<HomeController>();
    
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEEEEEE),
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  ctrlTheme.primaryColor,
                  ctrlTheme.secondaryColor,
                ],
              ),
            ),
          ),
          title: Text('Vista PDF',
            // style: Theme.of(context).textTheme.headline2,
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.download_outlined,
                size: size.iScreen(3.5),
                color: Colors.white,
              ),
              onPressed: () async {
                // String downloadPath = await downloadPDFToGallery(infoPdf, labelPdf);
                
                // if (downloadPath != null) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(content: Text("PDF descargado en $downloadPath"))
                //   );
                // } else {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(content: Text("Error al descargar el PDF"))
                //   );
                // }
                //  _launchPDF(infoPdf);
                // savePDFToDownloads(infoPdf,'Horario');
                //  ctrlHome.downloadPDF(infoPdf,'Horario');
                 downloadAndOpenPDF(infoPdf);
                 
              },
            ),
          ],
        ),
        body: Container(
          width: size.wScreen(100),
          height: size.hScreen(100),
          padding: EdgeInsets.symmetric(
            horizontal: size.iScreen(1.0), 
            vertical: size.iScreen(1.0)
          ),
          color: Colors.grey[300],
          child: 
          // SfPdfViewer.network(
          //   infoPdf,
          //   canShowScrollHead: true, 
          //   canShowScrollStatus: true
          // ),
         SfPdfViewer.network(
              infoPdf ,
              canShowScrollHead: true,
              canShowScrollStatus: true,
            )
          
    
          
        ),
      ),
    );
  }

Future<void> downloadAndOpenPDF(String pdfUrl) async {
  // Obtiene el directorio temporal del dispositivo
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;

  // Verifica si se puede escribir en el directorio temporal
  bool canWrite = await Directory(tempPath).exists();
  if (!canWrite) {
    print('No se puede escribir en el directorio temporal.');
    return;
  }

  // Descarga el PDF
  String pdfFileName = pdfUrl.split('/').last;
  String pdfPath = '$tempPath/$pdfFileName';
  Dio dio = Dio();
  try {
    await dio.download(pdfUrl, pdfPath);
  } catch (e) {
    print('Error al descargar PDF: $e');
    return;
  }

  // Abre el PDF descargado
  try {
    await OpenFile.open(pdfPath);
  } catch (e) {
    print('Error al abrir PDF: $e');
  }
}

}


