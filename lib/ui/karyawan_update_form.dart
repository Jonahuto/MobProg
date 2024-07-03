import "package:crud_app2_edit/service/karyawan_service.dart";
import "package:flutter/material.dart";
import "../model/karyawan.dart";
import 'karyawan_detail.dart';

class KaryawanUpdateForm extends StatefulWidget {
  final Karyawan karyawan;

  const KaryawanUpdateForm({Key? key, required this.karyawan}) : super(key: key);
  _KaryawanUpdateFormState createState() => _KaryawanUpdateFormState();
}

class _KaryawanUpdateFormState extends State<KaryawanUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaCtrl = TextEditingController();
  final _tanggalCtrl = TextEditingController();
  final _jammasukCtrl = TextEditingController();
  final _jamkeluarCtrl = TextEditingController();

  Future<Karyawan> getData() async {
    Karyawan data = await KaryawanService().getById(widget.karyawan.id.toString());
    setState(() {
      _namaCtrl.text = data.namaKaryawan;
      _tanggalCtrl.text = data.tanggal;
      _jammasukCtrl.text = data.jammasuk;
      _jamkeluarCtrl.text = data.jamkeluar;
    });
    return data;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ubah Data")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: 
            [_fieldNama(),_fieldTanggal(),_fieldJam_masuk(),_fieldJam_keluar(),SizedBox(height: 20), _tombolSimpan()],
            
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
          Karyawan karyawan = new Karyawan(namaKaryawan: _namaCtrl.text,tanggal: _tanggalCtrl.text,jammasuk: _jammasukCtrl.text,jamkeluar: _jamkeluarCtrl.text);
          String id = widget.karyawan.id.toString();
          await KaryawanService().Ubah(karyawan, id).then((value) {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => KaryawanDetail(karyawan: value)));
          });
        },
        child: const Text("Simpan Perubahan"));
  }
}
