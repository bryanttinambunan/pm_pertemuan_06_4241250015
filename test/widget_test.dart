import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:explore_sumut/app.dart';
import 'package:explore_sumut/data/destination_data.dart';
import 'package:explore_sumut/models/destination.dart';
import 'package:explore_sumut/screens/catalog_screen.dart';
import 'package:explore_sumut/screens/detail_screen.dart';
import 'package:explore_sumut/utils/format_helper.dart';
import 'package:explore_sumut/widgets/destination_card.dart';

void main() {
  group('Unit Test: Model Destinasi & Helper Format', () {
    test('Format Rupiah dan status gratis bekerja dengan benar', () {
      expect(20000.rupiah, 'Rp20.000');
      expect(10000.rupiah, 'Rp10.000');
      expect(0.rupiah, 'Gratis');
    });

    test('Data master destinasi memiliki minimal 8 data sesuai modul', () {
      expect(daftarDestinasi.length, greaterThanOrEqualTo(8));
      final names = daftarDestinasi.map((d) => d.nama).toList();
      expect(names, contains('Danau Toba'));
      expect(names, contains('Bukit Lawang'));
      expect(names, contains('Berastagi'));
      expect(names, contains('Istana Maimun'));
      expect(names, contains('Air Terjun Sipiso-piso'));
      expect(names, contains('Pantai Pandan'));
      expect(names, contains('Tangkahan'));
      expect(names, contains('Masjid Raya Al-Mashun'));
    });

    test('Pencarian data cariDestinasi(id) mengembalikan objek atau null', () {
      final toba = cariDestinasi(1);
      expect(toba, isNotNull);
      expect(toba!.nama, 'Danau Toba');
      expect(toba.hargaTiket, 20000);

      final tidakAda = cariDestinasi(9999);
      expect(tidakAda, isNull);
    });

    test('Filter destinasi berdasarkan kategori dan teks pencarian', () {
      final alam = cariDestinasiByKategori('Alam');
      expect(alam.every((d) => d.kategori == 'Alam'), isTrue);

      final pantai = cariDestinasiByKategori('Pantai');
      expect(pantai.length, greaterThanOrEqualTo(1));
      expect(pantai.first.nama, 'Pantai Pandan');

      final hasilCari = filterDestinasi(query: 'Maimun');
      expect(hasilCari.length, 1);
      expect(hasilCari.first.nama, 'Istana Maimun');
    });
  });

  group('Widget Test: Responsivitas & LayoutBuilder', () {
    testWidgets(
      'DetailScreen responsif: ListView pada layar sempit & Row pada layar lebar',
      (WidgetTester tester) async {
        final Destination sample = daftarDestinasi.first;

        // 1. Uji Layar Sempit (< 700 dp)
        tester.view.physicalSize = const Size(400, 800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(
          MaterialApp(
            home: DetailScreen(destination: sample, requestedId: sample.id),
          ),
        );
        await tester.pumpAndSettle();

        // Layar sempit menggunakan ListView
        expect(find.byType(ListView), findsOneWidget);
        expect(find.text('Danau Toba'), findsWidgets);
        expect(find.text('Harga Tiket Masuk'), findsOneWidget);

        // 2. Uji Layar Lebar (>= 700 dp)
        tester.view.physicalSize = const Size(900, 700);
        await tester.pumpWidget(
          MaterialApp(
            home: DetailScreen(destination: sample, requestedId: sample.id),
          ),
        );
        await tester.pumpAndSettle();

        // Layar lebar menggunakan susunan Row side-by-side
        expect(find.byType(Row), findsWidgets);
        expect(find.text('Danau Toba'), findsWidgets);
      },
    );

    testWidgets('DetailScreen menangani ID tidak ditemukan secara aman', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: DetailScreen(destination: null, requestedId: 9999),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Destinasi Tidak Ditemukan'), findsOneWidget);
      expect(find.textContaining('9999'), findsOneWidget);
    });

    testWidgets('CatalogScreen memfilter data saat pencarian diketik', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(500, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(const MaterialApp(home: CatalogScreen()));
      await tester.pumpAndSettle();

      // Destinasi awal tampil
      expect(find.text('Danau Toba'), findsOneWidget);

      // Ketik pencarian "Sipiso"
      await tester.enterText(find.byType(TextField), 'Sipiso');
      await tester.pumpAndSettle();

      expect(find.text('Air Terjun Sipiso-piso'), findsOneWidget);
      expect(find.text('Danau Toba'), findsNothing);
    });

    testWidgets('Card Destinasi mengimplementasikan Stack dan Hero', (
      WidgetTester tester,
    ) async {
      final sample = daftarDestinasi.first;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 260,
              child: DestinationCard(destination: sample),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(Stack), findsWidgets);
      expect(find.byType(Hero), findsOneWidget);
      expect(find.text(sample.nama), findsOneWidget);
      expect(find.text(sample.kategori), findsOneWidget);
    });
  });

  group('Widget Test: Pengujian Responsivitas pada 6 Ukuran Layar Wajib', () {
    const breakpoints = [360.0, 480.0, 600.0, 840.0, 1024.0, 1280.0];

    for (final width in breakpoints) {
      testWidgets('Uji bebas overflow pada lebar $width dp', (
        WidgetTester tester,
      ) async {
        tester.view.physicalSize = Size(width, 800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(const MaterialApp(home: CatalogScreen()));
        await tester.pumpAndSettle();

        // Verifikasi elemen katalog tampil
        expect(find.text('Katalog Wisata Sumut'), findsOneWidget);
        expect(find.text('Danau Toba'), findsWidgets);

        // Verifikasi jumlah kolom GridView sesuai LayoutBuilder
        final gridFinder = find.byType(GridView);
        expect(gridFinder, findsOneWidget);
        final GridView gridView = tester.widget(gridFinder);
        final delegate =
            gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;

        if (width < 600) {
          expect(delegate.crossAxisCount, 2);
        } else if (width < 900) {
          expect(delegate.crossAxisCount, 3);
        } else {
          expect(delegate.crossAxisCount, 4);
        }
      });
    }
  });

  group('Widget Test: Smoke Test ExploreSumutApp', () {
    testWidgets('ExploreSumutApp dapat dijalankan tanpa crash', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(const ExploreSumutApp());
      // Splash screen tampil
      expect(find.text('Explore Sumut'), findsOneWidget);

      // Pompa timer splash screen hingga selesai transisi ke Beranda
      await tester.pump(const Duration(milliseconds: 2500));
      await tester.pumpAndSettle();

      // Verifikasi sampai di halaman beranda
      expect(find.text('Kategori Wisata'), findsOneWidget);
      expect(find.text('Destinasi Populer'), findsOneWidget);
    });
  });
}
