import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nsa_app/admin/commitee_members/committee.dart';
import 'package:nsa_app/admin/staff/staff.dart';
import 'package:nsa_app/admin/student_executive/student_executive_home.dart';
import 'package:nsa_app/admin/task/component.dart';

class GridDashboard extends StatefulWidget {
  @override
  _GridDashboardState createState() => _GridDashboardState();
}

class _GridDashboardState extends State<GridDashboard> {
  Items item1 = new Items(
    title: "Student Executive",
    subtitle: "",
    event: "Add profile",
    //  img: "assets/calendar.png"
  );

  Items item2 = new Items(
    title: "Committee\n Members",
    subtitle: "Add profile",
    event: "",
    //  img: "assets/map.png",
  );

  Items item3 = new Items(
    title: "Staff Members",
    subtitle: "Add Staff",
    event: "",
    //  img: "assets/festival.png",
  );

 
  Items item7 = new Items(
    title: "Add",
    subtitle: "Component",
    event: "Task",
    //img: "assets/todo.png",
  );
  Items item8 = new Items(
    title: "Reset Password",
    subtitle: "Security",
    event: "",
    //img: "assets/todo.png",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [
      item1,
      item2,
      item3,
      
      item7,
      item8
    ];
    var color = 0xff453658;
    return Flexible(
        child: StaggeredGridView.countBuilder(
      shrinkWrap: true,
      staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
      crossAxisCount: 4,
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      itemCount: myList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (index == 0) {
              Navigator.of(context).push(
                  CupertinoPageRoute(builder: (ctx) => StudentExceutiveHome()));
            } else if (index == 3) {
              Navigator.of(context)
                  .push(CupertinoPageRoute(builder: (ctx) => ComponentLoad()));
            
            } else if (index == 1) {
              Navigator.of(context).push(
                  CupertinoPageRoute(builder: (ctx) => CommitteeMembers()));
            } else if (index == 2) {
              Navigator.of(context).push(
                  CupertinoPageRoute(builder: (ctx) => StaffMembers()));
            }
          },
          child: Container(
            height: 200,
            decoration: BoxDecoration(
                color: Color(color), borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  myList[index].title,
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  myList[index].subtitle,
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          color: Colors.white38,
                          fontSize: 10,
                          fontWeight: FontWeight.w600)),
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  myList[index].event,
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        );
      },
    ));
  }
}

class Items {
  String title;
  String subtitle;
  String event;

  Items({
    this.title,
    this.subtitle,
    this.event,
  });
}
