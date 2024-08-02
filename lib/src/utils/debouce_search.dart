import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final Duration duration;
  Timer _timer;
  Debouncer(this._timer, {this.duration = const Duration(milliseconds: 500)});

  create(VoidCallback callback) {
    cancel();
    _timer = Timer(duration, callback);
  }

  cancel() {
    _timer.cancel();
  }
}
