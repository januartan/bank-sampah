// File: lib/models.dart
// Pembagian tanggung jawab (akhiran = 3 digit NIM):
//   005 -> Nasabah        029 -> Jenis Sampah        017 -> Transaksi Setor

abstract class BaseEntity {
  String id;
  DateTime tanggalDibuat;

  BaseEntity(this.id, this.tanggalDibuat);
}

// ==================== NIM 005 : NASABAH ====================
class Nasabah005 extends BaseEntity {
  String nama005;
  String alamat005;
  String jenisKelamin005;
  double saldo005;

  Nasabah005(String id, this.nama005, this.alamat005, this.jenisKelamin005, {this.saldo005 = 0.0})
      : super(id, DateTime.now());

  String get id005 => id;
}

// ==================== NIM 029 : JENIS SAMPAH ====================
class JenisSampah029 extends BaseEntity {
  String namaSampah029;
  String kategori029;
  double hargaPerKg029;

  JenisSampah029(String id, this.namaSampah029, this.kategori029, this.hargaPerKg029)
      : super(id, DateTime.now());

  String get id029 => id;
}

// ==================== NIM 017 : TRANSAKSI SETOR ====================
class TransaksiSetor017 extends BaseEntity {
  Nasabah005 nasabah017;
  JenisSampah029 jenisSampah017;
  double beratKg017;
  double totalHarga017;

  TransaksiSetor017(String id, this.nasabah017, this.jenisSampah017, this.beratKg017)
      : totalHarga017 = beratKg017 * jenisSampah017.hargaPerKg029,
        super(id, DateTime.now()) {
    nasabah017.saldo005 += totalHarga017;
  }

  String get id017 => id;
}

// ==========================================
// DATA DUMMY GLOBAL
// ==========================================
List<Nasabah005> listNasabah005 = [
  Nasabah005('1', 'Budi Santoso', 'Surakarta', 'L', saldo005: 50000),
  Nasabah005('2', 'Siti Aminah', 'Sukoharjo', 'P', saldo005: 25000),
];

List<JenisSampah029> listSampah029 = [
  JenisSampah029('1', 'Botol Plastik', 'Anorganik', 3000),
  JenisSampah029('2', 'Kardus Bekas', 'Anorganik', 2000),
  JenisSampah029('3', 'Daun / Organik', 'Organik', 1000),
];

List<TransaksiSetor017> listTransaksi017 = [
  TransaksiSetor017('1', listNasabah005[0], listSampah029[0], 5.0), // Budi - Botol Plastik
  TransaksiSetor017('2', listNasabah005[1], listSampah029[1], 10.0), // Siti - Kardus
];
