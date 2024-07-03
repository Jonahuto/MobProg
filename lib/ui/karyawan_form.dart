import 'package:crud_app2_edit/service/karyawan_service.dart';
import 'package:flutter/material.dart';
import 'karyawan_detail.dart';
import '../model/karyawan.dart';

class KaryawanForm extends StatefulWidget {
  const KaryawanForm({Key? key}) : super(key: key);
  _KaryawanFormState createState() => _KaryawanFormState();
  }

class _KaryawanFormState extends State<KaryawanForm> {
  
  final _formKey = GlobalKey<FormState>();
  final _namaCtrl = TextEditingController();
  final _tanggalCtrl = TextEditingController();
  final _jammasukCtrl = TextEditingController();
  final _jamkeluarCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Karyawan")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [_fieldNama(),_fieldTanggal(),_fieldJam_masuk(),_fieldJam_keluar(), SizedBox(height: 20), _tombolSimpan()],
          ),
        ),
      ),
    );
  }
  _fieldNama() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nama Karyawan"),
      controller: _namaCtrl,
    );
  }
  _fieldTanggal() {
    return TextField(
      decoration: const InputDecoration(labelText: "Tanggal"),
      controller: _tanggalCtrl,
    );
  }
  _fieldJam_masuk() {
    return TextField(
      decoration: const InputDecoration(labelText: "Jam Masuk"),
      controller: _jammasukCtrl,
    );
  }
  _fieldJam_keluar() {
    return TextField(
      decoration: const InputDecoration(labelText: "Jam Keluar"),
      controller: _jamkeluarCtrl,
    );
  }

     _tombolSimpan() {
      return ElevatedButton(
        onPressed: () async {
          Karyawan karyawan = new Karyawan(namaKaryawan: _namaCtrl.text,tanggal: _tanggalCtrl.text, jammasuk: _jammasukCtrl.text, jamkeluar: _jamkeluarCtrl.text);
          await KaryawanService().Simpan(karyawan).then((value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => KaryawanDetail(karyawan: value)));
                });
                },
                child: const Text("Simpan"));



}
  
}