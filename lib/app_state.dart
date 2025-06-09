import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _estado = prefs.getString('ff_estado') ?? _estado;
    });
    _safeInit(() {
      _nohacenada = prefs.getBool('ff_nohacenada') ?? _nohacenada;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _estado = '';
  String get estado => _estado;
  set estado(String value) {
    _estado = value;
    prefs.setString('ff_estado', value);
  }

  bool _nohacenada = false;
  bool get nohacenada => _nohacenada;
  set nohacenada(bool value) {
    _nohacenada = value;
    prefs.setBool('ff_nohacenada', value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
