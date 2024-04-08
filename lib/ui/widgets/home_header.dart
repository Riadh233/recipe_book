import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget{
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Material(
              elevation: 4.0, // Adjust elevation as needed (higher for more shadow)
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0), // Adjust radius as needed
              ),
              child: Container(
                width: 30,
                height: 30,
                color: Colors.red,
              ),
            ),

            Icon(Icons.notifications_active_outlined,size: 30,)
          ],
        )
      ],
    );
  }

}