// File: lib/laporan_page.dart
// Menu tambahan (kelengkapan fitur): Laporan & Rekap.
// Semua angka dihitung otomatis dari data dummy (nasabah, sampah, transaksi).
import 'package:flutter/material.dart';
import 'models.dart';

class LaporanPage extends StatelessWidget {
  const LaporanPage({super.key});

  final Color hijau = const Color(0xFF2E7D32);
  final Color hijauMuda = const Color(0xFF66BB6A);

  // Format angka ke rupiah: 1250000 -> Rp1.250.000
  String _rp(double nilai) {
    final s = nilai.round().toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return 'Rp$buf';
  }

  @override
  Widget build(BuildContext context) {
    // ===== Perhitungan =====
    double totalBerat = 0;
    double totalNilai = 0;
    for (final t in listTransaksi017) {
      totalBerat += t.beratKg017;
      totalNilai += t.totalHarga017;
    }
    double totalSaldo = 0;
    for (final n in listNasabah005) {
      totalSaldo += n.saldo005;
    }

    // Rekap per jenis sampah: nama -> [berat, nilai]
    final Map<String, List<double>> rekap = {};
    for (final t in listTransaksi017) {
      final nama = t.jenisSampah017.namaSampah029;
      rekap.putIfAbsent(nama, () => [0, 0]);
      rekap[nama]![0] += t.beratKg017;
      rekap[nama]![1] += t.totalHarga017;
    }
    final rekapList = rekap.entries.toList()..sort((a, b) => b.value[0].compareTo(a.value[0]));
    final beratMax = rekapList.isEmpty ? 1.0 : rekapList.first.value[0];

    // Peringkat nasabah berdasarkan saldo
    final peringkat = [...listNasabah005]..sort((a, b) => b.saldo005.compareTo(a.saldo005));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan & Rekap', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(decoration: BoxDecoration(gradient: LinearGradient(colors: [hijau, hijauMuda]))),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Ringkasan =====
            Row(children: [
              _stat('Total Setoran', '${totalBerat.toStringAsFixed(1)} kg', Icons.scale, Colors.blue),
              const SizedBox(width: 10),
              _stat('Nilai Transaksi', _rp(totalNilai), Icons.payments, Colors.orange),
            ]),
            const SizedBox(height: 10),
            Row(children: [
              _stat('Total Saldo Nasabah', _rp(totalSaldo), Icons.account_balance_wallet, Colors.green),
              const SizedBox(width: 10),
              _stat('Jumlah Transaksi', '${listTransaksi017.length}', Icons.receipt_long, Colors.purple),
            ]),
            const SizedBox(height: 20),

            // ===== Rekap per jenis sampah =====
            _judul('Rekap per Jenis Sampah', Icons.recycling),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: _kotak(),
              child: rekapList.isEmpty
                  ? const Text('Belum ada transaksi.')
                  : Column(
                      children: rekapList.map((e) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(e.key, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  Text('${e.value[0].toStringAsFixed(1)} kg • ${_rp(e.value[1])}', style: const TextStyle(fontSize: 12)),
                                ],
                              ),
                              const SizedBox(height: 4),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: LinearProgressIndicator(
                                  value: e.value[0] / beratMax,
                                  minHeight: 8,
                                  backgroundColor: const Color(0xFFE8F5E9),
                                  color: hijauMuda,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
            ),
            const SizedBox(height: 20),

            // ===== Peringkat nasabah =====
            _judul('Peringkat Saldo Nasabah', Icons.emoji_events),
            Container(
              decoration: _kotak(),
              child: peringkat.isEmpty
                  ? const Padding(padding: EdgeInsets.all(16), child: Text('Belum ada nasabah.'))
                  : Column(
                      children: List.generate(peringkat.length, (i) {
                        final n = peringkat[i];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: i == 0 ? Colors.amber[100] : const Color(0xFFE8F5E9),
                            child: Text('${i + 1}', style: TextStyle(fontWeight: FontWeight.bold, color: i == 0 ? Colors.amber[900] : hijau)),
                          ),
                          title: Text(n.nama005, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(n.alamat005),
                          trailing: Text(_rp(n.saldo005), style: TextStyle(color: hijau, fontWeight: FontWeight.bold)),
                        );
                      }),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _kotak() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 3))],
      );

  Widget _judul(String teks, IconData ikon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(children: [
        Icon(ikon, color: hijau),
        const SizedBox(width: 8),
        Text(teks, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: hijau)),
      ]),
    );
  }

  Widget _stat(String label, String nilai, IconData ikon, Color warna) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: _kotak(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(ikon, color: warna),
            const SizedBox(height: 8),
            Text(nilai, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
