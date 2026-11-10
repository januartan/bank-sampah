// File: lib/beranda_page.dart
// Halaman Beranda: halaman pertama yang tampil, berisi menu menuju fitur lain.
import 'package:flutter/material.dart';
import 'models.dart';
import 'home_page.dart';
import 'laporan_page.dart';
import 'about_page.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  final Color hijau = const Color(0xFF2E7D32);
  final Color hijauMuda = const Color(0xFF66BB6A);

  // Buka halaman tujuan, lalu refresh ringkasan saat kembali ke beranda
  Future<void> _buka(Widget halaman) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => halaman));
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final menu = [
      _MenuItem('Data Nasabah', 'Kelola data nasabah', Icons.people_alt, Colors.blue, () => _buka(const HomePage(initialIndex: 0))),
      _MenuItem('Jenis Sampah', 'Katalog & harga/kg', Icons.recycling, Colors.green, () => _buka(const HomePage(initialIndex: 1))),
      _MenuItem('Transaksi Setor', 'Riwayat setoran', Icons.receipt_long, Colors.orange, () => _buka(const HomePage(initialIndex: 2))),
      _MenuItem('Laporan & Rekap', 'Statistik & peringkat', Icons.bar_chart, Colors.teal, () => _buka(const LaporanPage())),
      _MenuItem('Tentang', 'Info aplikasi & tim', Icons.info_outline, Colors.purple, () => _buka(const AboutPage())),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ===== Header =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [hijau, hijauMuda], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(radius: 28, backgroundColor: Colors.white, child: Icon(Icons.eco, size: 34, color: Color(0xFF2E7D32))),
                  const SizedBox(height: 16),
                  const Text('Selamat Datang di', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  const Text('Bank Sampah Lestari', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text('Kelola nasabah, jenis sampah, dan setoran dengan mudah.', style: TextStyle(color: Colors.white70, fontSize: 13)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ===== Ringkasan data =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _ringkasan('Nasabah', listNasabah005.length, Icons.people_alt, Colors.blue),
                  const SizedBox(width: 10),
                  _ringkasan('Sampah', listSampah029.length, Icons.recycling, Colors.green),
                  const SizedBox(width: 10),
                  _ringkasan('Transaksi', listTransaksi017.length, Icons.receipt_long, Colors.orange),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ===== Menu =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Menu Utama', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: hijau)),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: menu.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              mainAxisExtent: 180,
            ),
              itemBuilder: (context, i) => _kartuMenu(menu[i]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ringkasan(String label, int jumlah, IconData icon, Color warna) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 3))]),
        child: Column(
          children: [
            Icon(icon, color: warna),
            const SizedBox(height: 4),
            Text('$jumlah', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _kartuMenu(_MenuItem m) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      elevation: 3,
      shadowColor: Colors.black26,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: m.onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(radius: 28, backgroundColor: m.warna.withValues(alpha: 0.12), child: Icon(m.ikon, size: 30, color: m.warna)),
              const SizedBox(height: 12),
              Text(m.judul, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 4),
              Text(m.deskripsi, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuItem {
  final String judul;
  final String deskripsi;
  final IconData ikon;
  final Color warna;
  final VoidCallback onTap;
  _MenuItem(this.judul, this.deskripsi, this.ikon, this.warna, this.onTap);
}
