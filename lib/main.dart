import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Kalkulator Umur'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController tanggalController = TextEditingController();
  TextEditingController bulanController = TextEditingController();
  TextEditingController tahunController = TextEditingController();
  int tanggal, bulan, tahun;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                      child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: tanggalController,
                    decoration: InputDecoration(
                        labelText: 'Tanggal', hintText: 'tanggal'),
                  )),
                  Expanded(
                      child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: bulanController,
                    decoration:
                        InputDecoration(labelText: 'Bulan', hintText: 'bulan'),
                  )),
                  Expanded(
                      child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: tahunController,
                    decoration:
                        InputDecoration(labelText: 'Tahun', hintText: 'tahun'),
                  )),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: MaterialButton(
                child: Text('Submit', style: TextStyle(color: Colors.white)),
                color: Colors.lightBlue,
                onPressed: () {
                  setState(() {
                    tanggal = int.parse(tanggalController.text);
                    bulan = int.parse(bulanController.text);
                    tahun = int.parse(tahunController.text);
                    _alertDialog(tanggal, bulan, tahun);
                    tanggalController.text = "";
                    bulanController.text = "";
                    tahunController.text = "";
                  });
                },
              ),
            ),
          ],
        ),
      )),
    );
  }

  void _alertDialog(int tanggal, int bulan, int tahun) {
    DateTime sekarang = DateTime.now();
    var tgl = sekarang.day - tanggal;
    var bln = sekarang.month - bulan;
    var thn = sekarang.year - tahun;
    if (tgl < 0) {
      bln--;
      tgl += sekarang.day;
    }
    if (bln < 0) {
      thn--;
      bln += 12;
    }
    AlertDialog alertDialog = new AlertDialog(
      title: Text("Hasil"),
      content: Text("Umur anda: $thn tahun $bln bulan $tgl hari"),
      actions: <Widget>[
        MaterialButton(
          color: Colors.lightBlue,
          child: Text("Ok", style: TextStyle(color: Colors.white)),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
