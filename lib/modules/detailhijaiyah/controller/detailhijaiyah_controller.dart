import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iqra_app/data/models/detailhijaiyah.dart';
import 'dart:convert';

class DetailHijaiyahController extends ChangeNotifier {
  int selectedHarkatIndex = 0;
  void selectHarkat(int index) {
    selectedHarkatIndex = index;
    notifyListeners();
  }

  Future<DetailHijaiyah> getDetailHijaiyah(String id) async {
    Uri url =
        Uri.parse("https://ccfa-2400-9800-860-abd7-f4e1-a46e-5639-c5b7.ngrok-free.app/hijaiyah/$id");
    var res = await http.get(url);

    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];
    return DetailHijaiyah.fromJson(data);
  }
}
