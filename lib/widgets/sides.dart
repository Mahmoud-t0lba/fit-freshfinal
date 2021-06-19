import 'package:fit/model/product.dart';
import 'package:flutter/material.dart';
import 'package:fit/constants.dart';
import 'package:provider/provider.dart';
import 'package:fit/providers/theme.dart';

class Sises extends StatefulWidget {
  final Product product;

  Sises({
    @required this.product,
  });
  @override
  _SisesState createState() => _SisesState();
}

class _SisesState extends State<Sises> {
  List<String> sides = [
   'Basmati rice',
    'Pasta white sauce',
    'Pasta red sauce',
    'Green salad',
    'Suateed vegtables',
    'Mached potato',
    'Coleslaw',
    'Brown bread'
  ];
  String selected1;
  String selected2;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text(
            'Please Choose sides you want with Meal',
            style: TextStyle(
                color: Provider.of<ThemeCustom>(context).isdark == false
                    ? secondtextcolor
                    : textmaincolor),
          ),

        ),SizedBox(height: 7.5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(20)),
              child: DropdownButton(
                  value: selected1,
                  dropdownColor:
                      Provider.of<ThemeCustom>(context).isdark == false
                          ? textmaincolor
                          : secondtextcolor,
                  items: sides
                      .map(
                        (e) => DropdownMenuItem(
                          child: Text(
                            e,
                            style: TextStyle(
                                color:
                                    Provider.of<ThemeCustom>(context).isdark ==
                                            false
                                        ? secondtextcolor
                                        : textmaincolor),
                          ),
                          value: e,
                        ),
                      )
                      .toList(),
                  onChanged: (value) async {
                     setState(() {
                      selected1 = value;
                      widget.product.side1 = value;
                    });
                  }),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(20)),
              child: DropdownButton(
                  dropdownColor:
                      Provider.of<ThemeCustom>(context).isdark == false
                          ? textmaincolor
                          : secondtextcolor,
                  value: selected2,
                  items: sides
                      .map(
                        (e) => DropdownMenuItem(
                          child: Text(
                            e,
                            style: TextStyle(
                                color:
                                    Provider.of<ThemeCustom>(context).isdark ==
                                            false
                                        ? secondtextcolor
                                        : textmaincolor),
                          ),
                          value: e,
                        ),
                      )
                      .toList(),
                  onChanged: (value) async {
                     setState(() {
                      selected2 = value;
                      widget.product.side2 = value;
                    });
                  }),
            ),
          ],
        ),
      ],
    );
  }
}
