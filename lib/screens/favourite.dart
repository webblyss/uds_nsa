import 'package:flutter/material.dart';
import 'package:nsa_app/pages/component/dbmanager.dart';

class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  Student student;
  List<Student> studlist;
  final DbStudentManager dbmanager = new DbStudentManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: dbmanager.getStudentList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            studlist = snapshot.data;
            ListView.builder(
              shrinkWrap: true,
              itemCount: studlist == null ? 0 : studlist.length,
              itemBuilder: (BuildContext context, int index) {
                Student st = studlist[index];
                return ListTile(
                  title: Text(st.name),
                );
              },
            );
          }
          return Center(child: Text("Loading..."));
        },
      ),
    );
  }
}
