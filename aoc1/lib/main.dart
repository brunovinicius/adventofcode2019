import 'package:aoc1/q1.dart';
import 'package:aoc1/q2.dart';
import 'package:aoc1/q3.dart';
import 'package:flutter/material.dart';

void main() => runApp(AdventOfCode2019App());

class AdventOfCode2019App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advent of Code 2019',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.greenAccent,
        brightness: Brightness.dark,
      ),
      home: MainPage(title: 'Advent of Code 2019'),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              "Questions",
              style: Theme.of(context).textTheme.headline,
            ),
          ),
          ListTile(
            title: Text('Question 1'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Q1Page(title: "Question 1")),
            ),
          ),
          ListTile(
            title: Text('Question 2'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Q2Page(title: "Question 2")),
            ),
          ),
          ListTile(
            title: Text('Question 3'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Q3Page(title: "Question 3")),
            ),
          ),
        ],
      ),
    );
  }
}
