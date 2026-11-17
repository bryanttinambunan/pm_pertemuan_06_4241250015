import 'package:flutter/material.dart';

import '../data/destination_data.dart';
import '../models/destination.dart';
import '../utils/app_constants.dart';
import '../widgets/category_chip.dart';
import '../widgets/destination_card.dart';
import '../widgets/search_field.dart';

/// Halaman Katalog Wisata Explore Sumut.
///
/// Menyajikan:
/// - Pencarian teks secara live berdasarkan nama dan lokasi destinasi.
/// - Filter kategori menggunakan [CategoryChip] (Semua, Alam, Sejarah, Pantai, Religi).
/// - Grid adaptif wajib menggunakan [LayoutBuilder]:
///   * Lebar < 600 dp: 2 kolom
///   * Lebar 600-899 dp: 3 kolom
///   * Lebar >= 900 dp: 4 kolom
/// - State kosong (Empty State) yang informatif bila destinasi tidak ditemukan.
class CatalogScreen extends StatefulWidget {
  final String? initialQuery;

  const CatalogScreen({super.key, this.initialQuery});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  late final TextEditingController _searchController;
  String _selectedCategory = 'Semua';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery ?? '');
  }

  @override
  void didUpdateWidget(covariant CatalogScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialQuery != oldWidget.initialQuery &&
        widget.initialQuery != null) {
      _searchController.text = widget.initialQuery!;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Filter daftar destinasi berdasarkan kata kunci pencarian dan kategori terpilih
    final List<Destination> filteredDestinasi = filterDestinasi(
      query: _searchController.text.trim(),
      kategori: _selectedCategory,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Wisata Sumut'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${filteredDestinasi.length} Wisata',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Bagian Pencarian & Filter Kategori
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Column(
              children: [
                SearchField(
                  controller: _searchController,
                  hintText: 'Cari nama destinasi, kabupaten, atau ciri khas...',
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 10),

                // Daftar Filter Kategori horizontal
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: AppConstants.categories.map((kategori) {
                      IconData? icon;
                      if (kategori == 'Alam') {
                        icon = Icons.forest_rounded;
                      } else if (kategori == 'Sejarah') {
                        icon = Icons.account_balance_rounded;
                      } else if (kategori == 'Pantai') {
                        icon = Icons.beach_access_rounded;
                      } else if (kategori == 'Religi') {
                        icon = Icons.mosque_rounded;
                      } else if (kategori == 'Semua') {
                        icon = Icons.grid_view_rounded;
                      }

                      return CategoryChip(
                        label: kategori,
                        icon: icon,
                        isSelected: _selectedCategory == kategori,
                        onTap: () {
                          setState(() {
                            _selectedCategory = kategori;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, thickness: 1),

          // Area Gridview Responsif dengan LayoutBuilder
          Expanded(
            child: filteredDestinasi.isEmpty
                ? _buildEmptyState(context)
                : LayoutBuilder(
                    builder: (context, constraints) {
                      // Ketentuan wajib LayoutBuilder berdasarkan batas lebar:
                      // - Lebar di bawah 600 dp: 2 kolom.
                      // - Lebar 600–899 dp: 3 kolom.
                      // - Lebar 900 dp ke atas: 4 kolom.
                      final int crossAxisCount = switch (constraints.maxWidth) {
                        < 600 => 2,
                        < 900 => 3,
                        _ => 4,
                      };

                      return GridView.builder(
                        padding: const EdgeInsets.all(12),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.76,
                        ),
                        itemCount: filteredDestinasi.length,
                        itemBuilder: (context, index) {
                          return DestinationCard(
                            destination: filteredDestinasi[index],
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  /// Tampilan jika hasil pencarian atau filter kosong
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search_off_rounded,
                size: 64,
                color: Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Destinasi Tidak Ditemukan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              'Tidak ada destinasi yang cocok dengan "${_searchController.text}" '
              'pada kategori $_selectedCategory.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
            const SizedBox(height: 16),
            FilledButton.tonalIcon(
              onPressed: () {
                setState(() {
                  _searchController.clear();
                  _selectedCategory = 'Semua';
                });
              },
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text('Reset Filter & Pencarian'),
            ),
          ],
        ),
      ),
    );
  }
}
