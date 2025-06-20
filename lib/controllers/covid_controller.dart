import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_banten_app/models/covid_model.dart';

class CovidController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<CovidData>> getCovidData() {
    return _firestore
        .collection('covid_data')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) {
                var data = doc.data() as Map<String, dynamic>;
                return CovidData.fromFirestore(data)..documentId = doc.id;
              }).toList(),
        );
  }

  Future<void> addCovidData(CovidData covidData) async {
    await _firestore.collection('covid_data').add(covidData.toMap());
  }

  Future<void> deleteCovidData(String documentId) async {
    try {
      await _firestore.collection('covid_data').doc(documentId).delete();
      print("Data berhasil dihapus.");
    } catch (e) {
      print("Error menghapus data: $e");
    }
  }

  Future<void> updateCovidData(CovidData updatedData) async {
    try {
      await _firestore
          .collection('covid_data')
          .doc(updatedData.documentId)
          .update(updatedData.toMap());
      print("Data berhasil diperbarui.");
    } catch (e) {
      print("Error memperbarui data: $e");
    }
  }
}
