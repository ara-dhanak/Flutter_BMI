import 'package:bmicalculator/BMI_Calculator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '';

class bmi extends StatefulWidget {
  @override
  _bmiState createState() => new _bmiState();
}

class _bmiState extends State<bmi> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _ageController = new TextEditingController();
    TextEditingController _heightController = new TextEditingController();
    TextEditingController _weightController = new TextEditingController();
     double Result = 0.0;
    String _healthstatus = "";


    void _bmi_cal() {
      setState(() {
        print("BMI cal test");
        int age = int.parse(_ageController.text);
        double height = double.parse(_heightController.text);
        //  double inches = height * 12; //Converting feet to inches
        double meter = (height * 12) / 39.37; //Meter conversion
        double weight = double.parse(_weightController.text);
        double Result = 0.0;

        if ((_ageController.text.isNotEmpty || age > 0) &&
            ((_heightController.text.isNotEmpty || meter > 0) &&
                (_weightController.text.isNotEmpty || weight > 0))) {
          Result = weight / (meter * meter); //BMI value
          print("BMI value: $Result");
          print(Result);

          if (double.parse(Result.toStringAsFixed(1)) < 18.5) {
            _healthstatus = "Underweight";
            print(_healthstatus);
          } else if (double.parse(Result.toStringAsFixed(1)) >= 18.5 &&
              Result < 25) {
            _healthstatus = "Accurate";
            print(_healthstatus);
          } else if (double.parse(Result.toStringAsFixed(1)) >= 25 &&
              Result <= 30) {
            _healthstatus = "Overweight";
            print(_healthstatus);
          } else if (double.parse(Result.toStringAsFixed(1)) > 30) {
            _healthstatus = "Obese";
            print(_healthstatus);
          } else {
            Result = 0.0;
          }
        }
        print("Your bmi result is: $Result");
      });
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      appBar: new AppBar(
        title: new Text('BMI'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent.shade400,
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        child: new ListView(
          padding: const EdgeInsets.all(1.5),
          children: <Widget>[
            new Image.asset(
              'images/bmi.png',
              height: 100.0,
              width: 90.0,
            ),
            new Container(
              margin: const EdgeInsets.all(3.0),
              height: 250,
              width: 290,
              color: Colors.lime.shade400,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new TextField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        labelText: 'Age',
                        hintText: 'e.g: 27',
                        icon: new Icon(Icons.person_pin_rounded)),
                  ),
                  new TextField(
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        labelText: 'Height in feet',
                        hintText: 'e.g: 5.3 ft',
                        icon: new Icon(Icons.height)),
                  ),
                  new TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        labelText: 'Weight in kg',
                        hintText: 'e.g: 61 Kg',
                        icon: new Icon(Icons.line_weight_sharp)),
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(2.5),
                  ),

                  //Calculate button
                  new Container(
                    alignment: Alignment.center,
                      child: new FlatButton(
                    textColor: Colors.blue,
                    onPressed:_bmi_cal,
                    child: new Text('Calculate'),
                    shape: CircleBorder(
                        side: BorderSide(color: Colors.transparent)),
                  )
                  ),
              ]
              ),
            ),


                  new Container(
                    alignment: Alignment.center,
                    child: new Text(
                      "BMI value: $Result",
                      style: new TextStyle(
                        color: Colors.deepOrange,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  new Container(
                    alignment: Alignment.center,
                    child: new Text(
                      "How is your BMI?: $_healthstatus",
                      style: new TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          fontSize: 13),
                    ),
                  )

          ],
        ),
      ),
    );
  }
}
