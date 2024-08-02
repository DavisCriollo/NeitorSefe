
import 'package:flutter/material.dart';

import 'package:nseguridad/src/utils/responsive.dart';

class InputTimePiker extends StatefulWidget {
  final String? label, hintsText;
  final IconData? suffix;
  final TextInputType? keyboardType;
  InputTimePiker({
    required this.size,
    required this.label,
    this.hintsText,
    this.suffix,
    this.keyboardType,
  });

  final Responsive size;

  @override
  _InputTimePikerState createState() => _InputTimePikerState();
}

class _InputTimePikerState extends State<InputTimePiker> {
  TextEditingController timeController = new TextEditingController();
  late TimeOfDay time;

  @override
  void initState() {
    time = TimeOfDay.now();
    super.initState();
  }

  @override
  void dispose() {
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: widget.size.iScreen(0.0)),
      width: widget.size.wScreen(30.0),
      child: TextField(
        controller: timeController,
        enableInteractiveSelection: true,
        keyboardType: widget.keyboardType,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: widget.hintsText,
          suffixIcon: Icon(widget.suffix),
          labelText: widget.label,
          labelStyle: TextStyle(fontSize: widget.size.iScreen(1.7)),
          
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectTime(context);
        },
      ),
    );
  }

  void _selectTime(context) async {
    TimeOfDay? _hora = await showTimePicker(context: context, initialTime: time);

    if (_hora != null) {
      setState(() {
        time = _hora;
        timeController.text = time.format(context);
        print(time.format(context));
        
      });
    }
  }
}
