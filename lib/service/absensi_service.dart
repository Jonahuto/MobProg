import '../model/absensi.dart';
import '../helpers/api_client.dart';

class AbsensiService {
  Future<List<Absensi>> listData() async {
    final response = await ApiClient().get('absensi');
    final List data = response.data as List;
    List<Absensi> result = data.map((json) => Absensi.fromJson(json)).toList();
    return result;
  }

  Future<Absensi> Simpan(Absensi absensi) async {
    var data = absensi.toJson();
    final response = await ApiClient().post('absensi', data);
    Absensi result = Absensi.fromJson(response.data);
    return result;
  }

  Future<Absensi> Ubah(Absensi absensi, String id) async{
    var data = absensi.toJson();
    final response = await ApiClient().put('absensi/${id}', data);
    print(response);
    Absensi result = Absensi.fromJson(response.data);
    return result;
  }

  Future<Absensi> getById(String id) async {
    final response = await ApiClient().get('absensi/${id}');
    Absensi result = Absensi.fromJson(response.data);
    return result;
  }

  Future<Absensi> hapus(Absensi absensi) async {
    final response = await ApiClient().delete('absensi/${absensi.id}');
    Absensi result = Absensi.fromJson(response.data);
    return result;
  }
}   
