// File: lib/transaksi_page.dart
import 'package:flutter/material.dart';
import 'models.dart';
import 'form_transaksi017.dart';

class TransaksiPage017 extends StatefulWidget {
  const TransaksiPage017({super.key});

  @override
  State<TransaksiPage017> createState() => _TransaksiPage017State();
}

class _TransaksiPage017State extends State<TransaksiPage017> {
  void _hapusTransaksi017(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Transaksi'),
        content: const Text('Yakin ingin menghapus transaksi ini? Saldo nasabah akan disesuaikan kembali.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                listTransaksi017[index].nasabah017.saldo005 -= listTransaksi017[index].totalHarga017;
                listTransaksi017.removeAt(index);
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Transaksi dihapus!')),
              );
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (listTransaksi017.isEmpty) {
      return const Center(child: Text('Belum ada transaksi.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: listTransaksi017.length,
      itemBuilder: (context, index) {
        final t = listTransaksi017[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.receipt_long, color: Color.fromARGB(255, 255, 34, 34), size: 28),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('TRX: ${t.id017}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(t.nasabah017.nama005),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Text('Jenis Sampah: ${t.jenisSampah017.namaSampah029}'),
                Text('Berat: ${t.beratKg017} kg'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '+ Rp${t.totalHarga017}',
                        style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FormTransaksi017(transaksiToEdit: t, editIndex: index),
                          ),
                        );
                        if (!mounted) return;
                        if (result == true) setState(() {});
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => _hapusTransaksi017(index),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
