class CovidData {
  final String tanggal;
  final int totalKasus;
  final int sembuh;
  final int meninggal;
  final String kota;
  final String zona;
  String documentId;
  final String nama;

  CovidData({
    required this.tanggal,
    required this.totalKasus,
    required this.sembuh,
    required this.meninggal,
    required this.kota,
    required this.zona,
    required this.documentId,
    required this.nama,
  });

  factory CovidData.fromFirestore(Map<String, dynamic> data) {
    return CovidData(
      tanggal: data['tanggal'],
      totalKasus: data['total_kasus'],
      sembuh: data['sembuh'],
      meninggal: data['meninggal'],
      kota: data['kota'],
      zona: data['zona'],
      documentId: data['documentId'],
      nama: data['nama'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tanggal': tanggal,
      'total_kasus': totalKasus,
      'sembuh': sembuh,
      'meninggal': meninggal,
      'kota': kota,
      'zona': zona,
      'documentId': documentId,
      'nama': nama,
    };
  }
}
