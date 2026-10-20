import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pengaturan extends ChangeNotifier {
  static const int targetDefault = 20000;
  static const String _kunciTarget = 'target_tabungan';
  static const String _kunciModeGelap = 'mode_gelap';
  static const String _kunciWarna = 'warna_tema';

  int _targetTabungan = targetDefault;
  bool _modeGelap = false;
  int _warnaTema = Colors.teal.value;

  int get targetTabungan => _targetTabungan;
  bool get modeGelap => _modeGelap;
  Color get warnaTema => Color(_warnaTema);

  Future<void> muat() async {
    final prefs = await SharedPreferences.getInstance();

    _targetTabungan = prefs.getInt(_kunciTarget) ?? targetDefault;
    _modeGelap = prefs.getBool(_kunciModeGelap) ?? false;
    _warnaTema = prefs.getInt(_kunciWarna) ?? Colors.teal.value;

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
}
