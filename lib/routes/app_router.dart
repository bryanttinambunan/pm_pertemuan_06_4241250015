import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/destination_data.dart';
import '../screens/about_screen.dart';
import '../screens/catalog_screen.dart';
import '../screens/category_screen.dart';
import '../screens/detail_screen.dart';
import '../screens/home_screen.dart';
import '../screens/not_found_screen.dart';
import '../screens/splash_screen.dart';
import '../widgets/responsive_navigation.dart';

/// Konfigurasi Rute Navigasi Deklaratif menggunakan go_router.
///
/// Memenuhi seluruh spesifikasi navigasi multi-screen:
/// - Menggunakan [StatefulShellRoute.indexedStack] untuk kerangka navigasi adaptif (NavigationBar / NavigationRail).
/// - Mendukung deep link dan URL parameter (`:id`, `:nama`).
/// - Parsing ID menggunakan [int.tryParse] dengan penanganan fallback jika tidak ditemukan.
/// - Menangani error route dengan [NotFoundScreen].
class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    errorBuilder: (context, state) =>
        NotFoundScreen(message: 'Halaman "${state.uri}" tidak ditemukan.'),
    routes: [
      // 1. Rute Splash Screen
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // 2. Kerangka Navigasi Adaptif dengan StatefulShellRoute
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ResponsiveNavigationScaffold(navigationShell: navigationShell);
        },
        branches: [
          // Cabang 0: Beranda (/)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),

          // Cabang 1: Katalog Wisata (/katalog)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/katalog',
                builder: (context, state) {
                  final query = state.uri.queryParameters['q'];
                  return CatalogScreen(initialQuery: query);
                },
              ),
            ],
          ),

          // Cabang 2: Tentang Aplikasi (/tentang)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/tentang',
                builder: (context, state) => const AboutScreen(),
              ),
            ],
          ),
        ],
      ),

      // 3. Rute Detail Wisata (/detail/:id)
      GoRoute(
        path: '/detail/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final idParam = state.pathParameters['id'];
          final id = int.tryParse(idParam ?? '');

          return DetailScreen(
            requestedId: id,
            destination: id == null ? null : cariDestinasi(id),
          );
        },
      ),

      // 4. Rute Kategori Wisata (/kategori/:nama)
      GoRoute(
        path: '/kategori/:nama',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final categoryName = state.pathParameters['nama'] ?? 'Semua';
          return CategoryScreen(categoryName: categoryName);
        },
      ),
    ],
  );
}
