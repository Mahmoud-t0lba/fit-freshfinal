import 'package:fit/Screens/productinfo.dart';
import 'package:fit/model/product.dart';
import 'package:fit/services/store.dart';
import 'package:fit/widgets/custom_cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit/constants.dart';
import 'package:fit/providers/theme.dart';
class Cart150 extends StatefulWidget {
  static const String id = "cart150";

  @override
  _Cart150State createState() => _Cart150State();
}

class _Cart150State extends State<Cart150> {
  Store _store = Store();




  @override
  Widget build(BuildContext context) {
    final name = ModalRoute.of(context).settings.arguments;
    final theme = Provider.of<ThemeCustom>(context);

    return Scaffold(backgroundColor: theme.isdark == true ? kmaincolor : ksecondcolor,
        appBar: AppBar(backgroundColor:theme.isdark == true ? kmaincolor : ksecondcolor ,

          title: Padding(
            padding: const EdgeInsets.only(left: 15,top: 10,bottom: 10),
            child: Row(
              children: [
                Center(
                  child: Text(
                    name,
                    style: TextStyle(
                        fontSize: 22.5,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Pacifico',
                        color: Provider.of<ThemeCustom>(context).isdark == false
                            ? secondtextcolor
                            : textmaincolor),
                  ),
                ),
                SizedBox(width: 6,),
                Icon(Icons.food_bank,color: Colors.lightGreen,)
              ],
            ),
          ),
        ),
        body: StreamBuilder(
          stream: _store.editProducts(),
          builder: (context, snapshot) {
            List<Product> products = [];
            if (snapshot.hasData) {
              for (var product in snapshot.data.docs) {
                final data = product.data();
                if (data['category'] == name &&data['size'] == '150 GM' ) {
                  products.add(
                    Product(
                      pid: product.id,
                      pName:data['name'],
                      pCategory: data['category'],
                      pLink: data['link'],
                      pPrice: data['price'],
                      pDiscribtion: data['discribtion'],
                      pQuantity: 1,
                      cal: data[kcal],
                      fat: data['fats'],
                      protin: data['protin'],
                      size: data['size'],
                      price2: data['price2'],
                      carbs: data['carbs'],


                    ),
                  );
                  print(data);
                }




              }
              return GridView.builder(

                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: CustomCartItem(

                      onPressed: (){
                        Navigator.pushNamed(context, ProductInfo.id,arguments: products[index]);
                      },
                      image: products[index].pLink,
                      product: products[index],
                      name: products[index].pName,
                      calories: products[index].cal,
                      price: products[index].pPrice,
                    ),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green,
              ),
            );
          },
        ));
  }

}

