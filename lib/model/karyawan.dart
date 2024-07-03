class Karyawan{
  String? id;
  String namaKaryawan;
  String tanggal;
  String jammasuk;
  String jamkeluar;

  Karyawan({this.id, 
  required this.namaKaryawan, 
  required this.tanggal, 
  required this.jammasuk,
  required this.jamkeluar
  });
  factory Karyawan.fromJson(Map<String, dynamic> json) =>
    Karyawan(id: json["id"], 
    namaKaryawan: json["nama"], 
    tanggal: json["tanggal"], 
    jammasuk: json["jam_masuk"], 
    jamkeluar: json["jam_keluar"],
    );
  Map<String, dynamic> toJson() => {
    "nama": namaKaryawan,
    "tanggal": tanggal,
    "jam_masuk": jammasuk, 
    "jam_keluar": jamkeluar,
   }; 
}