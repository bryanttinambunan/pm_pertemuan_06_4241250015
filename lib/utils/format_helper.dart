/// Helper ekstensi untuk pemformatan data angka dan string.
extension Rupiah on int {
  /// Mengubah angka integer menjadi format mata uang Rupiah.
  /// Contoh: 20000 -> "Rp20.000", 0 -> "Gratis".
  String get rupiah {
    if (this == 0) return 'Gratis';
    final pola = RegExp(r'\B(?=(\d{3})+(?!\d))');
    return 'Rp${toString().replaceAllMapped(pola, (m) => '.')}';
  }
}
