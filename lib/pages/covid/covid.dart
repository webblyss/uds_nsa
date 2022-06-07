import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nsa_app/pages/covid/counter.dart';
import 'package:nsa_app/pages/covid/precaution.dart';

import 'constant.dart';
import 'country.dart';
import 'my_header.dart';

class CovidScreen extends StatefulWidget {
  @override
  _CovidScreenState createState() => _CovidScreenState();
}

class _CovidScreenState extends State<CovidScreen> {
  final controller = ScrollController();
  double offset = 0;
  String url = 'https://coronavirus-19-api.herokuapp.com/all';

  @override
  void initState() {
    super.initState();
    controller.addListener(onScroll);
    fetchData();
  }

  int cases;
  int death;
  int recovered;
  fetchData() async {
    final response = await http.get(Uri.parse(url));
    final extractedData = json.decode(response.body);
    if (extractedData != null) {
      setState(() {
        cases = extractedData['cases'];
        death = extractedData['deaths'];
        recovered = extractedData['recovered'];
      });
    } else {
      return;
    }
    print(extractedData['cases']);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      controller: controller,
      child: Column(
        children: <Widget>[
          MyHeader(
            image: "assets/images/Drcorona.png",
            textTop: "All you need",
            textBottom: "is stay at home.",
            offset: offset,
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Global Case Update\n",
                            style: kTitleTextstyle,
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (ctx) => ShowCountry()));
                      },
                      child: Text(
                        "View all",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 30,
                        color: kShadowColor,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Counter(
                        color: kInfectedColor,
                        title: "Infected",
                        number: cases == null ? Text("fetching data....",style: TextStyle(fontSize: 12),): Text("$cases",style: TextStyle(fontSize: 18),),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 30,
                        color: kShadowColor,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Counter(
                        color: kRecovercolor,
                        number: recovered == null ? Text("fetching data....",style: TextStyle(fontSize: 12),): Text("$recovered",style: TextStyle(fontSize: 18),),
                        title: "Recovered",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 30,
                        color: kShadowColor,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Counter(
                        color: kDeathColor,
                        number: death == null ? Text("fetching data....",style: TextStyle(fontSize: 12),): Text("$death",style: TextStyle(fontSize: 18),),
                        title: "Deaths",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Spread of Virus",
                style: kTitleTextstyle,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (ctx) => InfoScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right:8.0),
                  child: Text(
                    "See details",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.all(20),
            height: 178,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 30,
                  color: kShadowColor,
                ),
              ],
            ),
            child: Image.asset(
              "assets/covid/map.png",
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    ));
  }
}
