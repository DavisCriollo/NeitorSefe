import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nseguridad/src/models/crea_foto_multas.dart';
import 'package:nseguridad/src/models/crea_fotos_detalle_novedad.dart';
import 'package:nseguridad/src/models/crear_foto_comunicado_guardia.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:provider/provider.dart';

class PreviewScreenMultas extends StatelessWidget {
  final CreaNuevaFotoMultas? image;

  const PreviewScreenMultas({
    Key? key,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
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
        title: Text(
          'Photo',
          // style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: InteractiveViewer(
        child: Hero(
          tag: image!.id,
          child: SizedBox(
            width: size.wScreen(100.0),
            height: size.hScreen(100.0),
            child: Image.file(
              File(image!.path),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
