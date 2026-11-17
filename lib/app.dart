import 'package:flutter/material.dart';

import 'routes/app_router.dart';
import 'utils/app_constants.dart';
import 'utils/app_theme.dart';

/// Widget utama aplikasi Explore Sumut.
///
/// Menggunakan [MaterialApp.router] untuk mengintegrasikan [GoRouter]
/// dan tema modern Material Design 3.
class ExploreSumutApp extends StatelessWidget {
  const ExploreSumutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
