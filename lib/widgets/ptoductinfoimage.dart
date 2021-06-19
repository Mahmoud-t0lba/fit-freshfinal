import 'package:flutter/material.dart';
Padding imageinfo(BuildContext context,String src) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: MediaQuery.of(context).size.height * .35,
      width: MediaQuery.of(context).size.width * .9,
      child: Padding(
        padding: const EdgeInsets.all(12.5),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(
              src,
              fit: BoxFit.cover,
            )),
      ),
    ),
  );
}