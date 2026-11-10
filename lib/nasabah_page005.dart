// File: lib/nasabah_page.dart
import 'package:flutter/material.dart';
import 'models.dart';
import 'form_nasabah005.dart';

class NasabahPage005 extends StatefulWidget {
  const NasabahPage005({super.key});

  @override
  State<NasabahPage005> createState() => _NasabahPage005State();
}

class _NasabahPage005State extends State<NasabahPage005> {
  void _konfirmasiHapus005(int index, String namaData) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Hapus Data'),
        content: Text('Hapus nasabah "$namaData"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal', style: TextStyle(color: Colors.grey))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red[700]),
            onPressed: () {
              setState(() => listNasabah005.removeAt(index));
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nasabah dihapus!'), backgroundColor: Colors.red));
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (listNasabah005.isEmpty) return const Center(child: Text('Belum ada data nasabah.'));
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: listNasabah005.length,
      itemBuilder: (context, index) {
        final n = listNasabah005[index];
        final isPria = n.jenisKelamin005 == 'L';
        final Color primaryColor = isPria ? Colors.blue[600]! : Colors.pink[400]!;

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(radius: 26, backgroundColor: isPria ? Colors.blue[50] : Colors.pink[50], child: Icon(isPria ? Icons.male : Icons.female, color: primaryColor, size: 28)),
            title: Text(n.nama005, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text('ID: ${n.id005} | Alamat: ${n.alamat005}', style: const TextStyle(fontSize: 12)),
                Text('Saldo: Rp${n.saldo005}', style: TextStyle(color: Colors.green[800], fontWeight: FontWeight.bold)),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.yellow,),
                  onPressed: () async {
                    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => FormNasabah005(nasabahToEdit: n, editIndex: index)));
                    if (result == true) setState(() {});
                  },
                ),
                IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red), onPressed: () => _konfirmasiHapus005(index, n.nama005)),
              ],
            ),
          ),
        );
      },
    );
  }
}