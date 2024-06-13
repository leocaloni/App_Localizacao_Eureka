import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';

class TrabalhosServico {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //meotdo para adicionar elementos ao firestore
  Future<void> _addDataToFirestore(Map<String, dynamic> data, String collection) async {
    await _firestore.collection(collection).add(data);
  }


  //metodo de insercao no firestore de um arquivo csv
  Future<void> uploadCsvData(String filePath, String collection) async {
    String csvString = await rootBundle.loadString(filePath);
    List<List<dynamic>> csvData = CsvToListConverter().convert(csvString);

    List<String> headers = csvData[0].map((header) => header.toString()).toList();
    for (int i = 1; i < csvData.length; i++) {
      Map<String, dynamic> data = {};
      for (int j = 0; j < headers.length; j++) {
        data[headers[j]] = csvData[i][j];
      }
      await _addDataToFirestore(data, collection);
    }
  }
}
