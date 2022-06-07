class MedicalCate {
  String name;
  String position;
  String csv;

  MedicalCate(this.name, this.position, this.csv);
}

List<MedicalCate> abbreviation = cardData
    .map(
      (item) => MedicalCate(
        item['name'],
        item['position'],
        item['csv'],
      ),
    )
    .toList();

var cardData = [
  {
    "name": "",
    "position": "A-B",
    "csv":"assets/csv/a-z.csv"
  },
  {
    "name": "",
    "position": "C-D",
    "csv":"assets/csv/c-d.csv"
  },
  {
    "name": "",
    "position": "E-G",
    "csv":"assets/csv/e-g.csv"
  },
  {
    "name": "",
    "position": "H-L",
    "csv":"assets/csv/h-l.csv"
  },
  {
    "name": "",
    "position": "M-O",
    "csv":"assets/csv/m-o.csv"
  },
  {
    "name": "",
    "position": "P-R",
    "csv":"assets/csv/p-r.csv"
  },
  {
    "name": "",
    "position": "S-Z",
    "csv":"assets/csv/s-z.csv"
  },
];
