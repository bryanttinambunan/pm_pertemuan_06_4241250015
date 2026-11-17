import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/app_constants.dart';

/// Kerangka navigasi adaptif multi-screen.
///
/// Menggunakan:
/// - [MediaQuery.sizeOf] untuk mendeteksi lebar layar secara reaktif.
/// - [NavigationRail] pada layar lebar (>= 840 dp) yang disusun di samping dengan [Row] dan [Expanded].
/// - [NavigationBar] pada layar sempit (< 840 dp) di bagian bawah.
/// - [StatefulNavigationShell] dari go_router untuk mempertahankan state masing-masing cabang navigasi.
class ResponsiveNavigationScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ResponsiveNavigationScaffold({
    super.key,
    required this.navigationShell,
  });

  void _onDestinationSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Pengambilan ukuran layar menggunakan MediaQuery.sizeOf sesuai anjuran Flutter modern
    final double screenWidth = MediaQuery.sizeOf(context).width;

    // Layar Lebar (Tablet / Desktop >= 840 dp): Navigasi di samping menggunakan NavigationRail
    if (screenWidth >= AppConstants.navigationBreakpoint) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: _onDestinationSelected,
              labelType: NavigationRailLabelType.all,
              leading: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.landscape_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Explore\nSumut',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ],
                ),
              ),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home_rounded),
                  label: Text('Beranda'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.explore_outlined),
                  selectedIcon: Icon(Icons.explore_rounded),
                  label: Text('Katalog'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.info_outline_rounded),
                  selectedIcon: Icon(Icons.info_rounded),
                  label: Text('Tentang'),
                ),
              ],
            ),
            const VerticalDivider(width: 1, thickness: 1),
            // Expanded memastikan konten shell mengisi seluruh sisa ruang horizontal
            Expanded(child: navigationShell),
          ],
        ),
      );
    }

    // Layar Sempit (Ponsel < 840 dp): Navigasi di bagian bawah menggunakan NavigationBar
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore_rounded),
            label: 'Katalog',
          ),
          NavigationDestination(
            icon: Icon(Icons.info_outline_rounded),
            selectedIcon: Icon(Icons.info_rounded),
            label: 'Tentang',
          ),
        ],
      ),
    );
  }
}
