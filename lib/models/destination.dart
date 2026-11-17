import 'package:flutter/material.dart';

/// Model data untuk Destinasi Wisata Sumatera Utara.
///
/// Menyimpan seluruh atribut informasi yang dibutuhkan untuk menampilkan
/// kartu destinasi, filter kategori, hingga rincian detail destinasi.
class Destination {
  final int id;
  final String nama;
  final String kabupatenKota;
  final String kategori;
  final String deskripsi;
  final int hargaTiket; // 0 menandakan Gratis
  final IconData ikon;
  final Color warna;
  final String gambar;
  final String lokasi;
  final double rating;
  final String jamOperasional;
  final List<String> fasilitas;

  const Destination({
    required this.id,
    required this.nama,
    required this.kabupatenKota,
    required this.kategori,
    required this.deskripsi,
    required this.hargaTiket,
    required this.ikon,
    required this.warna,
    required this.gambar,
    required this.lokasi,
    this.rating = 4.8,
    this.jamOperasional = '08:00 - 18:00 WIB',
    this.fasilitas = const ['Area Parkir', 'Toilet', 'Musholla', 'Spot Foto'],
  });

  /// Mengetahui apakah tiket masuk gratis
  bool get isGratis => hargaTiket == 0;
}
