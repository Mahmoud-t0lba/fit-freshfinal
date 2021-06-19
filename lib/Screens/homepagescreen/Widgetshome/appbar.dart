import 'package:fit/providers/theme.dart';
import 'package:fit/responsive/screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit/constants.dart';

class CAppBar extends StatelessWidget {
  const CAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: fromRealHeight(25, context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12), bottomRight: Radius.circular(15)),
        color: Provider.of<ThemeCustom>(context).isdark == false
            ? ksecondcolor
            : kmaincolor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ignore: deprecated_member_use
          FlatButton.icon(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Provider.of<ThemeCustom>(context).isdark == false
                    ? secondtextcolor
                    : textmaincolor,
                size: 30,
              ),
              label: Text('')),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'You  need \n  to pimp \n Your diet .',
              style: TextStyle(
                  fontSize: 22.5,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Pacifico',
                  color: Provider.of<ThemeCustom>(context).isdark == false
                      ? secondtextcolor
                      : textmaincolor),
            ),
          )
        ],
      ),
    );
  }
}
