import 'package:flutter/material.dart';

import '../models/destination.dart';

/// Daftar data master destinasi wisata Sumatera Utara.
///
/// Menyediakan minimal 8 destinasi wajib sesuai spesifikasi tugas
/// dengan rincian lengkap atribut geografis, kategori, harga tiket, dan deskripsi.
const List<Destination> daftarDestinasi = [
  Destination(
    id: 1,
    nama: 'Danau Toba',
    kabupatenKota: 'Samosir / Toba',
    kategori: 'Alam',
    hargaTiket: 20000,
    deskripsi:
        'Danau vulkanik terbesar di dunia dan danau terbesar di Indonesia. '
        'Terbentuk dari letusan dahsyat gunung berapi sekitar 74.000 tahun lalu. '
        'Di tengahnya terdapat Pulau Samosir yang kaya akan budaya Batak tradisional, '
        'pemandangan perbukitan hijau, dan panorama perairan biru yang memukau.',
    ikon: Icons.waves,
    warna: Color(0xFF0277BD),
    gambar: 'assets/images/danau_toba.jpg',
    lokasi: 'Kabupaten Toba & Samosir, Sumatera Utara',
    rating: 4.9,
    jamOperasional: '24 Jam',
    fasilitas: [
      'Penyewaan Perahu',
      'Hotel & Resort',
      'Restoran Terapung',
      'Pusat Oleh-oleh',
    ],
  ),
  Destination(
    id: 2,
    nama: 'Bukit Lawang',
    kabupatenKota: 'Kabupaten Langkat',
    kategori: 'Alam',
    hargaTiket: 10000,
    deskripsi:
        'Pusat konservasi dan habitat alami orangutan Sumatera (Pongo abelii) di tepi '
        'Taman Nasional Gunung Leuser. Terkenal dengan aktivitas trekking hutan hujan tropis, '
        'arung jeram ban (river tubing) di Sungai Bahorok, serta suasana alam liar yang asri.',
    ikon: Icons.forest,
    warna: Color(0xFF2E7D32),
    gambar: 'assets/images/bukit_lawang.jpg',
    lokasi: 'Kecamatan Bahorok, Kabupaten Langkat, Sumatera Utara',
    rating: 4.8,
    jamOperasional: '07:00 - 17:00 WIB',
    fasilitas: [
      'Jasa Pemandu Hutan',
      'Jungle Lodge',
      'River Tubing',
      'Area Camping',
    ],
  ),
  Destination(
    id: 3,
    nama: 'Berastagi',
    kabupatenKota: 'Kabupaten Karo',
    kategori: 'Alam',
    hargaTiket: 0, // Gratis masuk kawasan
    deskripsi:
        'Kota dataran tinggi berhawa sejuk diapit oleh dua gunung api aktif: '
        'Gunung Sibayak dan Gunung Sinabung. Terkenal dengan pasar buah segar Berastagi, '
        'kebun stroberi petik sendiri, Bukit Gundaling, serta pemandian air panas alami Lau Sidebuk-debuk.',
    ikon: Icons.terrain,
    warna: Color(0xFF558B2F),
    gambar: 'assets/images/berastagi.jpg',
    lokasi: 'Dataran Tinggi Karo, Berastagi, Sumatera Utara',
    rating: 4.7,
    jamOperasional: '24 Jam (Pasar: 06:00 - 20:00 WIB)',
    fasilitas: [
      'Pasar Buah Segar',
      'Kuda Tunggang',
      'Penginapan Villa',
      'Pusat Kuliner',
    ],
  ),
  Destination(
    id: 4,
    nama: 'Istana Maimun',
    kabupatenKota: 'Kota Medan',
    kategori: 'Sejarah',
    hargaTiket: 10000,
    deskripsi:
        'Ikon sejarah Kota Medan peninggalan Kesultanan Deli yang didirikan pada tahun 1888 '
        'oleh Sultan Ma\'mun Al Rasyid Perkasa Alamsyah. Bangunan megah ini memadukan '
        'arsitektur Melayu, Timur Tengah, Spanyol, dan Italia dengan dominasi warna kuning khas bangsawan Melayu.',
    ikon: Icons.castle,
    warna: Color(0xFFF57F17),
    gambar: 'assets/images/istana_maimun.jpg',
    lokasi: 'Jl. Brigjend Katamso No. 66, Medan Maimun, Kota Medan',
    rating: 4.7,
    jamOperasional: '08:00 - 17:00 WIB',
    fasilitas: [
      'Penyewaan Baju Adat Melayu',
      'Museum Sejarah',
      'Pemandu Budaya',
      'Toko Cinderamata',
    ],
  ),
  Destination(
    id: 5,
    nama: 'Air Terjun Sipiso-piso',
    kabupatenKota: 'Kabupaten Karo',
    kategori: 'Alam',
    hargaTiket: 10000,
    deskripsi:
        'Salah satu air terjun tertinggi di Indonesia dengan ketinggian 120 meter. '
        'Air mengalir deras dari tebing curam dan bermuara langsung ke Danau Toba. '
        'Pengunjung disuguhkan gardu pandang dengan lanskap Danau Toba dan Pulau Samosir yang spektakuler.',
    ikon: Icons.water_drop,
    warna: Color(0xFF00838F),
    gambar: 'assets/images/sipiso_piso.jpg',
    lokasi: 'Desa Tongging, Merek, Kabupaten Karo, Sumatera Utara',
    rating: 4.8,
    jamOperasional: '08:00 - 18:00 WIB',
    fasilitas: [
      'Gardu Pandang',
      'Jalur Tangga Trekking',
      'Warung Wisata',
      'Area Parkir Luas',
    ],
  ),
  Destination(
    id: 6,
    nama: 'Pantai Pandan',
    kabupatenKota: 'Kabupaten Tapanuli Tengah',
    kategori: 'Pantai',
    hargaTiket: 10000,
    deskripsi:
        'Pantai berpasir putih lembut dengan air laut yang jernih dan deburan ombak tenang di pesisir barat Sumatera. '
        'Dikelilingi jajaran pohon kelapa rindang, pantai ini menjadi destinasi favorit menikmati matahari terbenam (sunset) '
        'serta aneka sajian hidangan laut khas pesisir Sibolga.',
    ikon: Icons.beach_access,
    warna: Color(0xFF00ACC1),
    gambar: 'assets/images/pantai_pandan.jpg',
    lokasi: 'Desa Pandan, Pandan, Kabupaten Tapanuli Tengah',
    rating: 4.6,
    jamOperasional: '06:00 - 20:00 WIB',
    fasilitas: [
      'Gazebo Tepi Pantai',
      'Penyewaan Banana Boat',
      'Rumah Makan Seafood',
      'Pusat Bilas',
    ],
  ),
  Destination(
    id: 7,
    nama: 'Tangkahan',
    kabupatenKota: 'Kabupaten Langkat',
    kategori: 'Alam',
    hargaTiket: 10000,
    deskripsi:
        'Dikenal sebagai "The Hidden Paradise of North Sumatra". Tangkahan menawarkan pengalaman unik '
        'memandikan gajah liar jinak di sungai berair jernih, menjelajahi gua kelelawar, air terjun air panas, '
        'serta jembatan gantung panjang di tengah kanopi hutan lebat Gunung Leuser.',
    ikon: Icons.eco,
    warna: Color(0xFF1B5E20),
    gambar: 'assets/images/tangkahan.jpg',
    lokasi: 'Namu Sialang, Batang Serangan, Kabupaten Langkat',
    rating: 4.9,
    jamOperasional: '08:00 - 17:00 WIB',
    fasilitas: [
      'Ekowisata Gajah',
      'Jembatan Gantung',
      'Eco Lodge',
      'River Trekking',
    ],
  ),
  Destination(
    id: 8,
    nama: 'Masjid Raya Al-Mashun',
    kabupatenKota: 'Kota Medan',
    kategori: 'Religi',
    hargaTiket: 0, // Gratis
    deskripsi:
        'Mahakarya arsitektur Islam bersejarah di Kota Medan yang dibangun pada tahun 1906. '
        'Bentuk bangunannya unik bersegi delapan (oktagonal) dengan perpaduan gaya Timur Tengah, '
        'India, dan Spanyol. Kubah hitam megah dan kaca patri artistik menjadi daya tarik religi dan sejarah.',
    ikon: Icons.mosque,
    warna: Color(0xFF4527A0),
    gambar: 'assets/images/masjid_raya.jpg',
    lokasi: 'Jl. Mahkamah No. 743, Mesjid, Kota Medan',
    rating: 4.9,
    jamOperasional: 'Setiap Waktu Sholat (04:30 - 21:00 WIB)',
    fasilitas: [
      'Ruang Sholat Luas',
      'Tempat Wudhu Nyaman',
      'Area Pelataran',
      'Perpustakaan Kitab',
    ],
  ),
];

