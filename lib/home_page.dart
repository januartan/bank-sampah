// File: lib/home_page.dart
// Halaman kelola data (CRUD) dengan bottom navigation: Nasabah | Sampah | Transaksi.
// Dibuka dari BerandaPage dengan tab awal sesuai menu yang dipilih.
import 'package:flutter/material.dart';
import 'nasabah_page005.dart';
import 'sampah_page029.dart';
import 'transaksi_page017.dart';
import 'form_nasabah005.dart';
import 'form_sampah029.dart';
import 'form_transaksi017.dart';

class HomePage extends StatefulWidget {
  final int initialIndex;
  const HomePage({super.key, this.initialIndex = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _currentIndex;
  int _refreshKey = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Sampah Lestari', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: _currentIndex == 0
    ? NasabahPage005(key: ValueKey('nasabah_$_refreshKey'))
    : _currentIndex == 1
        ? SampahPage029(key: ValueKey('sampah_$_refreshKey'))
        : TransaksiPage017(key: ValueKey('transaksi_$_refreshKey')),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2)],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Colors.green[700],
          unselectedItemColor: Colors.grey[500],
          backgroundColor: Colors.white,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.people_alt), label: 'Nasabah'),
            BottomNavigationBarItem(icon: Icon(Icons.eco), label: 'Sampah'),
            BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Transaksi'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green[700],
        onPressed: () async {
          Widget targetPage;
          if (_currentIndex == 0) {
            targetPage = const FormNasabah005();
          } else if (_currentIndex == 1) {
            targetPage = const FormSampah029();
          } else {
            targetPage = const FormTransaksi017();
          }

          // Navigasi ke form dan tunggu hasilnya
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetPage),
          );

          // Jika form mengembalikan 'true' (berhasil simpan), refresh halaman
          if (result == true && mounted) {
            setState(() {
              _refreshKey++;
            });
          }
        },
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          _currentIndex == 0 ? 'Nasabah' : _currentIndex == 1 ? 'Sampah' : 'Transaksi',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
