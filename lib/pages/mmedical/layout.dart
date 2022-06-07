import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'item.dart';
import 'medical.dart';

class MedicalCategory extends StatefulWidget {
  @override
  _MedicalCategoryState createState() => _MedicalCategoryState();
}

class _MedicalCategoryState extends State<MedicalCategory> {
  var green = Color(0xFF4caf6a);
  var greenLight = Color(0xFFd8ebde);

  var red = Color(0xFFf36169);
  var redLight = Color(0xFFf2dcdf);

  var blue = Color(0xFF398bcf);
  var blueLight = Color(0xFFc1dbee);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medical Abbreviations"),
      ),
      body: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,mainAxisSpacing: 4,crossAxisSpacing: 4),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        itemCount: abbreviation.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (index ==index) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx)=>MedicalDic(
                      csv: abbreviation[index].csv,
                    )));
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
              child: Container(
                height: 150.0,
                width: 200.0,
                color: redLight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      abbreviation[index].name,
                      style: TextStyle(
                        color: red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      abbreviation[index].position,
                      style: TextStyle(
                        color: red,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
