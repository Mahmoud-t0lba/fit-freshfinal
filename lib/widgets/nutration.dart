import 'package:fit/model/product.dart';
import 'package:flutter/material.dart';
class Nutration extends StatelessWidget {
  const Nutration({
    Key key,
    @required this.product,
    this.color,
    this.name
    ,this.n
  }) : super(key: key);

  final Product product;
  final String name;
  final Color color;
  final String n;
  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        ClipOval(child: Container(height: 10,width: 10,color: color,),),
        Text(name+' =' ,style: TextStyle(color: color),),
        Text(n,style: TextStyle(color: color),)
      ],
    );
  }
}
Padding secondnutration(Product product, BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(left: 15),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 10,
          ),
          Nutration(
            product: product,
            name: 'Fats',
            n: product.fat,
            color: Colors.green,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .2,
          ),
          Nutration(
            product: product,
            name: "Carbs",
            n: product.carbs,
            color: Colors.teal,
          )
        ],
      ),
    ),
  );
}

Padding fristnutration(Product product, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 15),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Nutration(
                product: product,
                name: 'Calories',
                n: product.cal,
                color: Colors.blueAccent.shade700,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .2,
              ),
              Nutration(
                product: product,
                name: 'Protien',
                n: product.protin,
                color: Colors.deepPurple,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
