import 'package:flutter/material.dart';
import 'package:covid_banten_app/controllers/covid_controller.dart';
import 'package:covid_banten_app/models/covid_model.dart';
import 'package:covid_banten_app/views/edit_data_screen.dart';
import 'package:covid_banten_app/views/add_data_screen.dart';

class HomeScreen extends StatelessWidget {
  final CovidController _covidController = CovidController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Covid Banten', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<List<CovidData>>(
          stream: _covidController.getCovidData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Data tidak tersedia'));
            }

            var data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                var covidData = data[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    title: Text(
                      'Tanggal: ${covidData.tanggal}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Kasus Positif: ${covidData.totalKasus}'),
                        Text('Zona: ${covidData.zona}'),
                        Text('Kota: ${covidData.kota}'),
                        Text('Sembuh: ${covidData.sembuh}'),
                        Text('Meninggal: ${covidData.meninggal}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          tooltip: 'Edit Data',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        EditDataScreen(covidData: covidData),
                              ),
                            );
                          },
                        ),

                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          tooltip: 'Hapus Data',
                          onPressed: () {
                            _showDeleteDialog(context, covidData);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDataScreen()),
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
        tooltip: 'Tambah Data',
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, CovidData covidData) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus data ini?'),
          actions: [
            TextButton(
              onPressed: () async {
                await _covidController.deleteCovidData(covidData.documentId);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Data berhasil dihapus')),
                );
              },
              child: Text('Ya'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tidak'),
            ),
          ],
        );
      },
    );
  }
}
