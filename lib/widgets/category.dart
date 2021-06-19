import 'package:flutter/material.dart';
import 'package:fit/widgets/productview.dart';
import 'package:provider/provider.dart';
import 'package:fit/constants.dart';
import 'package:fit/providers/theme.dart';

Column categoryByName(String category) {
  return Column(
    children: [
      Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                category,
                style: TextStyle(
                    color: Provider.of<ThemeCustom>(context).isdark == false
                        ? secondtextcolor
                        : textmaincolor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 45,
      ),
      Builder(builder: (context) {
        return Container(
            height: MediaQuery.of(context).size.height * .425,
            width: MediaQuery.of(context).size.width,
            child: productview(category));
      })
    ],
  );
}
