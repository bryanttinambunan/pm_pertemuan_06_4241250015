import 'package:flutter/material.dart';

import '../utils/app_constants.dart';

/// Halaman Tentang Aplikasi (About Screen) Explore Sumut.
///
/// Menyajikan:
/// - Header bertumpuk menggunakan [Stack] dan [Positioned] sesuai contoh Modul Ajar.
/// - Penjelasan visi & tujuan pembuatan aplikasi.
/// - Identitas Mahasiswa dan Mata Kuliah Pemrograman Mobile UNIMED.
/// - Indikator ukuran layar real-time untuk pengujian responsivitas.
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final screenWidth = MediaQuery.sizeOf(context).width;

    // Menentukan Window Size Class Material 3
    final String sizeClass = screenWidth < 600
        ? 'Compact (Ponsel)'
        : (screenWidth < 840
              ? 'Medium (Tablet Portrait)'
              : 'Expanded (Tablet Landscape / Desktop)');

    final String navType = screenWidth < 840
        ? 'NavigationBar (Bawah)'
        : 'NavigationRail (Samping)';

    return Scaffold(
      appBar: AppBar(title: const Text('Tentang Aplikasi')),
      body: ListView(
        children: [
          // Header Bertumpuk Wajib Menggunakan Stack & Positioned (Sesuai Modul Ajar)
          SizedBox(
            height: 180,
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                Positioned.fill(
                  child: ColoredBox(color: colorScheme.primaryContainer),
                ),
                // Watermark Icon di Pojok Kanan Bawah
                Positioned(
                  right: -20,
                  bottom: -24,
                  child: Icon(
                    Icons.landscape_rounded,
                    size: 190,
                    color: colorScheme.primary.withValues(alpha: 0.18),
                  ),
                ),
                // Judul dan Keterangan di Pojok Kiri Bawah
                Positioned(
                  left: 20,
                  bottom: 24,
                  right: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'TUGAS RUTIN 6',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        AppConstants.appName,
                        style: textTheme.headlineMedium?.copyWith(
                          color: colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        AppConstants.appTagline,
                        style: TextStyle(
                          color: colorScheme.onPrimaryContainer.withValues(
                            alpha: 0.8,
                          ),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Indikator Status Responsivitas Layar
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.devices_rounded,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Status Ukuran Layar Saat Ini',
                              style: textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Lebar Layar (dp):',
                              style: TextStyle(fontSize: 13),
                            ),
                            Text(
                              '${screenWidth.toStringAsFixed(1)} dp',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Size Class (M3):',
                              style: TextStyle(fontSize: 13),
                            ),
                            Text(
                              sizeClass,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Komponen Navigasi:',
                              style: TextStyle(fontSize: 13),
                            ),
                            Text(
                              navType,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Penjelasan Aplikasi & Tujuan
                Text(
                  'Deskripsi Proyek',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppConstants.appDescription,
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade800,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 20),

                // Kartu Identitas Mahasiswa & Pengembang
                Text(
                  'Identitas Pengembang',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  child: Column(
                    children: [
                      _buildInfoTile(
                        icon: Icons.person_outline_rounded,
                        title: 'Nama Mahasiswa',
                        subtitle: AppConstants.studentName,
                      ),
                      _buildInfoTile(
                        icon: Icons.badge_outlined,
                        title: 'Nomor Induk Mahasiswa (NIM)',
                        subtitle: AppConstants.studentNIM,
                      ),
                      _buildInfoTile(
                        icon: Icons.school_outlined,
                        title: 'Program Studi / Kelas',
                        subtitle:
                            '${AppConstants.studyProgram} (${AppConstants.studentClass})',
                      ),
                      _buildInfoTile(
                        icon: Icons.domain_rounded,
                        title: 'Fakultas & Universitas',
                        subtitle:
                            '${AppConstants.faculty}\n${AppConstants.university}',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Informasi Akademik & Mata Kuliah
                Text(
                  'Informasi Mata Kuliah',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  child: Column(
                    children: [
                      _buildInfoTile(
                        icon: Icons.menu_book_rounded,
                        title: 'Mata Kuliah',
                        subtitle: AppConstants.courseName,
                      ),
                      _buildInfoTile(
                        icon: Icons.assignment_outlined,
                        title: 'Topik Pertemuan 6',
                        subtitle: 'Layout Responsif & Navigasi Multi-Screen di Flutter (Indikator 6.1)',
                      ),
                      _buildInfoTile(
                        icon: Icons.person_pin_rounded,
                        title: 'Dosen Pengampu',
                        subtitle: AppConstants.lecturer,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Teknologi yang Digunakan
                Text(
                  'Teknologi & Paket',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const [
                    Chip(
                      avatar: FlutterLogo(size: 16),
                      label: Text('Flutter 3.x'),
                    ),
                    Chip(
                      avatar: Icon(Icons.code_rounded, size: 16),
                      label: Text('Dart 3.x'),
                    ),
                    Chip(
                      avatar: Icon(Icons.route_rounded, size: 16),
                      label: Text('go_router ^18.x'),
                    ),
                    Chip(
                      avatar: Icon(Icons.palette_outlined, size: 16),
                      label: Text('Material Design 3'),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF1B5E20)),
      title: Text(
        title,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }
}
