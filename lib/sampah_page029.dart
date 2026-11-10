
import 'package:flutter/material.dart';
import 'models.dart';
import 'form_sampah029.dart';

class SampahPage029 extends StatefulWidget {
  const SampahPage029({super.key});

  @override
  State<SampahPage029> createState() => _SampahPage029State();
}

class _SampahPage029State extends State<SampahPage029> {
  String _cariSampah029 = '';

  void _konfirmasiHapus029(int index, String namaData) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Hapus Data'),
        content: Text('Hapus sampah "$namaData"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red[700]),
            onPressed: () {
              setState(() => listSampah029.removeAt(index));
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sampah dihapus!'), backgroundColor: Colors.red),
              );
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  

  @override
  
  Widget build(BuildContext context) {
    final hasilCari029 = listSampah029.where((s) {
      return s.namaSampah029.toLowerCase().contains(_cariSampah029.toLowerCase());
    }).toList();

    if (listSampah029.isEmpty) {
      return const Center(child: Text('Belum ada data sampah.'));
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Cari nama sampah...',
              prefixIcon: const Icon(Icons.search, color: Color.fromARGB(255, 41, 7, 135)),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: Colors.green[50],
            ),
            onChanged: (value) {
              setState(() => _cariSampah029 = value);
            },
          ),
        ),

        // Struktur ListView.builder tetap dipertahankan
        Expanded(
          child: hasilCari029.isEmpty
              ? const Center(child: Text('Sampah tidak ditemukan.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: hasilCari029.length,
                  itemBuilder: (context, index) {
                    final s = hasilCari029[index];

                    final indexAsli029 = listSampah029.indexOf(s);

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        leading: CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.green[100],
                          child: Icon(Icons.recycling, color: Colors.green[800], size: 28),
                        ),
                        title: Text(s.namaSampah029, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('ID: ${s.id029} | ${s.kategori029}\nHarga: Rp${s.hargaPerKg029}/kg'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FormSampah029(sampahToEdit: s, editIndex: indexAsli029),
                                  ),
                                );
                                if (result == true) setState(() {});
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline, color: Colors.red),
                              onPressed: () => _konfirmasiHapus029(indexAsli029, s.namaSampah029),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
