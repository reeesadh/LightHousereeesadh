import 'dart:async';

import 'package:flutter/material.dart';

class NRGStopwatch extends StatefulWidget {
  NRGStopwatch({super.key});

  final String title = "Stopwatch";
  final String height = "100";
  final String width = "400";

  final stopwatch = Stopwatch();

  @override
  State<NRGStopwatch> createState() => _NRGCheckboxState();
}

class _NRGCheckboxState extends State<NRGStopwatch> {
  Stopwatch get _stopwatch => widget.stopwatch;
  String get _height => widget.height;
  String get _width => widget.width;

  //usually, it is enough to just use "double.parse(_height/_width)", but here, 
  //it is used enough times that it's worth it to just make them 
  //individual variables of their own. Due to this however you need to *restart* the 
  //app to see any changes to the dimensions, not just hot reload it. 
  //(I know on vscode you can just press the green circle-arrow to do this. )
  late final double height;
  late final double width;

  //We need this so that we can call setState and have the stopwatch text change. 
  late Duration stopwatchResult;

  @override
  void initState() {
    super.initState();
    _stopwatch.reset();
    height = double.parse(_height);
    width = double.parse(_width);

    stopwatchResult = _stopwatch.elapsed;

    Timer.periodic(const Duration(milliseconds: 100), (timer){
      setState(() {
        stopwatchResult = _stopwatch.elapsed;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(color: Colors.blueGrey,borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: height * 0.1),
            height: height * 0.8, 
            width: width * 0.6,
            decoration: BoxDecoration(color: Colors.white), 
            child: Center(
              child: Text(
                "${stopwatchResult.inMinutes} : ${stopwatchResult.inSeconds} : ${(stopwatchResult.inMilliseconds / 100).toInt()}", 
                textAlign: TextAlign.center,
                textScaler: TextScaler.linear(height * 3/100), //For development, we can change the height without having to change this too. 
              ),
            ), 
          ),
          Container(
            margin: EdgeInsets.only(left: width * 6/400), //For development, we can change the width without having to change this too. 
            child: IconButton(
              onPressed: () {_stopwatch.stop(); _stopwatch.reset();},
              icon: Icon(
                IconData(0xe514, fontFamily: 'MaterialIcons'), 
                size: 45,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 0), 
            child: IconButton(
              onPressed: _stopwatch.start,
              icon: Icon(
                IconData(0xf2af, fontFamily: 'MaterialIcons'), 
                size: 45,
              ),
            ),
          ),  
        ],
      ),
    );
  }
}