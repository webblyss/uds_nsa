import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsa_app/pages/nsa/staff.dart';
import 'package:nsa_app/pages/nsa/studentEx.dart';
import 'package:nsa_app/pages/nsa/usersExcutive.dart';
import 'package:photo_view/photo_view.dart';

import 'committee.dart';

List imgList = [
  "assets/nmc/IMG-20210202-WA0011.jpg",
  "assets/nmc/IMG-20210202-WA0013.jpg",
  "assets/nmc/IMG-20210202-WA0014.jpg",
  "assets/nmc/IMG-20210202-WA0016.jpg",
  "assets/nmc/IMG-20210202-WA0019.jpg",
  "assets/nmc/IMG-20210202-WA0018.jpg",
  "assets/nmc/IMG-20210202-WA0011.jpg",
  "assets/nmc/IMG-20210202-WA0017.jpg",
  "assets/nmc/IMG-20210202-WA0015.jpg"
];

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  int _current = 0;
  List<Exec> executive;
  var green = Color(0xFF4caf6a);
  var greenLight = Color(0xFFd8ebde);

  var red = Color(0xFFf36169);
  var redLight = Color(0xFFf2dcdf);

  var blue = Color(0xFF398bcf);
  var blueLight = Color(0xFFc1dbee);
  @override
  void initState() {
    executive = Exec.getExec();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = imgList
        .map((item) => GestureDetector(
              onTap: () {
                showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (context) {
                    return Container(
                      child: PhotoView(
                        enableRotation: true,
                        imageProvider: AssetImage(item),
                      ),
                    );
                  },
                );
              },
              child: Container(
                color: Colors.white,
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: Stack(
                        children: <Widget>[
                          Image.asset(
                            item,
                            fit: BoxFit.cover,
                            width: 1000.0,
                          ),
                          Positioned(
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(200, 0, 0, 0),
                                    Color.fromARGB(0, 0, 0, 0)
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 20.0,
                              ),
                              child: Text(
                                'No. ${imgList.indexOf(item)} image',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ))
        .toList();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("About Nsa"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              CarouselSlider(
                items: imageSliders,
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 2.0,
                    pauseAutoPlayOnTouch: true,
                    scrollPhysics: BouncingScrollPhysics(),
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "INTRODUCTION TO THE ASSOCIATION",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    """We the Student Nurses of the University for Development Studies, Tamale Campus in our right to associate and desire to unite do hereby enact, adopt and give to ourselves this constitution which shall be the governing instrument of the UDS Student Nurses Associationwhere after referred to as Nursing Students’ Association- University for Development Studies: NSA-UDS.""",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "AIMS AND OBJECTIVES",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: aims.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("${index + 1}"),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(child: Text("${aims[index]}")),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
              Text(
                "STRUCTURE OF NSA-UDS",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "This shall be the structure of the Association;",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
              ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: executive.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ExpansionTile(
                      title: Text(executive[index].executive),
                      trailing: Icon(Icons.arrow_drop_down),
                      children: <Widget>[
                        //  Text("Functions".toUpperCase()),
                        ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: executive[index].function.length,
                          itemBuilder: (BuildContext context, int data) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("${data + 1}"),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                        Text(executive[index].function[data]),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: 50,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                      child: Container(
                        height: 150.0,
                        width: 200.0,
                        color: greenLight,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        StudentExecutive()));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.person,
                                color: green,
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                'Student Executive',
                                style: TextStyle(
                                    color: green, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                      child: Container(
                        height: 150.0,
                        width: 200.0,
                        color: blueLight,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (ctx) => StaffView()));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.school,
                                color: blue,
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                'Staff Members',
                                style: TextStyle(
                                    color: blue, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                      child: Container(
                        height: 150.0,
                        width: 200.0,
                        color: redLight,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (ctx) => CommitteeView()));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.school,
                                color: red,
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                'Committee Members',
                                style: TextStyle(
                                    color: red, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
