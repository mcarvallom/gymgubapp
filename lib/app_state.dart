import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'package:synchronized/synchronized.dart';
class GHAppState extends ChangeNotifier {
  static GHAppState _instance = GHAppState._internal();

  factory GHAppState() {
    return _instance;
  }

  GHAppState._internal();

  static void reset() {
    _instance = GHAppState._internal();
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
  late FlutterSecureStorage secureStorage;

  String _estado = '';
  String get estado => _estado;
  set estado(String value) {
    _estado = value;
    prefs.setString('ff_estado', value);
  }
  

String _idUsuario = '';
  String get idUsuario => _idUsuario;
  set idUsuario(String value) {
    _idUsuario = value;
    secureStorage.setString('ff_idUsuario', value);
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


extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  static final _lock = Lock();

  Future<void> writeSync({required String key, String? value}) async =>
      await _lock.synchronized(() async {
        await write(key: key, value: value);
      });

  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await writeSync(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await writeSync(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await writeSync(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await writeSync(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await writeSync(key: key, value: ListToCsvConverter().convert([value]));
}