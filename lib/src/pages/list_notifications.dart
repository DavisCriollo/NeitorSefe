import 'package:flutter/material.dart';
import 'package:nseguridad/src/theme/themes_app.dart';

import 'package:nseguridad/src/utils/responsive.dart';
import 'package:provider/provider.dart';

class ListaNotifications extends StatefulWidget {
  final String? payload;
  const ListaNotifications({Key? key, this.payload}) : super(key: key);

  @override
  State<ListaNotifications> createState() => _ListaNotificationsState();
}

class _ListaNotificationsState extends State<ListaNotifications> {
  @override
  Widget build(BuildContext context) {
// print('++++++++++++ ${widget.payload}  ===========');



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
        title:  Text('LISTA DE NOTIFICATIONS',
      // style:  Theme.of(context).textTheme.headline2,
      )),
      body: Container(
        // color: Colors.red,
        width: size.wScreen(100),
        height: size.hScreen(100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Text('TITLE: '),
           Text('BODY: '),
           Text('${widget.payload}'),
          ],
        ),
      ),
    );
  }
}