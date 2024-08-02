import 'package:flutter/material.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';

class ListaComunicadosPush extends StatefulWidget {
  final informacion;
  const ListaComunicadosPush({Key? key, this.informacion}) : super(key: key);

  @override
  State<ListaComunicadosPush> createState() => _ListaComunicadosPushState();
}

class _ListaComunicadosPushState extends State<ListaComunicadosPush> {
  @override
  Widget build(BuildContext context) {
      final ctrlTheme = context.read<ThemeApp>();
         
    return Scaffold(
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
        title: Text(
          'Mis Consignas',
          // style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: Center(child: Text('${widget.informacion}')),
    );
  }
}
