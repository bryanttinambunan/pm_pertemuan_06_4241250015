import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/destination_data.dart';
import '../models/destination.dart';
import '../utils/app_constants.dart';
import '../widgets/destination_card.dart';
import '../widgets/featured_banner.dart';
import '../widgets/search_field.dart';

/// Halaman Beranda (Home Screen) Explore Sumut.
///
/// Menyajikan:
/// - AppBar dengan logo dan nama aplikasi.
/// - Sapaan headline keindahan Sumatera Utara.
/// - Kolom pencarian cepat.
/// - Banner destinasi unggulan ([FeaturedBanner]).
/// - Tombol kategori wisata cepat yang mengarahkan ke rute `/kategori/:nama`.
/// - Daftar destinasi populer dengan tata letak adaptif.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchSubmitted(String query) {
    if (query.trim().isNotEmpty) {
      // Navigasi ke katalog dengan query pencarian
      context.go('/katalog?q=${Uri.encodeComponent(query.trim())}');
    } else {
      context.go('/katalog');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    // Ambil 4 destinasi dengan rating tertinggi sebagai destinasi populer
    final List<Destination> destinasiPopuler = List.from(daftarDestinasi)
      ..sort((a, b) => b.rating.compareTo(a.rating));
    final empatTerpopuler = destinasiPopuler.take(4).toList();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.landscape_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppConstants.appName,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Sumatera Utara, Indonesia',
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded),
            tooltip: 'Tentang Aplikasi',
            onPressed: () => context.go('/tentang'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // Sapaan / Headline
          Text(
            'Halo, Wisatawan! 👋',
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Temukan Pesona Sumatera Utara',
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 14),

          // Kolom Pencarian Cepat
          SearchField(
            controller: _searchController,
            hintText: 'Cari Danau Toba, Berastagi, air terjun...',
            onSubmitted: () => _onSearchSubmitted(_searchController.text),
            onTap: () {
              // Jika ditekan, pengguna juga dapat langsung masuk ke katalog
            },
            onChanged: (val) {},
          ),
          const SizedBox(height: 14),

          // Banner Destinasi Unggulan (Stack & Positioned)
          const FeaturedBanner(),

          const SizedBox(height: 18),

          // Baris Kategori Wisata Cepat
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Kategori Wisata',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              TextButton(
                onPressed: () => context.go('/katalog'),
                child: const Text('Lihat Semua'),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Kategori Grid Icons dengan SingleChildScrollView horizontal agar aman di layar sekecil apapun
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategoryButton(
                  context,
                  title: 'Alam',
                  icon: Icons.forest_rounded,
                  color: const Color(0xFF2E7D32),
                ),
                const SizedBox(width: 12),
                _buildCategoryButton(
                  context,
                  title: 'Sejarah',
                  icon: Icons.account_balance_rounded,
                  color: const Color(0xFFF57F17),
                ),
                const SizedBox(width: 12),
                _buildCategoryButton(
                  context,
                  title: 'Pantai',
                  icon: Icons.beach_access_rounded,
                  color: const Color(0xFF00ACC1),
                ),
                const SizedBox(width: 12),
                _buildCategoryButton(
                  context,
                  title: 'Religi',
                  icon: Icons.mosque_rounded,
                  color: const Color(0xFF5E35B1),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Destinasi Populer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Destinasi Populer',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              TextButton.icon(
                onPressed: () => context.go('/katalog'),
                icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                label: const Text('Katalog Lengkap'),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // LayoutBuilder untuk menampilkan kartu populer secara responsif
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth < 600
                  ? 2
                  : (constraints.maxWidth < 900 ? 3 : 4);

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.76,
                ),
                itemCount: empatTerpopuler.length,
                itemBuilder: (context, index) {
                  return DestinationCard(destination: empatTerpopuler[index]);
                },
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
  }) {
    return InkWell(
      onTap: () => context.go('/kategori/$title'),
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: color.withValues(alpha: 0.3),
                  width: 1.2,
                ),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
