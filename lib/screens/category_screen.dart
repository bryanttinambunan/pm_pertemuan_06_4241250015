import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/destination_data.dart';
import '../widgets/destination_card.dart';

/// Halaman Kategori Wisata (/kategori/:nama).
///
/// Menyajikan seluruh destinasi yang termasuk dalam kategori tertentu
/// dengan tampilan header tematik dan grid responsif.
class CategoryScreen extends StatelessWidget {
  final String categoryName;

  const CategoryScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final listDestinasi = cariDestinasiByKategori(categoryName);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Menentukan icon dan warna aksen sesuai kategori
    IconData categoryIcon = Icons.category_rounded;
    Color categoryColor = colorScheme.primary;

    switch (categoryName.toLowerCase()) {
      case 'alam':
        categoryIcon = Icons.forest_rounded;
        categoryColor = const Color(0xFF2E7D32);
        break;
      case 'sejarah':
        categoryIcon = Icons.account_balance_rounded;
        categoryColor = const Color(0xFFF57F17);
        break;
      case 'pantai':
        categoryIcon = Icons.beach_access_rounded;
        categoryColor = const Color(0xFF00ACC1);
        break;
      case 'religi':
        categoryIcon = Icons.mosque_rounded;
        categoryColor = const Color(0xFF5E35B1);
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Kategori: $categoryName'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
      ),
      body: Column(
        children: [
          // Header Banner Kategori
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: categoryColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: categoryColor.withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: categoryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(categoryIcon, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Wisata $categoryName',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: categoryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Menampilkan ${listDestinasi.length} destinasi pilihan di Sumatera Utara.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Area Gridview Adaptif
          Expanded(
            child: listDestinasi.isEmpty
                ? Center(
                    child: Text(
                      'Belum ada destinasi dalam kategori $categoryName',
                    ),
                  )
                : LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount = constraints.maxWidth < 600
                          ? 2
                          : (constraints.maxWidth < 900 ? 3 : 4);

                      return GridView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.76,
                        ),
                        itemCount: listDestinasi.length,
                        itemBuilder: (context, index) {
                          return DestinationCard(
                            destination: listDestinasi[index],
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
}
