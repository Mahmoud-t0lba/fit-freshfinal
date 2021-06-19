

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit/constants.dart';
import 'package:fit/model/images.dart';
import 'package:flutter/material.dart';
import 'package:fit/services/store.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class HighLight extends StatefulWidget {

  @override
  _HighLightState createState() => _HighLightState();
}

class _HighLightState extends State<HighLight> {
final _store=Store();
  List<String> high=[
    'assets/images/fit.png'
  ];

  @override



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(stream: _store.loadHomeScreen(),builder: (context,snapshot){
      if (snapshot.hasData){
        List<Imageeees> images=[];
        for(var doc in snapshot.data.docs)
        {
          var data = doc.data();
    images.add(Imageeees(
      id: doc.id,
      image6: data[kimage6],
      image5: data[kimage5],
      image4: data[kimage4],
      image3: data[kimage3],
      image2: data[kimage2],
      image1: data[kimage1],


    ));


        }
        List <String>widgts=[

          images.first.image1,
          images.first.image2,
          images.first.image3,
          images.first.image4,
          images.first.image5,
          images.first.image6,

        ];

        return Container(height: MediaQuery.of(context).size.height*.38,
          width: MediaQuery.of(context).size.width,
          child: Swiper(layout: SwiperLayout.DEFAULT,
            itemHeight: 380,
            itemWidth: 300,
            onIndexChanged: (int i) {
              i = 0;
              i++;
            },

            itemCount: widgts.length,viewportFraction: .8,scale: .9,autoplay:true,

            itemBuilder: ( context , index)
            {


              return Container(

                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child:

                    Image.network(widgts[index],fit: BoxFit.cover,),




                  ));
            },

          ),
        );
      }
      else{
        return Text('no images yet');
      }

    },

    );

  }

}
