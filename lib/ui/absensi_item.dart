import 'package:crud_app2_edit/ui/absensi_detail.dart';
import 'package:flutter/material.dart';
import '../model/absensi.dart';


class AbsensiItem extends StatelessWidget {
  final Absensi absensi;

  const AbsensiItem({super.key, required this.absensi});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Card(
          child: ListTile(
            title: Text("${absensi.namaKaryawan}"),
          ),
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AbsensiDetail(absensi: absensi)));
        });
  }
}
  