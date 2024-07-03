import 'package:crud_app2_edit/service/absensi_service.dart';
import 'package:flutter/material.dart';
import 'absensi_detail.dart';
import '../model/absensi.dart';
import 'package:intl/intl.dart';

class AbsensiForm extends StatefulWidget {
  const AbsensiForm({Key? key}) : super(key: key);
  _AbsensiFormState createState() => _AbsensiFormState();
  }

class _AbsensiFormState extends State<AbsensiForm> {
  
  
  final _formKey = GlobalKey<FormState>();
  final _namaCtrl = TextEditingController();


  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Absensi")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [_fieldNama(),SizedBox(height: 20), _tombolSimpan()],
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


     _tombolSimpan() {
      DateTime now = DateTime.now();
    String formattedTime = DateFormat('kk:mm:ss').format(now);
    String formattedDate = DateFormat('d MMMM y').format(now);
      return ElevatedButton(
        onPressed: () async {
          Absensi absensi = new Absensi(namaKaryawan: _namaCtrl.text,tanggal: formattedDate, jammasuk: formattedTime, jamkeluar: "0");
          await AbsensiService().Simpan(absensi).then((value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AbsensiDetail(absensi: value)));
                });
                },
                child: const Text("Simpan"));



}
  
}