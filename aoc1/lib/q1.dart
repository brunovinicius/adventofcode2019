import 'package:flutter/material.dart';

class Q1Page extends StatefulWidget {
  Q1Page({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Q1PageState createState() => _Q1PageState();
}

class _Q1PageState extends State<Q1Page> {
  var _nominalFuelRequirement = 0;
  var _extraFuelRequirement = 0;
  var _totalFuelRequirement = 0;
  var _moduleCount = 0;
  var _totalModuleMass = 0.0;
  var _averageModuleMass = 0.0;
  var _controller = new TextEditingController();

  void _incrementCounter() {
    setState(() {
      var modulesMass = _controller.text.split('\n').map(int.parse);
      
      _moduleCount = modulesMass.length;

      _totalModuleMass = modulesMass.fold(0, (accumulator, element) => accumulator + element);

      _averageModuleMass = _totalModuleMass / _moduleCount;
                
      _nominalFuelRequirement = 
        modulesMass
          .map((mass) => (mass / 3).floor() - 2)
          .fold(0, (accumulator, element) => accumulator + element);

      _extraFuelRequirement = 
        modulesMass
          .map((mass) => (mass / 3).floor() - 2)
          .map((fuel) {
            var extraFuel = 0;
            var additionalMass = fuel;            
            while (additionalMass >= 9) {
              extraFuel += additionalMass = (additionalMass / 3).floor() - 2;
            }

            return extraFuel;
          })
          .fold(0, (accumulator, element) => accumulator + element);

      _totalFuelRequirement = _nominalFuelRequirement + _extraFuelRequirement;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 16.0),
              Text(
                'Inputs',
                style: Theme.of(context).textTheme.subtitle,
              ),
              TextField(
                maxLines: 8,
                controller: _controller,
              ),
              SizedBox(height: 48.0),
              Text(
                'What is the sum of the fuel requirements for all of the modules on your spacecraft?',
              ),
              SizedBox(height: 8.0),
              Text(
                'Fuel requirement is $_nominalFuelRequirement',
                style: Theme.of(context).textTheme.display4.copyWith(fontSize: 24.0, color: Colors.redAccent),
              ),
              SizedBox(height: 24.0),
              Text(
                'What is the sum of the fuel requirements for all of the modules on your spacecraft when also taking into account the mass of the added fuel?',
              ),
              SizedBox(height: 8.0),
              Text(
                'Accounting for the added fuel mass, $_totalFuelRequirement fuel will be necessary in total (a whopping $_extraFuelRequirement extra)',
                style: Theme.of(context).textTheme.display4.copyWith(fontSize: 24.0, color: Colors.redAccent),
              ),
              SizedBox(height: 24.0),
              Text(
                'Misc',
              ),
              SizedBox(height: 8.0),
              Text(
                '$_moduleCount modules detected',
                style: Theme.of(context).textTheme.display4.copyWith(fontSize: 24.0, color: Colors.lightBlueAccent),
              ),
              SizedBox(height: 8.0),
              Text(              
                'Average module mass is $_averageModuleMass',
                style: Theme.of(context).textTheme.display4.copyWith(fontSize: 24.0, color: Colors.lightGreenAccent),
              ),
              SizedBox(height: 8.0),
              Text(              
                'Total module mass is $_totalModuleMass',
                style: Theme.of(context).textTheme.display4.copyWith(fontSize: 24.0, color: Colors.tealAccent),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
