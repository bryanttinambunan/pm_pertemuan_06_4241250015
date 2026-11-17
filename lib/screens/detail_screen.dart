import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/destination.dart';
import '../utils/app_constants.dart';
import '../utils/format_helper.dart';
import 'not_found_screen.dart';

/// Halaman Detail Wisata Explore Sumut.
///
/// Memenuhi ketentuan wajib:
/// - Menerima parameter ID destinasi dan memvalidasinya secara aman.
/// - Menampilkan pesan tidak ditemukan jika ID tidak valid.
/// - **LayoutBuilder**:
///   * Layar sempit (< 700 dp): [ListView] vertikal (gambar di atas, info di bawah).
///   * Layar lebar (>= 700 dp): [Row] berdampingan menggunakan [Expanded].
/// - **Stack** dan [Positioned]: Menumpuk badge kategori, rating, dan gradien di atas gambar.
/// - Navigasi kategori dengan [context.go] ke `/kategori/:nama`.
/// - Menangani teks panjang dan mencegah overflow secara tuntas.
class DetailScreen extends StatelessWidget {
  final Destination? destination;
  final int? requestedId;

  const DetailScreen({super.key, required this.destination, this.requestedId});

  @override
  Widget build(BuildContext context) {
    // Tangani jika data destinasi tidak ditemukan
    if (destination == null) {
      return NotFoundScreen(
        message: 'Destinasi dengan ID #${requestedId ?? '-'} tidak ditemukan.',
      );
    }

    final destinasi = destination!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    // Widget Gambar dengan Stack & Positioned
    final Widget imageWidget = AspectRatio(
      aspectRatio: 16 / 10,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            tag: 'destination-img-${destinasi.id}',
            child: Image.asset(
              destinasi.gambar,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: destinasi.warna.withValues(alpha: 0.2),
                  child: Center(
                    child: Icon(
                      destinasi.ikon,
                      size: 96,
                      color: destinasi.warna,
                    ),
                  ),
                );
              },
            ),
          ),

          // Gradient Overlay
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.4),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.7),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          // Badge Kategori (Bisa diklik untuk navigasi ke /kategori/:nama)
          Positioned(
            left: 16,
            bottom: 16,
            child: InkWell(
              onTap: () => context.go('/kategori/${destinasi.kategori}'),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: destinasi.warna,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(destinasi.ikon, color: Colors.white, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      destinasi.kategori,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white70,
                      size: 11,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Rating di kanan bawah gambar
          Positioned(
            right: 16,
            bottom: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    destinasi.rating.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    // Widget Informasi Rincian Destinasi
    final Widget infoWidget = Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nama Destinasi
          Text(
            destinasi.nama,
            style: textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),

          // Wilayah Kabupaten/Kota
          Row(
            children: [
              Icon(Icons.location_on, color: colorScheme.primary, size: 18),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  destinasi.kabupatenKota,
                  style: textTheme.titleSmall?.copyWith(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Card Informasi Harga & Jam Operasional
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: colorScheme.primary.withValues(alpha: 0.15),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Harga Tiket Masuk',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        destinasi.isGratis
                            ? 'Gratis'
                            : destinasi.hargaTiket.rupiah,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: destinasi.isGratis
                              ? const Color(0xFF2E7D32)
                              : colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(width: 1, height: 40, color: Colors.grey.shade300),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jam Operasional',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        destinasi.jamOperasional,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Alamat Lengkap
          Text(
            'Lokasi & Alamat',
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.map_outlined, size: 18, color: Colors.grey),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  destinasi.lokasi,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Deskripsi Destinasi
          Text(
            'Tentang Destinasi',
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            destinasi.deskripsi,
            style: textTheme.bodyLarge?.copyWith(
              color: Colors.black87,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 20),

          // Fasilitas Tersedia
          Text(
            'Fasilitas Wisata',
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: destinasi.fasilitas.map((f) {
              return Chip(
                avatar: const Icon(Icons.check_circle_outline, size: 16),
                label: Text(f, style: const TextStyle(fontSize: 12)),
                backgroundColor: Colors.white,
              );
            }).toList(),
          ),

          const SizedBox(height: 30),

          // Tombol Kembali & Bagikan
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go('/katalog');
                    }
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Kembali'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Tautan ${destinasi.nama} berhasil disalin!',
                        ),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.share_rounded),
                  label: const Text('Bagikan'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(destinasi.nama),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/katalog');
            }
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // KETENTUAN RESPONSIF WAJIB:
          // - Layar lebar (>= 700 dp): gambar dan informasi berdampingan menggunakan Row dan Expanded.
          // - Layar sempit (< 700 dp): gambar di atas dan informasi di bawah menggunakan ListView/Column.
          if (constraints.maxWidth >= AppConstants.detailBreakpoint) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: imageWidget,
                      ),
                    ),
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  flex: 6,
                  child: SingleChildScrollView(child: infoWidget),
                ),
              ],
            );
          }

          // Layar Sempit (< 700 dp)
          return ListView(children: [imageWidget, infoWidget]);
        },
      ),
    );
  }
}
