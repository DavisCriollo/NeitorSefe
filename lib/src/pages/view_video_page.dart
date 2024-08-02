import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:nseguridad/src/utils/theme.dart';
import 'package:provider/provider.dart';

class VideoScreenPage extends StatefulWidget {
  const VideoScreenPage({Key? key}) : super(key: key);

  @override
  State<VideoScreenPage> createState() => _VideoScreenPageState();
}

class _VideoScreenPageState extends State<VideoScreenPage> {
  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive.of(context);
    final url = ModalRoute.of(context)!.settings.arguments;
      final ctrlTheme = context.read<ThemeApp>();
       
    url as String;

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
        elevation: 0,
        title: Text(
          'Video',
          // style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: Container(
        color: primaryColor,
        width: size.wScreen(100),
        height: size.hScreen(100),
        child: BetterPlayer.network(
          url,
          betterPlayerConfiguration: const BetterPlayerConfiguration(
            aspectRatio: 16 / 16,
          ),
        ),
      ),
    );
  }
}
