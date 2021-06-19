class Imageeees {
  String image1;
  String image2;
  String image3;
  String image4;
  String image5;
  String image6;
  String id;
  Imageeees(
      {this.image1,
      this.image2,
      this.image3,
      this.image4,
      this.image5,
      this.image6,
      this.id});

  Imageeees.tojson(Map json) {
    image1 = json['image1'];
    image2 = json['image2'];
    image3 = json['image3'];
    image4 = json['image4'];
    image5 = json['image5'];
    image6 = json['image6'];
  }
}
