// File: lib/about_page.dart
// Halaman About: informasi aplikasi, fitur, dan pembagian tugas tim.
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  final Color hijau = const Color(0xFF2E7D32);
  final Color hijauMuda = const Color(0xFF66BB6A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(decoration: BoxDecoration(gradient: LinearGradient(colors: [hijau, hijauMuda]))),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(radius: 44, backgroundColor: Colors.white, child: Icon(Icons.eco, size: 52, color: Color(0xFF2E7D32))),
            const SizedBox(height: 12),
            Text('Bank Sampah Lestari', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: hijau)),
            const Text('Versi 1.0.0', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),

            _kartu(
              judul: 'Deskripsi',
              ikon: Icons.description,
              isi: const Text(
                'Aplikasi pengelolaan Bank Sampah untuk mencatat data nasabah, '
                'jenis sampah beserta harga per kilogram, dan transaksi setoran sampah. '
                'Saldo nasabah bertambah otomatis setiap ada setoran.',
                style: TextStyle(height: 1.4),
              ),
            ),
            _kartu(
              judul: 'Fitur Aplikasi',
              ikon: Icons.checklist,
              isi: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _Fitur('Beranda dengan menu & ringkasan data'),
                  _Fitur('CRUD Data Nasabah'),
                  _Fitur('CRUD Jenis Sampah & harga per kg'),
                  _Fitur('CRUD Transaksi Setor (saldo otomatis)'),
                  _Fitur('Validasi form & ID unik'),
                  _Fitur('Eksplorasi data lewat bottom sheet'),
                  _Fitur('Laporan & rekap otomatis'),
                ],
              ),
            ),
            _kartu(
              judul: 'Tim Pengembang',
              ikon: Icons.groups,
              isi: Column(
                children: const [
                  _Anggota('Anif Nur Wahid', '2414010005', 'Fitur Nasabah (Form Nasabah005)'),
                  _Anggota('Adinda Yoga Dirgantara', '2414010029', 'Fitur Jenis Sampah (Form Sampah029)'),
                  _Anggota('Aby januarta Nurdianto', '2414010017', 'Fitur Transaksi Setor (Form Transaksi017)'),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text('Dibuat dengan Flutter • Tugas UTS Pemrograman Mobile', style: TextStyle(fontSize: 12, color: Colors.grey), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _kartu({required String judul, required IconData ikon, required Widget isi}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 3))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(ikon, color: hijau),
            const SizedBox(width: 8),
            Text(judul, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: hijau)),
          ]),
          const Divider(height: 20),
          isi,
        ],
      ),
    );
  }
}

class _Fitur extends StatelessWidget {
  final String teks;
  const _Fitur(this.teks);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(children: [
        const Icon(Icons.check_circle, size: 18, color: Color(0xFF66BB6A)),
        const SizedBox(width: 8),
        Expanded(child: Text(teks)),
      ]),
    );
  }
}

class _Anggota extends StatelessWidget {
  final String nama;
  final String nim;
  final String tugas;
  const _Anggota(this.nama, this.nim, this.tugas);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(backgroundColor: const Color(0xFFE8F5E9), child: Text(nim, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)))),
      title: Text(nama, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('NIM akhiran $nim\n$tugas'),
      isThreeLine: true,
    );
  }
}
