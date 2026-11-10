import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; //untuk impor fitur tambahan

import 'models.dart';

class FormTransaksi017 extends StatefulWidget { //untuk membuat form mengikuti perubahan data
  final TransaksiSetor017? transaksiToEdit; //untuk mengambil data lama
  final int? editIndex; //data lama disimpan pada list agar dapat di perbarui

  const FormTransaksi017({super.key, this.transaksiToEdit, this.editIndex});

  @override
  State<FormTransaksi017> createState() => _FormTransaksi017State();
} //menghubungkan StatefulWidget dengan State atau tempat mengatur perubahan data dan tampilan halaman

class _FormTransaksi017State extends State<FormTransaksi017> { //menyimpan variabel, fungsi, logika, dan mengatur perubahan tampilan form
  final _formKey017 = GlobalKey<FormState>();
  final _idCtrl017 = TextEditingController();
  final _beratCtrl017 = TextEditingController();

  Nasabah005? _nasabah017; //variable
  JenisSampah029? _sampah017;
  double _total017 = 0;

  bool get _isEditing017 => //type data yang punya 2 hasil 
      widget.transaksiToEdit != null && widget.editIndex != null;

//mengisi form secara otomatis dengan data transaksi lama ketika pengguna ingin mengedit transaksi.
  @override
  void initState() {
    super.initState();
    if (_isEditing017) {
      final transaksi = widget.transaksiToEdit!;
      _idCtrl017.text = transaksi.id017;
      _beratCtrl017.text = transaksi.beratKg017.toString();
      _nasabah017 = transaksi.nasabah017;
      _sampah017 = transaksi.jenisSampah017;
      _total017 = transaksi.totalHarga017;
    }
  }

  //delete membersihkan controller
  @override
  void dispose() {
    _idCtrl017.dispose();
    _beratCtrl017.dispose();
    super.dispose();
  }

  double get _berat017 => //mengambil berat sampah
      double.tryParse(_beratCtrl017.text.trim().replaceAll(',', '.')) ?? 0;

  void _hitungTotal017() {
    setState(() {
      _total017 = _sampah017 == null
          ? 0
          : _berat017 * _sampah017!.hargaPerKg029;
    });
  }

  //validasi
  void simpan017() {
    if (!_formKey017.currentState!.validate() ||
        _nasabah017 == null ||
        _sampah017 == null)
      return;

    final id = _idCtrl017.text.trim(); //untuk menyimpan inputan
    final berat = _berat017;

    if (_isEditing017) {
      final transaksiLama = widget.transaksiToEdit!;
      transaksiLama.nasabah017.saldo005 -= transaksiLama.totalHarga017; //saldo nasabah saat ini dikurangi total harga transaksi lama.
      listTransaksi017[widget.editIndex!] = TransaksiSetor017(
        id,
        _nasabah017!,
        _sampah017!,
        berat,
      );
    } else {
      listTransaksi017.add(
        TransaksiSetor017(id, _nasabah017!, _sampah017!, berat),
      );
    }

    //notif / pesan
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isEditing017 ? 'Transaksi diperbarui!' : 'Transaksi disimpan!',
        ),
      ),
    );
    Navigator.pop(context, true);
  }

  //kode di bawah bagian untuk menampilkan riwayat dan form
  void _tampilRiwayat017() {
    if (_nasabah017 == null) return;

    final riwayat = listTransaksi017
        .where((t) => t.nasabah017.id005 == _nasabah017!.id005)
        .toList();

    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 350,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Riwayat ${_nasabah017!.nama005} | Saldo: Rp${_nasabah017!.saldo005}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              child: riwayat.isEmpty
                  ? const Center(child: Text('Belum ada riwayat transaksi'))
                  : ListView.builder(
                      itemCount: riwayat.length,
                      itemBuilder: (context, index) {
                        final transaksi = riwayat[index];
                        return ListTile(
                          title: Text(transaksi.jenisSampah017.namaSampah029),
                          subtitle: Text('${transaksi.beratKg017} kg'),
                          trailing: Text('Rp${transaksi.totalHarga017}'),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  String? _validasiId017(String? value) {
    if (value == null || value.trim().isEmpty) return 'ID wajib diisi';
    final id = int.tryParse(value.trim());
    if (id == null || id <= 0) return 'ID harus angka lebih dari 0';

    if (!_isEditing017 &&
        listTransaksi017.any((t) => t.id017 == value.trim())) {
      return 'ID transaksi sudah digunakan';
    }
    return null;
  }

  InputDecoration _dekorasi017(String label) =>
      InputDecoration(labelText: label, border: const OutlineInputBorder());

  @override
  Widget build(BuildContext context) {
    if (listNasabah005.isEmpty || listSampah029.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Transaksi')),
        body: const Center(
          child: Text('Data nasabah atau sampah masih kosong!'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing017 ? 'Edit Transaksi' : 'Tambah Transaksi'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey017,
          child: Column(
            children: [
              TextFormField(
                controller: _idCtrl017,
                readOnly: _isEditing017,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly], 
                decoration: _dekorasi017('ID Transaksi'),
                validator: _validasiId017,
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<Nasabah005>(
                initialValue: _nasabah017,
                decoration: _dekorasi017('Pilih Nasabah'),
                items: listNasabah005
                    .map(
                      (n) => DropdownMenuItem(value: n, child: Text(n.nama005)),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _nasabah017 = value),
                validator: (value) => value == null ? 'Pilih nasabah' : null,
              ),
              if (_nasabah017 != null)
                TextButton.icon(
                  onPressed: _tampilRiwayat017,
                  icon: const Icon(Icons.history),
                  label: const Text('Lihat Riwayat Nasabah'),
                ),
              const SizedBox(height: 14),
              DropdownButtonFormField<JenisSampah029>(
                initialValue: _sampah017,
                decoration: _dekorasi017('Pilih Jenis Sampah'),
                items: listSampah029
                    .map(
                      (s) => DropdownMenuItem(
                        value: s,
                        child: Text(
                          '${s.namaSampah029} - Rp${s.hargaPerKg029}/kg',
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() => _sampah017 = value);
                  _hitungTotal017();
                },
                validator: (value) =>
                    value == null ? 'Pilih jenis sampah' : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _beratCtrl017,
                decoration: _dekorasi017('Berat (Kg)'),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onChanged: (_) => _hitungTotal017(),
                validator: (value) =>
                    _berat017 <= 0 ? 'Berat harus lebih dari 0' : null,
              ),
              const SizedBox(height: 18),
              Text(
                'Estimasi Total: Rp$_total017',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: simpan017,
                  child: Text(
                    _isEditing017 ? 'Perbarui Transaksi' : 'Simpan Transaksi',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
