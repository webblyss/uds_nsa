import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;


class MedicalDic extends StatefulWidget {
  final csv;

  const MedicalDic({Key key, this.csv}) : super(key: key);
  @override
  _MedicalDicState createState() => _MedicalDicState();
}

class _MedicalDicState extends State<MedicalDic> {
  List<List<dynamic>> _data = [];

  // This function is triggered when the floating button is pressed

  @override
  void initState() {
    _loadCSV();
    super.initState();
  }

  void _loadCSV() async {
    final _rawData = await rootBundle.loadString(widget.csv);
    List<List<dynamic>> _listData = CsvToListConverter().convert(_rawData);
    setState(() {
      _data = _listData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MEDICAL ABBREVIATION"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: _data.length,
        itemBuilder: (_, index) {
          return Card(
            margin: const EdgeInsets.all(3),
            color: index == 0 ? Colors.amber : Colors.white,
            child: ListTile(
              onTap: () {
                print(_data[index][1]);
              },
              title: Text(_data[index][0].toString()),
              leading: Icon(Icons.bookmark),
              subtitle: Text(_data[index][1].toString()),
            ),
          );
        },
      ),
    );
  }
}
