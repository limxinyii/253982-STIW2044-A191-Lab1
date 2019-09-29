import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _gender = ['Male', 'Female'],
      _equation = ['Mifflin - St Jeor', 'Harris-Benedict'],
      _level = [
    'Litter or no exercise',
    'light exercise 1-3 days per week',
    'Exercise 3-5 days per week',
    'Exercise 6-7 days per week',
    'Very hard exercise and a physical job'
  ];
  var _genderSelected = 'Male',
      _equationSelected = 'Mifflin - St Jeor',
      _levelSelected = 'Litter or no exercise';
  final TextEditingController _acontroller = TextEditingController();
  final TextEditingController _bcontroller = TextEditingController();
  final TextEditingController _ccontroller = TextEditingController();
  int a = 0;
  double b = 0.0, c = 0.0, result = 0.0, calories = 0.0;
  String bmr, caloriesPerDay;
  String img = "assets/images/logo1.png";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          //resizeToAvoidBottomPadding: false,
          body: Container(
        //mainAxisAlignment: MainAxisAlignment.center,wa
        child: ListView(
          children: <Widget>[
             SizedBox(
              height: 25,
            ),
            Image.asset(
              img,
              height: 150.0,
              width: 170.0,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Gender :',
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  'BMR Equation :',
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ],
            )),
            Container(
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  DropdownButton<String>(
                    items: _gender.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValueSelected) {
                      setState(() {
                        this._genderSelected = newValueSelected;
                      });
                    },
                    value: _genderSelected,
                  ),
                  DropdownButton<String>(
                    items: _equation.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValueSelected) {
                      setState(() {
                        this._equationSelected = newValueSelected;
                      });
                    },
                    value: _equationSelected,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 10, 50, 0),
              child: TextField(
                decoration: InputDecoration(
                    labelText: "Age",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                controller: _acontroller,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 10, 50, 0),
              child: TextField(
                decoration: InputDecoration(
                    labelText: "Height(cm)",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                controller: _bcontroller,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 15, 50, 0),
              child: TextField(
                decoration: InputDecoration(
                    labelText: "Weight(kg)",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                controller: _ccontroller,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(80, 15, 80, 0),
              child: Text(
                'Please Select Your Activity Level :',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            Container(
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  DropdownButton<String>(
                    items: _level.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValueSelected) {
                      setState(() {
                        this._levelSelected = newValueSelected;
                      });
                    },
                    value: _levelSelected,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(100, 20, 100, 30),
              child: RaisedButton(
                child: Text("Calculate BMR"),
                onPressed: _onPress,
              ),
            ),
            Text('BMR RESULT : ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.deepPurple)),
            Text(
                'Calculation for a $_genderSelected of $a years with a height of $b cm and weight of $c kg. ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    height: 2.0, fontSize: 15, color: Colors.deepPurple)),
            Container(
              margin: const EdgeInsets.fromLTRB(40, 15, 40, 15),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey, width: 1.5),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Text(
                  'Your BMR : \n $bmr \n\n Maintenance calories per day : \n $caloriesPerDay ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.deepPurple)),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 17,
                  height: 2.0,
                  color: Colors.deepPurpleAccent,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Summary : ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'Your body will burn '),
                  TextSpan(
                      text: '$bmr ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          'each day of you engage in no activity for that day. The estimate for maintaining your current weight (based upon your chosen activity area level) is '),
                  TextSpan(
                      text: '$caloriesPerDay. ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'This calculation used the '),
                  TextSpan(
                      text: '$_equationSelected equation.',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  void _onPress() {
    setState(() {
      a = int.parse(_acontroller.text);
      b = double.parse(_bcontroller.text);
      c = double.parse(_ccontroller.text);
    
      if ((_genderSelected == 'Male') &&
          (_equationSelected == 'Mifflin - St Jeor')) {
        result = (10 * c) + (6.25 * b) - (5 * a) + 5;

        if (_levelSelected == 'Little or no exercise') {
          calories = (result * 1.2);
        } else if (_levelSelected == 'light exercise 1-3 days per week') {
          calories = (result * 1.375);
        } else if (_levelSelected == 'Exercise 3-5 days per week') {
          calories = (result * 1.55);
        } else if (_levelSelected == 'Exercise 6-7 days per week') {
          calories = (result * 1.725);
        } else if (_levelSelected == 'Very hard exercise and a physical job') {
          calories = (result * 1.725);
        }
      } else if ((_genderSelected == 'Female') &&
          (_equationSelected == 'Mifflin - St Jeor')) {
        result = (10 * c) + (6.25 * b) - (5 * a) - 161;

        if (_levelSelected == 'Little or no exercise') {
          calories = (result * 1.2);
        } else if (_levelSelected == 'light exercise 1-3 days per week') {
          calories = (result * 1.375);
        } else if (_levelSelected == 'Exercise 3-5 days per week') {
          calories = (result * 1.55);
        } else if (_levelSelected == 'Exercise 6-7 days per week') {
          calories = (result * 1.725);
        } else if (_levelSelected == 'Very hard exercise and a physical job') {
          calories = (result * 1.725);
        }
      } else if ((_genderSelected == 'Male') &&
          (_equationSelected == 'Harris-Benedict')) {
        result = 66.47 + (13.75 * c) + (5.003 * b) - (6.755 * a);

        if (_levelSelected == 'Little or no exercise') {
          calories = (result * 1.2);
        } else if (_levelSelected == 'light exercise 1-3 days per week') {
          calories = (result * 1.375);
        } else if (_levelSelected == 'Exercise 3-5 days per week') {
          calories = (result * 1.55);
        } else if (_levelSelected == 'Exercise 6-7 days per week') {
          calories = (result * 1.725);
        } else if (_levelSelected == 'Very hard exercise and a physical job') {
          calories = (result * 1.725);
        }
      } else if ((_genderSelected == 'Female') &&
          (_equationSelected == 'Harris-Benedict')) {
        result = 655.1 + (9.563 * c) + (1.85 * b) - (4.676 * a);

        if (_levelSelected == 'Little or no exercise') {
          calories = (result * 1.2);
        } else if (_levelSelected == 'light exercise 1-3 days per week') {
          calories = (result * 1.375);
        } else if (_levelSelected == 'Exercise 3-5 days per week') {
          calories = (result * 1.55);
        } else if (_levelSelected == 'Exercise 6-7 days per week') {
          calories = (result * 1.725);
        } else if (_levelSelected == 'Very hard exercise and a physical job') {
          calories = (result * 1.725);
        }
      }
    });
    bmr = result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 0);
    caloriesPerDay =
        calories.toStringAsFixed(calories.truncate() == calories ? 0 : 0);
  }
}
