import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:tabungku/services/api_service.dart';

void main() {
  group('ApiService - cekKoneksi', () {
    test('API dan database terhubung (200)', () async {
      final client = MockClient((request) async {
        return http.Response(
          jsonEncode({
            'status': 'ok',
            'database': 'connected',
            'mysql_version': '8.4.13',
            'waktu_server': '2026-11-01T10:00:00',
          }),
          200,
        );
      });

      final service = ApiService(
        baseUrl: 'http://localhost:9000',
        client: client,
      );

      final result = await service.cekKoneksi();

      expect(result['api'], true);
      expect(result['database'], true);
      expect(result['status'], 'ok');
      expect(result['mysql_version'], '8.4.13');

      service.dispose();
    });

    test('API aktif tetapi database tidak terhubung (503)', () async {
      final client = MockClient((request) async {
        return http.Response(
          jsonEncode({
            'detail': {
              'status': 'error',
              'database': 'error',
              'detail': 'Database connection failed',
            },
          }),
          503,
        );
      });

      final service = ApiService(
        baseUrl: 'http://localhost:9000',
        client: client,
      );

      final result = await service.cekKoneksi();

      expect(result['api'], true);
      expect(result['database'], false);
      expect(result['status'], 'error');
      expect(
        result['pesan'],
        'API aktif, tetapi database tidak terhubung.',
      );

      service.dispose();
    });

    test('Menangani HTTP 404', () async {
      final client = MockClient((request) async {
        return http.Response('{}', 404);
      });

      final service = ApiService(
        baseUrl: 'http://localhost:9000',
        client: client,
      );

      final result = await service.cekKoneksi();

      expect(result['api'], true);
      expect(result['database'], false);
      expect(result['pesan'], 'Server mengembalikan HTTP 404.');

      service.dispose();
    });
  });
}
