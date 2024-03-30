import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RangeSliderTest extends StatefulWidget {
  const RangeSliderTest({super.key});

  @override
  State<StatefulWidget> createState() => _RangeSliderState();
}

class _RangeSliderState extends State<RangeSliderTest> {
  RangeValues currentRange = const RangeValues(0, 100);

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
        values: currentRange,
        max: 100,
        onChanged: (range) {
          setState(() {
            currentRange = range;
          });
        });
  }
}
