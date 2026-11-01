import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pengaturan extends ChangeNotifier {
  static const int targetDefault = 20000;
  static const String _kunciTarget = 'target_tabungan';
  static const String _kunciModeGelap = 'mode_gelap';
  static const String _kunciWarna = 'warna_tema';

  static const String urlApiDefault = 'http://10.0.2.2:8000';
  static const String _kunciUrlApi = 'url_api';

  int _targetTabungan = targetDefault;
  bool _modeGelap = false;
  int _warnaTema = Colors.teal.value;
  String _urlApi = urlApiDefault;

  int get targetTabungan => _targetTabungan;
  bool get modeGelap => _modeGelap;
  Color get warnaTema => Color(_warnaTema);
  String get urlApi => _urlApi;

  Future<void> muat() async {
    final prefs = await SharedPreferences.getInstance();

    _targetTabungan = prefs.getInt(_kunciTarget) ?? targetDefault;
    _modeGelap = prefs.getBool(_kunciModeGelap) ?? false;
    _warnaTema = prefs.getInt(_kunciWarna) ?? Colors.teal.value;
    _urlApi = prefs.getString(_kunciUrlApi) ?? urlApiDefault;

    notifyListeners();
  }

  Future<void> ubahTarget(int nilai) async {
    if (nilai <= 0) {
      throw ArgumentError('Target tabungan harus lebih dari nol.');
    }

    _targetTabungan = nilai;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kunciTarget, nilai);

    notifyListeners();
  }

  Future<void> ubahModeGelap(bool aktif) async {
    _modeGelap = aktif;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kunciModeGelap, aktif);

    notifyListeners();
  }

  Future<void> ubahWarnaTema(Color warna) async {
    _warnaTema = warna.value;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kunciWarna, _warnaTema);

    notifyListeners();
  }

  Future<void> ubahUrlApi(String url) async {
    final uri = Uri.tryParse(url.trim());

    if (uri == null ||
        !uri.hasScheme ||
        !uri.hasAuthority ||
        !['http', 'https'].contains(uri.scheme)) {
      throw ArgumentError('URL API tidak valid.');
    }

    _urlApi = url.trim().replaceAll(RegExp(r'/+$'), '');

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kunciUrlApi, _urlApi);

    notifyListeners();
  }
}
