// File: lib/form_sampah.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models.dart';

class FormSampah029 extends StatefulWidget {
  final JenisSampah029? sampahToEdit;
  final int? editIndex;

  const FormSampah029({super.key, this.sampahToEdit, this.editIndex});

  @override
  State<FormSampah029> createState() => _FormSampah029State();
}

class _FormSampah029State extends State<FormSampah029> {
  final _formKey029 = GlobalKey<FormState>();
  final _idCtrl029 = TextEditingController();
  final _namaCtrl029 = TextEditingController();
  final _hargaCtrl029 = TextEditingController();
  String _kategori029 = 'Organik';

  bool get _isEditing029 => widget.sampahToEdit != null && widget.editIndex != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing029) {
      _idCtrl029.text = widget.sampahToEdit!.id029;
      _namaCtrl029.text = widget.sampahToEdit!.namaSampah029;
      _kategori029 = widget.sampahToEdit!.kategori029;
      _hargaCtrl029.text = widget.sampahToEdit!.hargaPerKg029.toStringAsFixed(0);
    }
  }

  @override
  void dispose() {
    _idCtrl029.dispose();
    _namaCtrl029.dispose();
    _hargaCtrl029.dispose();
    super.dispose();
  }

  void _simpan029() {
    if (_formKey029.currentState!.validate()) {
      final idInput = _idCtrl029.text.trim();

      if (!_isEditing029) {
        bool idSudahAda = listSampah029.any((s) => s.id029 == idInput);
        if (idSudahAda) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gagal: ID sampah sudah digunakan!'), backgroundColor: Colors.red),
          );
          return;
        }
      }

      final dataBaru = JenisSampah029(
        idInput,
        _namaCtrl029.text.trim(),
        _kategori029,
        double.tryParse(_hargaCtrl029.text.trim()) ?? 0.0,
      );

      if (_isEditing029) {
        listSampah029[widget.editIndex!] = dataBaru;
      } else {
        listSampah029.add(dataBaru);
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_isEditing029 ? 'Data sampah diperbarui!' : 'Data sampah disimpan!'), backgroundColor: const Color(0xFF2E7D32)),
      );
      Navigator.pop(context, true);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing029 ? 'Edit Sampah' : 'Tambah Sampah', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)]))),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))]),
          child: Form(
            key: _formKey029,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _idCtrl029,
                  readOnly: _isEditing029,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: _dekorasi029('ID Sampah', Icons.qr_code),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'ID wajib diisi';
                    final nilai = int.tryParse(v.trim());
                    if (nilai == null || nilai <= 0) return 'ID harus berupa angka > 0';
                    
                    if (!_isEditing029) {
                      bool idSudahAda = listSampah029.any((s) => s.id029 == v.trim());
                      if (idSudahAda) return 'ID sampah sudah digunakan!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _namaCtrl029,
                  textCapitalization: TextCapitalization.words,
                  decoration: _dekorasi029('Nama Sampah', Icons.recycling),
                  validator: (v) => v!.isEmpty ? 'Nama tidak boleh kosong' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _kategori029,
                  decoration: _dekorasi029('Kategori', Icons.category),
                  items: const [DropdownMenuItem(value: 'Organik', child: Text('Organik')), DropdownMenuItem(value: 'Anorganik', child: Text('Anorganik'))],
                  onChanged: (val) => setState(() => _kategori029 = val!),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _hargaCtrl029,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: _dekorasi029('Harga per Kg (Rp)', Icons.attach_money),
                  validator: (v) => v!.isEmpty ? 'Harga tidak boleh kosong' : null,
                ),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), gradient: const LinearGradient(colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)])),
                  child: ElevatedButton.icon(
                    onPressed: _simpan029,
                    icon: Icon(_isEditing029 ? Icons.update : Icons.save, color: Colors.white),
                    label: Text(_isEditing029 ? 'Perbarui' : 'Simpan', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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

  InputDecoration _dekorasi029(String label, IconData icon) {
    return InputDecoration(labelText: label, prefixIcon: Icon(icon, color: const Color(0xFF2E7D32)), filled: true, fillColor: const Color(0xFFF1F8E9), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none));
  }
}