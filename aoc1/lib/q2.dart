import 'package:flutter/material.dart';

class Q2Page extends StatefulWidget {
  Q2Page({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Q2PageState createState() => _Q2PageState();
}

class _Q2PageState extends State<Q2Page> {
  static var commands = { 1: new SumCommand(), 2: new MultiplyCommand(), 99: new HaltCommand() };
  static const expectedResult = 19690720;

  var _controller = new TextEditingController();
  var _intcode1Result = 0;
  var _instructionsCount = 0;
  var _reversePos1 = 0;
  var _reversePos2 = 0;
  var _finalAnswer = 0;

  void _incrementCounter() {
    setState(() {
      var instructions = _controller.text.split(',').map(int.parse).toList();
      
      _instructionsCount = instructions.length;

      _intcode1Result = run(instructions, 12, 2);

      var result = 0;
      for (var i = 0; i < 100; i++) {
        for (var j = 0; j < 100; j++) {
          instructions = _controller.text.split(',').map(int.parse).toList();
          result = run(instructions, i, j);
          if (result == expectedResult) {
            i = 100;
            break;
          }
        }
      }
      
      _reversePos1 = instructions[1];
      _reversePos2 = instructions[2];
      _finalAnswer = 100 * _reversePos1 + _reversePos2;
    });
  }

  int run(List<int> instructions, int input1, int input2) {
    instructions[1] = input1;
    instructions[2] = input2;

    try {
      for (int i = 0; i < _instructionsCount; i += 4) {
        commands[instructions[i]].processs(instructions, i + 1);
      } 
    } on HaltException { }

    return instructions[0];
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
                'Once you have a working computer, the first step is to restore the gravity assist program (your puzzle input) to the "1202 program alarm" state it had just before the last computer caught fire. To do this, before running the program, replace position 1 with the value 12 and replace position 2 with the value 2. What value is left at position 0 after the program halts?',
              ),
              SizedBox(height: 8.0),
              Text(
                'Intcore value on position 0 is $_intcode1Result',
                style: Theme.of(context).textTheme.display4.copyWith(fontSize: 24.0, color: Colors.redAccent),
              ),
              SizedBox(height: 24.0),
              Text(
                'Find the input noun and verb that cause the program to produce the output 19690720. What is 100 * noun + verb? (For example, if noun=12 and verb=2, the answer would be 1202.)',
              ),
              SizedBox(height: 8.0),
              Text(
                'Final answer is $_finalAnswer',
                style: Theme.of(context).textTheme.display4.copyWith(fontSize: 24.0, color: Colors.redAccent),
              ),
                            SizedBox(height: 24.0),
              Text(
                'Misc',
              ),
              SizedBox(height: 8.0),
              Text(
                '$_reversePos1 was the noun',
                style: Theme.of(context).textTheme.display4.copyWith(fontSize: 24.0, color: Colors.lightBlueAccent),
              ),
              SizedBox(height: 8.0),
              Text(              
                '$_reversePos2 was the verb',
                style: Theme.of(context).textTheme.display4.copyWith(fontSize: 24.0, color: Colors.lightGreenAccent),
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


abstract class Command {
  void processs(List<int> code, int offset) {
    var value1 = code[code[offset]];
    var value2 = code[code[offset + 1]];
    code[code[offset + 2]] = evaluate(value1, value2);
  }

  @protected int evaluate(int value1, int value2);
}

class MultiplyCommand extends Command {
  @override
  int evaluate(int value1, int value2) {
    return value1 * value2;
  }  
}

class SumCommand extends Command {
  @override
  int evaluate(int value1, int value2) {
    return value1 + value2;
  }
}

class HaltCommand extends Command {
  @override
  int evaluate(int value1, int value2) {
    throw HaltException();
  }
}

class HaltException implements Exception {
  HaltException();
}
