import 'package:flutter/material.dart';
import 'package:covid_banten_app/controllers/covid_controller.dart';
import 'package:covid_banten_app/models/covid_model.dart';

class EditDataScreen extends StatefulWidget {
  final CovidData covidData;

  EditDataScreen({required this.covidData});

  @override
  _EditDataScreenState createState() => _EditDataScreenState();
}

class _EditDataScreenState extends State<EditDataScreen> {
  final _formKey = GlobalKey<FormState>();
  final CovidController _covidController = CovidController();

  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController totalKasusController = TextEditingController();
  final TextEditingController sembuhController = TextEditingController();
  final TextEditingController meninggalController = TextEditingController();
  final TextEditingController kotaController = TextEditingController();
  final TextEditingController zonaController = TextEditingController();

  @override
  void initState() {
    super.initState();

    tanggalController.text = widget.covidData.tanggal;
    totalKasusController.text = widget.covidData.totalKasus.toString();
    sembuhController.text = widget.covidData.sembuh.toString();
    meninggalController.text = widget.covidData.meninggal.toString();
    kotaController.text = widget.covidData.kota;
    zonaController.text = widget.covidData.zona;
    namaController.text = widget.covidData.nama;
  }

  void _updateData() {
    if (_formKey.currentState!.validate()) {
      final updatedData = CovidData(
        tanggal: tanggalController.text,
        totalKasus: int.parse(totalKasusController.text),
        sembuh: int.parse(sembuhController.text),
        meninggal: int.parse(meninggalController.text),
        kota: kotaController.text,
        zona: zonaController.text,
        documentId: widget.covidData.documentId,
        nama: namaController.text,
      );
      _covidController.updateCovidData(updatedData);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Data COVID-19',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: tanggalController,
                  decoration: InputDecoration(
                    labelText: 'Tanggal',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tanggal tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),

                TextFormField(
                  controller: totalKasusController,
                  decoration: InputDecoration(
                    labelText: 'Total Kasus',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Total Kasus tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: namaController,
                  decoration: InputDecoration(
                    labelText: 'Nama',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),

                TextFormField(
                  controller: sembuhController,
                  decoration: InputDecoration(
                    labelText: 'Sembuh',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Jumlah sembuh tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),

                TextFormField(
                  controller: meninggalController,
                  decoration: InputDecoration(
                    labelText: 'Meninggal',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Jumlah meninggal tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),

                TextFormField(
                  controller: kotaController,
                  decoration: InputDecoration(
                    labelText: 'Kota',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kota tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),

                TextFormField(
                  controller: zonaController,
                  decoration: InputDecoration(
                    labelText: 'Zona',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Zona tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _updateData,
                    child: Text(
                      'Update Data',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
