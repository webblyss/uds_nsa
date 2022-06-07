import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nsa_app/pages/bmi/components/bottom_button.dart';
import 'package:nsa_app/pages/bmi/components/reusable_card.dart';
import 'package:nsa_app/pages/bmi/components/round_icon_button.dart';
import 'package:nsa_app/pages/bmi/components/top_card.dart';

import '../calculator_brain.dart';
import '../constants.dart';
import 'results_page.dart';

enum Gender { male, female }

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender;
  int height = 180;
  int weight = 60;
  int age = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Container(
        child: SingleChildScrollView(
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ReusableCard(
                        cardColor: selectedGender == Gender.male
                            ? kActiveCardColor
                            : kInactiveCardColor,
                        cardChild: TopCard(
                          iconName: FontAwesomeIcons.mars,
                          iconColor: selectedGender == Gender.male
                              ? selectedIconColor
                              : unselectedIconColor,
                          cardText: 'MALE',
                        ),
                        onTapAction: () {
                          setState(() {
                            selectedGender = Gender.male;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: ReusableCard(
                        cardColor: selectedGender == Gender.female
                            ? kActiveCardColor
                            : kInactiveCardColor,
                        cardChild: TopCard(
                          iconName: FontAwesomeIcons.venus,
                          iconColor: selectedGender == Gender.female
                              ? selectedIconColor
                              : unselectedIconColor,
                          cardText: 'FEMALE',
                        ),
                        onTapAction: () {
                          setState(() {
                            selectedGender = Gender.female;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 250,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ReusableCard(
                        cardColor: kActiveCardColor,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('HEIGHT', style: kLabelTextStyle),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: <Widget>[
                                Text(height.toString(), style: kNumberStyle),
                                Text(
                                  'cm',
                                  style: kLabelTextStyle,
                                )
                              ],
                            ),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                thumbColor: kBottomContainerColor,
                                activeTrackColor: Colors.white,
                                inactiveTrackColor: kSliderInactiveColor,
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 15.0),
                                overlayShape:
                                    RoundSliderOverlayShape(overlayRadius: 30.0),
                                overlayColor: kSliderOverlayColor,
                              ),
                              child: Slider(
                                value: height.toDouble(),
                                min: 10.0,
                                max: 300.0,
                                onChanged: (double newValue) {
                                  setState(() {
                                    height = newValue.toInt();
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 200,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ReusableCard(
                        cardColor: kActiveCardColor,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'WEIGHT',
                              style: kLabelTextStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: <Widget>[
                                Text(weight.toString(), style: kNumberStyle),
                                Text("kg", style: kLabelTextStyle),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RoundIconButton(
                                  icon: FontAwesomeIcons.minus,
                                  onPressAction: () {
                                    setState(() {
                                      weight--;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                RoundIconButton(
                                  icon: FontAwesomeIcons.plus,
                                  onPressAction: () {
                                    setState(() {
                                      weight++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ReusableCard(
                        cardColor: kActiveCardColor,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'AGE',
                              style: kLabelTextStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: <Widget>[
                                Text(age.toString(), style: kNumberStyle),
                                Text('yrs', style: kLabelTextStyle),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RoundIconButton(
                                  icon: FontAwesomeIcons.minus,
                                  onPressAction: () {
                                    setState(() {
                                      age--;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                RoundIconButton(
                                  icon: FontAwesomeIcons.plus,
                                  onPressAction: () {
                                    setState(() {
                                      age++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              BottomButton(
                text: "CALCULATE",
                onTap: () {
                  CalculatorBrain calc =
                      CalculatorBrain(weight: weight, height: height);

                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ResultsPage(
                          bmiResult: calc.calculateBMI(),
                          bmiInterpretation: calc.getResults()),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
