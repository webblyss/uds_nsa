import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShowCountry extends StatefulWidget {
  @override
  _ShowCountryState createState() => _ShowCountryState();
}

class _ShowCountryState extends State<ShowCountry> {
  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(onScroll);
    fetchData();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  dynamic extractedData;
  List test = [];
  String url1 = 'https://corona-api.com/countries';
  String url = 'https://coronavirus-19-api.herokuapp.com/countries';
  fetchData() async {
    final response = await http.get(Uri.parse(url));
    extractedData = json.decode(response.body);
    print(extractedData[1]);
    setState(() {
      test.add(extractedData[1]);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid Details"),
      ),
      body: test.isNotEmpty? ListView.builder(
        itemCount: extractedData == null ? 0 : extractedData.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              onTap: () {
                AwesomeDialog(
                  context: (context),
                  customHeader: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.red,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage("assets/images/nmc.jpg"),
                    ),
                  ),
                  title: '${extractedData[index]['country']}',
                  body: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "Country : ${extractedData[index]['country']}",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Cases : ${extractedData[index]['cases']}",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Deaths : ${extractedData[index]['deaths']}",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Recovered : ${extractedData[index]['recovered']}",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Active : ${extractedData[index]['active']}",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Critical : ${extractedData[index]['critical']}",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )..show();
              },
              title: Text(
                "${extractedData[index]['country']}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              subtitle: Text("Cases : ${extractedData[index]['cases']}",),
            ),
          );
        },
      )
      :Center(child: Text("Fetching Data.....")),
    );
  }
}
