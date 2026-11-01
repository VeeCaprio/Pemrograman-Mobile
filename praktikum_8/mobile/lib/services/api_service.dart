import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;
  final http.Client client;

  ApiService({
    required this.baseUrl,
    http.Client? client,
  }) : client = client ?? http.Client();

  Future<Map<String, dynamic>> cekKoneksi() async {
    final stopwatch = Stopwatch()..start();

    try {
      final url = Uri.parse('$baseUrl/health');

      final response =
          await client.get(url).timeout(const Duration(seconds: 10));

      stopwatch.stop();

      final data = jsonDecode(response.body);

      if (data is! Map<String, dynamic>) {
        throw const FormatException('Format respons API tidak valid.');
      }

      if (response.statusCode == 200) {
        return {
          'api': true,
          'database': data['database'] == 'connected',
          'status': data['status'] ?? 'unknown',
          'mysql_version': data['mysql_version'],
          'waktu_server': data['waktu_server'],
          'latensi': stopwatch.elapsedMilliseconds,
          'pesan': 'Koneksi berhasil.',
        };
      }

      if (response.statusCode == 503) {
        return {
          'api': true,
          'database': false,
          'status': 'error',
          'mysql_version': null,
          'waktu_server': data['waktu_server'],
          'latensi': stopwatch.elapsedMilliseconds,
          'pesan': 'API aktif, tetapi database tidak terhubung.',
        };
      }

      return {
        'api': true,
        'database': false,
        'status': 'error',
        'mysql_version': null,
        'waktu_server': null,
        'latensi': stopwatch.elapsedMilliseconds,
        'pesan': 'Server mengembalikan HTTP ${response.statusCode}.',
      };
    } on FormatException {
      stopwatch.stop();

      return {
        'api': false,
        'database': false,
        'status': 'error',
        'mysql_version': null,
        'waktu_server': null,
        'latensi': stopwatch.elapsedMilliseconds,
        'pesan': 'Format respons API tidak valid.',
      };
    } catch (error) {
      stopwatch.stop();

      return {
        'api': false,
        'database': false,
        'status': 'error',
        'mysql_version': null,
        'waktu_server': null,
        'latensi': stopwatch.elapsedMilliseconds,
        'pesan': 'Tidak dapat terhubung ke server API: $error',
      };
    }
  }

  void dispose() {
    client.close();
  }
}
