import 'dart:math';

class CalculatorBrain {
  final int height;
  final int weight;
  double _bmi;
  String _idealWeight1;
  String _idealWeight2;

  CalculatorBrain({this.height, this.weight});

  String calculateBMI() {
    _bmi = weight / pow(height / 100, 2);
    return _bmi.toStringAsFixed(1);
  }

  void calculateIdealWeightRange() {
    _idealWeight1 = (pow(height / 100, 2) * 18).toStringAsFixed(0);
    _idealWeight2 = (pow(height / 100, 2) * 25).toStringAsFixed(0);
  }

  Map<String, String> getResults() {
    calculateIdealWeightRange();

    if (_bmi > 30)
      return {
        'result': 'Obese',
        'interpretation':
            'Your body weight ($weight kg) is higher than normal. \n\nThe ideal weight range for your height is: $_idealWeight1 kg - $_idealWeight2 kg. \n\n You are at an increased risk of certain health problems. Try to lose weight with suitable diet and exercise.'
      };
    else if (_bmi > 25 && _bmi < 30)
      return {
        'result': 'Overweight',
        'interpretation':
            'Your body weight ($weight kg) is higher than normal. \n\nThe ideal weight range for your height is: $_idealWeight1 kg - $_idealWeight2 kg.'
      };
    else if (_bmi > 18.5 && _bmi < 25)
      return {
        'result': 'Normal',
        'interpretation':
            'Your body weight ($weight kg) is in the ideal range for your height: $_idealWeight1 kg - $_idealWeight2 kg. \n\nGood job!'
      };
    else
      return {
        'result': 'Underweight',
        'interpretation':
            'Your body weight ($weight kg) is lower than normal. \n\nThe ideal weight range for your height is: $_idealWeight1 kg - $_idealWeight2 kg.'
      };
  }
}
