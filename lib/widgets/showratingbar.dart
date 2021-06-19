import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Padding ratingbar(context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        RatingBar(
          initialRating: 4.5,
          minRating: 2,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          unratedColor: Colors.grey,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            return _showMaterialDialog(rating, context);
          },
        ),
      ],
    ),
  );
}

_showMaterialDialog(double a, context) {
  String r;
  if (a == 5 || a == 4) {
    r = 'Fit&Fresh  will strive to maintain this confidence . ';
  } else if (a == 3) {
    r = 'ًWe will do our best To satisfy you next time .';
  } else {
    r = 'Opps ! FIt&Fresh very sorry and we will try improve that item . ';
  }
  showDialog(
      context: context,
      builder: (_) => new AlertDialog(
            title: new Text("Thank You ! "),
            content: Text(
              r,
              style: TextStyle(fontSize: 22),
            ),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                child: Text('Close me'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
}
