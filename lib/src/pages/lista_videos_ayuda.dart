import 'package:flutter/material.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String videoId;

  VideoPlayerScreen({required this.videoId});

  @override
  Widget build(BuildContext context) {
    final ctrlTheme = context.read<ThemeApp>();
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
      ),
      body: Column(
        children: [
          Expanded(
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: videoId,
                flags: const YoutubePlayerFlags(
                  autoPlay: true,
                  mute: false,
                ),
              ),
              showVideoProgressIndicator: true,
            ),
          ),
        ],
      ),
    );
  }
}
