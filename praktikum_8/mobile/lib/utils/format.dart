String formatRupiah(int nominal) {
  final angka = nominal.abs().toString();
  final hasil = StringBuffer();

  for (var i = 0; i < angka.length; i++) {
    if (i > 0 && (angka.length - i) % 3 == 0) {
      hasil.write('.');
    }
    hasil.write(angka[i]);
  }

  final tanda = nominal < 0 ? '- ' : '';
  return '${tanda}Rp${hasil.toString()}';
}

String formatTanggal(String tanggal) {
  final parsed = DateTime.tryParse(tanggal);
  if (parsed == null) return tanggal;

  const namaBulan = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  return '${parsed.day} ${namaBulan[parsed.month - 1]} ${parsed.year}';
}

String tanggalHariIni() {
  final sekarang = DateTime.now();
  final tahun = sekarang.year.toString().padLeft(4, '0');
  final bulan = sekarang.month.toString().padLeft(2, '0');
  final hari = sekarang.day.toString().padLeft(2, '0');

  return '$tahun-$bulan-$hari';
}
