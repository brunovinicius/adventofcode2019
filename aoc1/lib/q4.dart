import 'package:flutter/material.dart';

class Q4Page extends StatefulWidget {
  Q4Page({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Q4PageState createState() => _Q4PageState();
}

class _Q4PageState extends State<Q4Page> {
  static const consecutives = ["00", "11", "22", "33", "44", "55", "66", "77", "88", "99" ];

  var _controller = new TextEditingController();
  var _possiblePasswords = 0;
  var _wire1PathsCount = 0;
  var _wire2PathsCount = 0;
  var _strictierPossiblePasswords = 0;

  void _incrementCounter() {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      var range = _controller.text.split('-').map((n) => int.parse(n)).toList();
      var low = range.first;
      var high = range.last;
      
      
      var passwords = new List<String>();
      for (var i = low; i <= high; i++) {
        var password = i.toString();
        if (_hasConsecutives(password) && _isIncreasing(password)) {
          passwords.add(password);
        }        
      }

      _possiblePasswords = passwords.length;

      var strictierPasswords = new List<String>();
      for (var password in passwords) {
        if (_hasStrictConsecutives(password) && _isIncreasing(password)) {
          strictierPasswords.add(password);
        }        
      }

      _strictierPossiblePasswords = strictierPasswords.length;
    });

  }

  bool _hasConsecutives(String password) {
    for (var consecutive in consecutives) {
      if (password.contains(consecutive)) {
        return true;
      }
    }
    return false;
  }
  
  bool _hasStrictConsecutives(String password) {
    var map = new Map<String, int>();
    for (var char in password.split("")) {
      if (map[char] == null) {
        map[char] = 0;
      }
      map[char]++;
    }
    return map.values.any((i) => i == 2);
  }

  bool _isIncreasing(String password) {
    var lastValue = 0;
    for (var number in password.split("")) {
      var value = int.parse(number);
      if (value < lastValue) {
        return false;
      }
      lastValue = value;
    }
    return true;
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
                maxLines: 1,
                controller: _controller,
              ),
              SizedBox(height: 48.0),
              Text(
                'How many different passwords within the range given in your puzzle input meet these criteria?',
              ),
              SizedBox(height: 8.0),
              Text(
                'There are $_possiblePasswords possible passwords',
                style: Theme.of(context).textTheme.display4.copyWith(fontSize: 24.0, color: Colors.redAccent),
              ),
              SizedBox(height: 24.0),
              Text(
                'How many different passwords within the range given in your puzzle input meet all of the criteria?',
              ),
              SizedBox(height: 8.0),
              Text(
                'Under new criteria, there are $_strictierPossiblePasswords possible passwords',
                style: Theme.of(context).textTheme.display4.copyWith(fontSize: 24.0, color: Colors.redAccent),
              ),
              SizedBox(height: 24.0),
              Text(
                'Misc',
              ),
              SizedBox(height: 8.0),
              Text(
                'No misc today :P',
                style: Theme.of(context).textTheme.display4.copyWith(fontSize: 24.0, color: Colors.lightBlueAccent),
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