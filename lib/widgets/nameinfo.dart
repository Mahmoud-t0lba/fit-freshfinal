import 'package:fit/model/product.dart';
import 'package:fit/providers/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
Padding nameinfo(Product product, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 30),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          product.pName,
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Provider.of<ThemeCustom>(context).isdark ==
                  false
                  ? secondtextcolor
                  : textmaincolor),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    ),
  );
}