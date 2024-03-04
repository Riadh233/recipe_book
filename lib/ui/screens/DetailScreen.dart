import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../domain/model/recipe.dart';

class DetailScreen extends StatelessWidget {
  final Recipe recipe;

  DetailScreen(this.recipe, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            CachedNetworkImage(
                imageUrl: recipe.image!.REGULAR.url,
                height: 300,
                width: double.infinity,
                fit: BoxFit.fill),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.amber,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.black,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
                left: 0,
                right: 0,
                top: 280,
                child:Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(28.0),topRight: Radius.circular(28.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: const SizedBox(
                     width:double.infinity,
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
