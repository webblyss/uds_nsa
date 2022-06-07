class Course {
  //attributes = fields in table
  int _id;
  String _finalScore;
  String _studentID;
  String _course;
  String _center;
  //String _studentSignature;
  String _task;
  String _scoreList;
  String _procedure;
  String _score;
 String _examinerName;
  String _date;

  Course(dynamic obj) {
    _id = obj['id'];
    _procedure = obj['procedure'];
    _scoreList = obj['scoreList'];
    _studentID = obj['studentid'];
    _course = obj['course'];
    _finalScore = obj['finalScore'];
    _center = obj['center'];
   // _studentSignature = obj['studentSign'];
    _task = obj['task'];
    _score = obj['score'];
    _date = obj['date'];
   _examinerName = obj['examinerName'];
  }
  Course.fromMap(Map<String, dynamic> data) {
    _id = data['id'];  
    _procedure = data['procedure'];
    _scoreList = data['scoreList'];
    _studentID = data['studentid'];
    _finalScore = data['finalScore'];
    _course = data['course'];
    _center = data['center'];
   // _studentSignature = data['studentSign'];
    _task = data['task'];
    _score = data['score'];
    _date = data['date'];
    _examinerName = data['examinerName'];
  }
  Map<String, dynamic> toMap() => {
        'id': _id,
        //'studentSign': _studentSignature,
        'studentid': _studentID,
        'procedure': _procedure,
        'course': _course,
        'center': _center,
        'finalScore': _finalScore,
        'signature': _studentID,
        'task': _task,
        'scoreList': _scoreList,
        'score': _score,
'examinerName': _examinerName,
        'date':_date,
      };

  int get id => _id;
  String get studentid => _studentID;
  //String get studentSign => _studentSignature;
  String get finalScore => _finalScore;
  String get course => _course;
  String get center => _center;
  String get signature => _studentID;
  String get task => _task;
  String get scoreList => _scoreList;
  String get procedure => _procedure;
  String get score => _score;
  String get examinerName => _examinerName;
  String get date => _date;
}
