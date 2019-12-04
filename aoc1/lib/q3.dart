import 'package:flutter/material.dart';

class Q3Page extends StatefulWidget {
  Q3Page({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Q3PageState createState() => _Q3PageState();
}

class _Q3PageState extends State<Q3Page> {
  static const expectedResult = 19690720;

  var _controller = new TextEditingController();
  var _distance = 0;
  var _wire1PathsCount = 0;
  var _wire2PathsCount = 0;
  var _fewestSteps = 0;

  void _incrementCounter() {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      var wiresPath = _controller.text.split('\n').map((n) => n.split(',')).toList();

      var wire1PathCoodinates = _toCoordinates(wiresPath[0]);
      var wire2PathCoodinates = _toCoordinates(wiresPath[1]);

      _wire1PathsCount = wire1PathCoodinates.length;
      _wire2PathsCount = wire2PathCoodinates.length;

      var intersections = List<Coordinate>();
      for (var i = 1; i < wire1PathCoodinates.length; i++) {
        var c1Start = wire1PathCoodinates[i-1];
        var c1End = wire1PathCoodinates[i];

        for (var j = 1; j < wire2PathCoodinates.length; j++) {
          var c2Start = wire2PathCoodinates[j-1];
          var c2End = wire2PathCoodinates[j];

          var intersection = _calculateIntersection(c1Start.x, c1Start.y, c1End.x, c1End.y, c2Start.x, c2Start.y, c2End.x, c2End.y);
          if (intersection != null) {
            intersections.add(intersection);
          }
        } 
      }

      var distances = intersections
          .map((i) => i.x.abs() + i.y.abs())
          .where((i) => i != 0)
          .toList()
          ..sort();
      
      _distance = distances.first;

      var wire1Steps  = 0;
      var wire2Steps = 0;
      var steps = List<int>();
      for (var i = 1; i < wire1PathCoodinates.length; i++) {
        var c1Start = wire1PathCoodinates[i-1];
        var c1End = wire1PathCoodinates[i];
        
        for (var j = 1; j < wire2PathCoodinates.length; j++) {
          var c2Start = wire2PathCoodinates[j-1];
          var c2End = wire2PathCoodinates[j];                    


          var intersection = _calculateIntersection(c1Start.x, c1Start.y, c1End.x, c1End.y, c2Start.x, c2Start.y, c2End.x, c2End.y);
          if (intersection != null) {
            var wire1IntersectionSteps = c1Start.x == c1End.x ? (intersection.y.abs() - c1Start.y.abs()).abs() : (intersection.x.abs() - c1Start.x.abs()).abs();
            var wire2IntersectionSteps = c2Start.x == c2End.x ? (intersection.y.abs() - c2Start.y.abs()).abs() : (intersection.x.abs() - c2Start.x.abs()).abs();
            steps.add(wire1Steps + wire2Steps + wire1IntersectionSteps + wire2IntersectionSteps);
          } 

          wire2Steps += c2End.size;
        } 

        wire1Steps += c1End.size;
        wire2Steps = 0;
      }

      steps = steps.where((i) => i != 0).toList();
      steps.sort();

      _fewestSteps = steps.first; 
    });

  }

  List<Coordinate> _toCoordinates(List<String> paths) {

      var coordinates = new List<Coordinate>();
      var x = 0, y = 0;
      coordinates.add(new Coordinate(x, y));
      for (var path in paths) {
        var vertex =  _toVertex(path);
        switch (vertex.direction) {
          case 'R':
            x += vertex.size;
            break;
          case 'L':
            x -= vertex.size;
            break;
          case 'D':
            y += vertex.size;
            break;
          case 'U': 
            y -= vertex.size;
            break;
          default:
            throw new FormatException();
        }
        coordinates.add(new Coordinate(x, y, vertex.size));
      }

      return coordinates;
  }

  Vertex _toVertex(String path) {
    var direction =  path.substring(0, 1);
    var distance = int.parse(path.substring(1, path.length));

    return new Vertex(direction, distance);
  }

  Coordinate _calculateIntersection(int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4) {

    // calculate the distance to intersection point
    double uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
    double uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

    // if uA and uB are between 0-1, lines are colliding
    if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {
      return new Coordinate(x1 + (uA * (x2-x1)).ceil(), y1 + (uA * (y2-y1)).ceil());
    }

    return null;
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
                'What is the Manhattan distance from the central port to the closest intersection?',
              ),
              SizedBox(height: 8.0),
              Text(
                'Nearest cross distance is $_distance',
                style: Theme.of(context).textTheme.display4.copyWith(fontSize: 24.0, color: Colors.redAccent),
              ),
              SizedBox(height: 24.0),
              Text(
                'What is the fewest combined steps the wires must take to reach an intersection?',
              ),
              SizedBox(height: 8.0),
              Text(
                'Fewest combined steps is $_fewestSteps',
                style: Theme.of(context).textTheme.display4.copyWith(fontSize: 24.0, color: Colors.redAccent),
              ),
                            SizedBox(height: 24.0),
              Text(
                'Misc',
              ),
              SizedBox(height: 8.0),
              Text(
                'Wire 1 was $_wire1PathsCount long',
                style: Theme.of(context).textTheme.display4.copyWith(fontSize: 24.0, color: Colors.lightBlueAccent),
              ),
              SizedBox(height: 8.0),
              Text(              
                'Wire 2 was $_wire2PathsCount long',
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

class Vertex {
  String direction;
  int size;

  Vertex(this.direction, this.size);
}

class Coordinate {
  int x, y, size;
  Coordinate(this.x, this.y, [this.size]);
}
