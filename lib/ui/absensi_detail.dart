import 'package:crud_app2_edit/service/absensi_service.dart';
import 'package:flutter/material.dart';
import '../model/absensi.dart';
import 'absensi_update_form.dart';
import 'halaman_absensi.dart';
import 'package:intl/intl.dart';

class AbsensiDetail extends StatefulWidget {
  final Absensi absensi;

  const AbsensiDetail({Key? key, required this.absensi}) : super(key: key);
  State<AbsensiDetail> createState() => _AbsensiDetailState();
}

class _AbsensiDetailState extends State<AbsensiDetail> {
  
  
  Stream<Absensi> getData() async* {
    Absensi data = await AbsensiService().getById(widget.absensi.id.toString());
    yield data;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Absensi")),
      body: StreamBuilder(
        stream: getData(),
        
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return Text('Data Tidak Ditemukan');
          }
          return Column(
            children: [
              
              SizedBox(height: 20),
              Text(
                "Nama Lengkap : ${snapshot.data.namaKaryawan}",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Text(
                "Tanggal : ${snapshot.data.tanggal}",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Text(
                "Jam Masuk : ${snapshot.data.jammasuk}",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Text(
                "Jam Keluar : ${snapshot.data.jamkeluar}",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                //_tombolUbah(),
                //_tombolhome(), 
                _tombolKeluar(),
                //_tombolHapus()
                ],
              )
            ],
          );
          
        },
      ),
    );
  }

  // _tombolUbah() {
  //   return StreamBuilder(
  //       stream: getData(),
  //       builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
  //           onPressed: () {
  //             Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) =>
  //                         AbsensiUpdateForm(absensi: snapshot.data)));
  //           },
  //           style: ElevatedButton.styleFrom(backgroundColor: Colors.green, ),
  //           child: const Text("Ubah",style: TextStyle(color: Colors.white),)));
  // }
   _tombolKeluar() {
  DateTime now = DateTime.now();
  String formattedTime = DateFormat('kk:mm:ss').format(now);
    
      return ElevatedButton(
        onPressed: () async {
          getData();
          Absensi data = await AbsensiService().getById(widget.absensi.id.toString());
          Absensi absensi = new Absensi(namaKaryawan: data.namaKaryawan,tanggal: data.tanggal,jammasuk: data.jammasuk,jamkeluar: formattedTime);
          String id = widget.absensi.id.toString();
          await AbsensiService().Ubah(absensi, id).then((value) {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => AbsensiDetail(absensi: value)));
          });
        },
        child: const Text("Absen Keluar"));
  }
  // _tombolhome(){
  //   return ElevatedButton(
  //     onPressed: () {
  //       Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => halaman_karyawan()));
  //     },
  //     style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
  //     child: const Text("Kembali",style: TextStyle(color: Colors.black),),
  //   );
  
  // }

  // _tombolHapus() {
  //   return ElevatedButton(
  //       onPressed: () {
  //         AlertDialog alertDialog = AlertDialog(
  //           content: const Text("Yakin ingin menghapus data ini?"),
  //           actions: [
  //             StreamBuilder(
  //                 stream: getData(),
  //                 builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
  //                       onPressed: () async {
  //                         await AbsensiService()
  //                             .hapus(snapshot.data)
  //                             .then((value) {
  //                           Navigator.pop(context);
  //                           Navigator.pushReplacement(
  //                               context,
  //                               MaterialPageRoute(
  //                                   builder: (context) => halaman_absensi()));
  //                         });
  //                       },
  //                       child: const Text("YA",style: TextStyle(color: Colors.white),),
  //                       style: ElevatedButton.styleFrom(
  //                           backgroundColor: Colors.red),
  //                     )),
  //             ElevatedButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: const Text("Tidak",style: TextStyle(color: Colors.white),),
  //               style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
  //             )
  //           ],
  //         );
  //         showDialog(context: context, builder: (context) => alertDialog);
  //       },
  //       style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
  //       child: const Text("Hapus",style: TextStyle(color: Colors.white),));
  // }
}
