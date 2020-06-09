

import 'package:flutter/material.dart';

import 'network.dart';

class CoronaVirusApp extends StatefulWidget {
  @override
  _CoronaVirusAppState createState() => _CoronaVirusAppState();
}

class _CoronaVirusAppState extends State<CoronaVirusApp> {

  Future data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = getData();
    data.then( (value) => {
      print (value[0]['name'])
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid-19"),
      ),
      body: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                  "Jumlah kasus di Indonesia",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                    fontSize: 18.0
                  )
              ),
            ),
            createTextFromApi()
          ],
        )
      ),
    );
  }

  Widget createTextFromApi(){
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      alignment: Alignment.topLeft,
      child: FutureBuilder(
          future: data,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Text(
                  "Positif: ${snapshot.data[0]["positif"]}\nSembuh: ${snapshot.data[0]["sembuh"]}\n"
                      "Meninggal: ${snapshot.data[0]["meninggal"]}\nDirawat: ${snapshot.data[0]["dirawat"]}"
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }

  Future getData() async {
    Network network = Network("https://api.kawalcorona.com/indonesia/");
    return network.fetchData();
  }
}

