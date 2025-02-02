import "package:flutter/material.dart";
import "package:lighthouse/constants.dart";
import "package:lighthouse/pages/data_entry.dart";

/// A manual counter that counts integers greater than 0.
class NRGSpinbox extends StatefulWidget {
  final String title;
  final String jsonKey;
  final double height;
  final double width;
  const NRGSpinbox(
      {super.key,
      required this.title,
      required this.jsonKey,
      required this.height,
      required this.width});

  @override
  State<NRGSpinbox> createState() => _NRGSpinboxState();
}

class _NRGSpinboxState extends State<NRGSpinbox> {
  String get _title => widget.title;
  String get _key => widget.jsonKey;
  double get _height => widget.height;
  double get _width => widget.width;
  late int _counter;
  String _value = "";
  @override
  Widget build(BuildContext context) {
    return Container(
        height: _height,
        width: _width,
        decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(Constants.borderRadius)),
        child: Column(
          children: [
            Text(_title, style: Constants.comfortaaBold30pt),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        decrement();
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                      )),
                  Text(
                    "$_counter",
                    style: Constants.comfortaaBold30pt,
                  ),
                  IconButton(
                      onPressed: () {
                        increment();
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_up,
                      )),
                ],
              ),
            )
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    _counter = 0;
  }

  void decrement() {
    setState(() {
      if (_counter > 0) {
        _counter--;
        updateState();
      }
    });
  }

  void increment() {
    setState(() {
      _counter++;
      updateState();
    });
  }

  void updateState() {
    _value = _counter.toString();
    DataEntry.exportData[_key] = _value;
  }
}
