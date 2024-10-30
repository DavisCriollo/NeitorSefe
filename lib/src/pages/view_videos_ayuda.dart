import 'package:flutter/material.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class VideoPlayerScreen extends StatelessWidget {
  final Map<String, dynamic> infoVideo;

  const VideoPlayerScreen({Key? key, required this.infoVideo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     Responsive size = Responsive.of(context);
    final ctrlTheme = context.read<ThemeApp>();
    String videoUrl = infoVideo['urlVideo'];
    String? videoId = extractVideoId(videoUrl);

    return Scaffold(
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
        title: Text(infoVideo['nombreVideo'] ?? 'Video'),
      ),
      body: Column(
        children: [
          Expanded(
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: videoId!,
                flags: const YoutubePlayerFlags(
                  autoPlay: true,
                  mute: false,
                ),
              ),
              showVideoProgressIndicator: true,
            ),
          ),
         Padding(
  padding: EdgeInsets.all(size.iScreen(1.0)),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda
    children: [
      // Título del video
      Container(
        width: size.wScreen(100.0),
        child: Row(
          children: [
            Text(
              'Título: ',
              style: TextStyle(
                fontSize: size.iScreen(2.0),
                color: Colors.grey,
                fontWeight: FontWeight.normal,
              ),
            ),
            Expanded(
              child: Text(
                 infoVideo['nombreVideo']  ?? 'Sin título ',
                style: TextStyle(
                  fontSize: size.iScreen(2.0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: size.iScreen(0.5)), // Espaciado entre el título y la descripción
      // Descripción del video
      Container(
        width: size.wScreen(100.0),
        child: Row(
          children: [
            Text(
              'Descripción : ',
              style: TextStyle(
                fontSize: size.iScreen(1.8),
                color: Colors.grey,
                fontWeight: FontWeight.normal,
              ),
            ),
            Expanded(
              child: Text(
                infoVideo['descVideo'] ?? 'Sin descripción',
                style: TextStyle(
                  fontSize: size.iScreen(1.8),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: size.iScreen(0.5)), // Espaciado adicional si es necesario
      // Aquí puedes agregar otros detalles que quieras mostrar
    ],
  ),
),

        ],
      ),
    );
  }
}

String? extractVideoId(String url) {
  Uri uri = Uri.parse(url);
  
  // Si la URL es de tipo youtu.be
  if (uri.host == 'youtu.be') {
    return uri.pathSegments.first; // Regresa el ID del video
  }
  
  // Si la URL es de tipo youtube.com
  if (uri.host.contains('youtube.com') && uri.queryParameters.containsKey('v')) {
    return uri.queryParameters['v']; // Regresa el ID del video
  }

  return null; // Regresa null si no se encuentra el ID
}