/// Mencari destinasi berdasarkan ID (digunakan pada rute /detail/:id)
Destination? cariDestinasi(int id) {
  for (final destinasi in daftarDestinasi) {
    if (destinasi.id == id) return destinasi;
  }
  return null;
}

/// Mencari destinasi berdasarkan kategori (digunakan pada rute /kategori/:nama)
List<Destination> cariDestinasiByKategori(String kategori) {
  if (kategori.toLowerCase() == 'semua') {
    return daftarDestinasi;
  }
  return daftarDestinasi
      .where((d) => d.kategori.toLowerCase() == kategori.toLowerCase())
      .toList();
}

/// Memfilter destinasi berdasarkan teks pencarian dan pilihan kategori
List<Destination> filterDestinasi({String? query, String? kategori}) {
  return daftarDestinasi.where((d) {
    final matchesQuery =
        query == null ||
        query.isEmpty ||
        d.nama.toLowerCase().contains(query.toLowerCase()) ||
        d.kabupatenKota.toLowerCase().contains(query.toLowerCase()) ||
        d.deskripsi.toLowerCase().contains(query.toLowerCase());

    final matchesKategori =
        kategori == null ||
        kategori.isEmpty ||
        kategori.toLowerCase() == 'semua' ||
        d.kategori.toLowerCase() == kategori.toLowerCase();

    return matchesQuery && matchesKategori;
  }).toList();
}
