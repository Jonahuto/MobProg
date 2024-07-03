import 'package:flutter/material.dart';
import '../model/absensi.dart';
import '../service/absensi_service.dart';
import 'absensi_form.dart';
import '../widget/sidebar.dart';
import 'absensi_item.dart';

class halaman_absensi extends StatefulWidget {
  const halaman_absensi({super.key});
  @override
  _halaman_absensiState createState() => _halaman_absensiState();
}

class _halaman_absensiState extends State<halaman_absensi> {
  Stream<List<Absensi>> getList() async* {
    List<Absensi> data = await AbsensiService().listData();
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: const Text("Data Absensi"),
        actions: [
          GestureDetector(
            child: const Icon(Icons.add),
            onTap: () {
              Navigator.push(
                context, MaterialPageRoute(builder:(context) => const AbsensiForm()));
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: getList(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData &&
          snapshot.connectionState == ConnectionState.done) {
            return const Text('Data Kosong');
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index){
              return AbsensiItem(absensi: snapshot.data[index]);
            },
          );
        },
      ),
    );
  }
}
