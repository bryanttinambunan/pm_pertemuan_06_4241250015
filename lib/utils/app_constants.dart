/// Konstanta konfigurasi aplikasi Explore Sumut.
class AppConstants {
  static const String appName = 'Explore Sumut';
  static const String appTagline = 'Pesona Wisata Sumatera Utara';
  static const String appDescription =
      'Explore Sumut adalah aplikasi panduan wisata Sumatera Utara berbasis Flutter '
      'yang dirancang dengan prinsip desain responsif Material 3 dan navigasi deklaratif multi-screen. '
      'Aplikasi ini mempermudah wisatawan menemukan keindahan alam, kekayaan sejarah, pesona pantai, '
      'dan nilai religi di Sumatera Utara.';

  // Informasi Identitas Mahasiswa & Tugas Rutin 6
  static const String studentName = 'Bryant Tinambunan';
  static const String studentNIM = '4241250015';
  static const String studentClass = 'PSIK 24D';
  static const String studyProgram = 'Ilmu Komputer';
  static const String faculty =
      'Fakultas Matematika dan Ilmu Pengetahuan Alam (FMIPA)';
  static const String university = 'Universitas Negeri Medan';
  static const String courseName = 'Pemrograman Mobile (3KOM40215)';
  static const String lecturer = 'Adidtya Perdana, S.T., M.Kom.';

  // Daftar Kategori Wisata
  static const List<String> categories = [
    'Semua',
    'Alam',
    'Sejarah',
    'Pantai',
    'Religi',
  ];

  // Breakpoints Responsivitas (sesuai Modul Ajar dan spesifikasi tugas)
  // NavigationBar (< 840 dp) vs NavigationRail (>= 840 dp)
  static const double navigationBreakpoint = 840.0;

  // Detail screen breakpoint: vertical (< 700 dp) vs horizontal side-by-side (>= 700 dp)
  static const double detailBreakpoint = 700.0;

  // Grid Catalog columns breakpoints:
  // < 600 dp: 2 kolom
  // 600–899 dp: 3 kolom
  // >= 900 dp: 4 kolom
  static const double gridCompactBreakpoint = 600.0;
  static const double gridMediumBreakpoint = 900.0;
}
