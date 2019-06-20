import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> with TickerProviderStateMixin {
  double _value = 0.0;
  double _rotationAngle = 0;
  AnimationController _rotationController;

  void _sliderChanged(double newValue) {
    setState(() {
      _rotationAngle = 12 * (newValue - _value) * -pi;
      _value = newValue;
    });
  }

  double _xcoord() {
    double width = MediaQuery.of(context).size.width;
    return ((_value - 0.5) * (width - 100));
  }

  @override
  void initState() {
    _rotationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        title: Text('Baloon Slider'),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Choose balloon quantity',
                style: TextStyle(fontSize: 60, fontFamily: 'Comic', color: Colors.white),
                textAlign: TextAlign.left,
              ),
              Spacer(),
              Padding(padding: EdgeInsets.all(32)),
              AnimatedContainer(
                transform: Matrix4.translationValues(_xcoord(), 0, 0),
                duration: Duration(milliseconds: 100),
                child: AnimatedContainer(
//                  transform: Transform.rotate(angle: _rotationAngle),
                  transform: Matrix4.rotationZ(_rotationAngle),
                  duration: Duration(milliseconds: 150),
                  child: Transform.scale(
                    scale: _value + 1,
                    alignment: Alignment(0.0, _value * 2),
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Image(
                            image: AssetImage('assets/balloon.png'),
                            color: Colors.red,
                          ),
                          Column(
                            children: <Widget>[
                              Spacer(flex: 1),
                              Text('${(_value * 100).floor()}',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                              Spacer(flex: 2),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.all(16)),
              Slider(
                value: _value,
                onChanged: _sliderChanged,
                onChangeEnd: _sliderChanged,
                activeColor: Colors.red,
                inactiveColor: Colors.grey,
              ),
              Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 180,
                  height: 50,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0))),
                    color: Colors.red,
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.navigate_next,
                              size: 30, color: Colors.white),
                          Text('Next',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
