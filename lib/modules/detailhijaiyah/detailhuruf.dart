import 'package:flutter/material.dart';
import 'package:iqra_app/modules/detailhijaiyah/controller/detailhijaiyah_controller.dart';
import 'package:iqra_app/data/models/detailhijaiyah.dart' as detail;
import 'package:provider/provider.dart';

class DetailHuruf extends StatelessWidget {
  final int id; // Deklarasikan variabel "id" sebagai parameter
  // final String huruf; // Deklarasikan variabel "id" sebagai parameter

  DetailHuruf({required this.id}); // Konstruktor dengan parameter "id"
  DetailHijaiyahController detailHijaiyahC = DetailHijaiyahController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detail Huruf"),
        ),
        body: ChangeNotifierProvider(
          create: (context) => DetailHijaiyahController(),
          child: FutureBuilder<detail.DetailHijaiyah>(
            future: detailHijaiyahC.getDetailHijaiyah(id.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              // print(snapshot.data);
              if (!snapshot.hasData) {
                return Center(
                  child: Text("Data Kosong"),
                );
              }

              List<Widget> harkats1 =
                  List.generate(snapshot.data?.harkats.length ?? 0, (index) {
                detail.Harkat? harkat1 = snapshot.data?.harkats[index];
                // print(harkat1);
                // print(snapshot.data?.harkats);
                // if (harkat1?.id != index) {
                //   return SizedBox();
                // }
                // if (harkat1?.id == index) {
                //   return Text(harkat1!.tulisanArab);
                // }

                print(harkat1?.id);
                print(harkat1?.tulisanArab);
                print(harkat1?.tulisanLatin);
                print(harkat1?.harkat);
                print(harkat1?.pengucapan);
                print("---------------------------------------------");

                return Consumer<DetailHijaiyahController>(
                  builder: (context, harkatState, _) {
                    final selectedHarkatIndex = harkatState.selectedHarkatIndex;

                    final textColor = harkatState.selectedHarkatIndex == index
                        ? Colors.red
                        : Colors.black;

                    // if (harkatState.selectedHarkatIndex != index) {
                    //   selectedHarkatIndex == index;
                    //   return SizedBox();
                    // }

                    return Column(
                      children: [
                        Column(
                          children: [
                            harkat1?.id == 1
                                ? Text(
                                    "${harkat1?.tulisanArab}",
                                    style: TextStyle(
                                        fontSize: 50, color: textColor),
                                    textAlign: TextAlign.end,
                                  )
                                : Text(""),
                            SizedBox(height: 20),
                            harkat1?.id == 1
                                ? Text(
                                    "${harkat1?.tulisanLatin}",
                                    style: TextStyle(fontSize: 20),
                                  )
                                : Text(""),
                            ElevatedButton(
                              onPressed: () {
                                Provider.of<DetailHijaiyahController>(context,
                                        listen: false)
                                    .selectHarkat(index);
                              },
                              child: Text("${harkat1?.harkat}"),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              });

              return Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: harkats1,
                    ),
                    SizedBox(height: 50),
                    Text("cara Pengucapan"),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
