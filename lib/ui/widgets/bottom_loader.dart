import 'package:flutter/material.dart';

class BottomLoader extends StatelessWidget{
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.all(4.0),
        child: SizedBox(
          height: 30,
          child: CircularProgressIndicator(),
        ),
      );
  }
}