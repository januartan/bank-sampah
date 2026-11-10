// File: lib/form_nasabah.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models.dart';

class FormNasabah005 extends StatefulWidget {
  final Nasabah005? nasabahToEdit;
  final int? editIndex;

  const FormNasabah005({super.key, this.nasabahToEdit, this.editIndex});

  @override
  State<FormNasabah005> createState() => _FormNasabah005State();
}

class _FormNasabah005State extends State<FormNasabah005> {
  final _formKey005 = GlobalKey<FormState>();
  final _idCtrl005 = TextEditingController();
  final _namaCtrl005 = TextEditingController();
  final _alamatCtrl005 = TextEditingController();
  String? _jenisKelamin005;

  bool get _isEditing005 => widget.nasabahToEdit != null && widget.editIndex != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing005) {
      _idCtrl005.text = widget.nasabahToEdit!.id005;
      _namaCtrl005.text = widget.nasabahToEdit!.nama005;
      _alamatCtrl005.text = widget.nasabahToEdit!.alamat005;
      _jenisKelamin005 = widget.nasabahToEdit!.jenisKelamin005;
    }
  }

  @override
  void dispose() {
    _idCtrl005.dispose();
    _namaCtrl005.dispose();
    _alamatCtrl005.dispose();
    super.dispose();
  }

  void _simpan005() {
    if (_formKey005.currentState!.validate()) {
      final idInput = _idCtrl005.text.trim();

      if (!_isEditing005) {
        bool idSudahAda = listNasabah005.any((n) => n.id005 == idInput);
        if (idSudahAda) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gagal: ID nasabah sudah digunakan!'), backgroundColor: Colors.red),
          );
          return;
        }
      }

      final nasabahData = Nasabah005(
        idInput,
        _namaCtrl005.text.trim(),
        _alamatCtrl005.text.trim(),
        _jenisKelamin005!,
      );

      if (_isEditing005) {
        nasabahData.saldo005 = widget.nasabahToEdit!.saldo005;
        listNasabah005[widget.editIndex!] = nasabahData;
      } else {
        listNasabah005.add(nasabahData);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_isEditing005 ? 'Data diperbarui!' : 'Data disimpan!'), backgroundColor: const Color(0xFF2E7D32)),
      );
      Navigator.pop(context, true);
    }
  }

  void _tampilEksplorasi005() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 400,
          child: Column(
            children: [
              Container(width: 50, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
              const SizedBox(height: 16),
              const Text('Eksplorasi Data Nasabah', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
              const Divider(),
              Expanded(
                child: listNasabah005.isEmpty
                    ? const Center(child: Text('Belum ada data nasabah'))
                    : ListView.builder(
                        itemCount: listNasabah005.length,
                        itemBuilder: (c, i) => ListTile(
                          leading: const CircleAvatar(backgroundColor: Color(0xFFE8F5E9), child: Icon(Icons.person, color: Color(0xFF2E7D32))),
                          title: Text(listNasabah005[i].nama005, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('ID: ${listNasabah005[i].id005} | Alamat: ${listNasabah005[i].alamat005}'),
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing005 ? 'Edit Data Nasabah' : 'Input Nasabah', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(icon: const Icon(Icons.travel_explore), tooltip: 'Eksplorasi Data', onPressed: _tampilEksplorasi005)
        ],
        flexibleSpace: Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)]))),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))]),
          child: Form(
            key: _formKey005,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _idCtrl005,
                  readOnly: _isEditing005,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: _buildInputDecoration005('ID Nasabah', Icons.badge, const Color(0xFF2E7D32)),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'ID tidak boleh kosong';
                    final nilai = int.tryParse(v.trim());
                    if (nilai == null || nilai <= 0) return 'ID harus berupa angka > 0';
                    
                    if (!_isEditing005) {
                      bool idSudahAda = listNasabah005.any((n) => n.id005 == v.trim());
                      if (idSudahAda) return 'ID nasabah sudah digunakan!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _namaCtrl005,
                  textCapitalization: TextCapitalization.words,
                  decoration: _buildInputDecoration005('Nama Lengkap', Icons.person, const Color(0xFF2E7D32)),
                  validator: (v) => v!.isEmpty ? 'Nama tidak boleh kosong' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _alamatCtrl005,
                  textCapitalization: TextCapitalization.words,
                  decoration: _buildInputDecoration005('Alamat', Icons.home, const Color(0xFF00897B)),
                  validator: (v) => v!.isEmpty ? 'Alamat tidak boleh kosong' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _jenisKelamin005,
                  decoration: _buildInputDecoration005('Jenis Kelamin', Icons.wc, const Color(0xFFE91E63)),
                  items: const [DropdownMenuItem(value: 'L', child: Text('Laki-laki')), DropdownMenuItem(value: 'P', child: Text('Perempuan'))],
                  onChanged: (val) => setState(() => _jenisKelamin005 = val),
                  validator: (v) => v == null ? 'Pilih salah satu' : null,
                ),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), gradient: const LinearGradient(colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)])),
                  child: ElevatedButton.icon(
                    onPressed: _simpan005,
                    icon: Icon(_isEditing005 ? Icons.update : Icons.send_rounded, color: Colors.white),
                    label: Text(_isEditing005 ? 'Perbarui Nasabah' : 'Simpan Nasabah', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, padding: const EdgeInsets.symmetric(vertical: 14)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration005(String label, IconData icon, Color iconColor) {
    return InputDecoration(labelText: label, prefixIcon: Icon(icon, color: iconColor), filled: true, fillColor: const Color(0xFFF1F8E9), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none));
  }
}