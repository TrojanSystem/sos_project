import 'package:flutter/foundation.dart';

class HouseModel {
  String title;
  String description;
  String area;
  String type;
  String price;
  String image;
  Map facility;
  String location;
  bool isFavorite = false;
  HouseModel(
      {@required this.description,
      @required this.title,
      @required this.type,
      @required this.price,
      @required this.image,
      @required this.area,
      @required this.facility,
      @required this.isFavorite,
      @required this.location});
}

class HouseData extends ChangeNotifier {
  List<HouseModel> houseList = [
    HouseModel(
      description:
          '140 ካሬ ላይ ያረፈ L ላይ ያለ ለንግድ ሚሆን ቦታ ያለው፣ መብራት እና ዉሃ የገባለት ከበቂ የመኪና መቆሚያ ጋር ለሽያጭ ቀርቧል።',
      title: '140 m\u00B2 House, Dukem ',
      area: '140 m\u00B2',
      facility: {
        'beds': 3,
        'bath': 2,
        'parking': 1,
        'area': '140m\u00B2',
      },
      isFavorite: false,
      location: 'Dukem, Ethiopia',
      image: 'images/house_6.jpg',
      type: 'apartment',
      price: '3,800,000',
    ),
    HouseModel(
        description:
            '140 ካሬ ላይ ያረፈ መንገድ ዳር ላይ ያለ ሶስት ሚከራይ ሰርቪስ ያለው ፣ መብራት እና ዉሃ የገባለት, ከበቂ የመኪና መቆሚያ ጋር ለሽያጭ ቀርቧል።',
        title: '140 m\u00B2 House, Dukem ',
        area: '140 m\u00B2',
        facility: {
          'beds': 3,
          'bath': 3,
          'parking': 1,
          'area': '140m\u00B2',
        },
        isFavorite: false,
        location: 'Dukem, Ethiopia',
        image: 'images/house_2.jpg',
        type: 'house',
        price: '3,800,000'),
    HouseModel(
      description:
          '140 ካሬ ላይ ያረፈ L ላይ ያለ ለንግድ ሚሆን ቦታ ያለው፣ፊኒሺንግ ያለቀለት፣ መብራት እና ዉሃ የገባለት ከበቂ የመኪና መቆሚያ ጋር ለሽያጭ ቀርቧል።',
      title: '140 m\u00B2 House, Dukem ',
      area: '140 m\u00B2',
      facility: {
        'beds': 3,
        'bath': 2,
        'parking': 1,
        'area': '140m\u00B2',
      },
      type: 'house',
      price: '3,800,000',
      isFavorite: false,
      location: 'Dukem, Ethiopia',
      image: 'images/house_3.jpg',
    ),
    HouseModel(
        description:
            '140 ካሬ ላይ ያረፈ L ላይ ያለ ለንግድ ሚሆን ቦታ ያለው፣ መብራት እና ዉሃ የገባለት ከበቂ የመኪና መቆሚያ ጋር ለሽያጭ ቀርቧል።',
        title: '140 m\u00B2 House, Dukem ',
        area: '140 m\u00B2',
        facility: {
          'beds': 3,
          'bath': 2,
          'parking': 1,
          'area': '140m\u00B2',
        },
        isFavorite: false,
        location: 'Dukem, Ethiopia',
        image: 'images/house_4.jpg',
        type: 'house',
        price: '3,800,000'),
    HouseModel(
        description:
            '140 ካሬ ላይ ያረፈ ሚከራይ ሰርቪሶች ያሉት፣ መብራት እና ዉሃ የገባለት ከበቂ የመኪና መቆሚያ ጋር ለሽያጭ ቀርቧል።',
        title: '140 m\u00B2 House, Dukem ',
        area: '140 m\u00B2',
        facility: {
          'beds': 3,
          'bath': 1,
          'parking': 2,
          'area': '140m\u00B2',
        },
        isFavorite: false,
        location: 'Dukem, Ethiopia',
        image: 'images/house_5.jpg',
        type: 'house',
        price: '3,800,000'),
    HouseModel(
        description:
            '200 ካሬ ላይ ያረፈ ልስን ያለቀለት፣ ዉሃ የገባለት ከበቂ የመኪና መቆሚያ ጋር ለሽያጭ ቀርቧል።',
        title: '140 m\u00B2 House, Dukem ',
        area: '140 m\u00B2',
        facility: {
          'beds': 3,
          'bath': 2,
          'parking': 1,
          'area': '140m\u00B2',
        },
        isFavorite: false,
        location: 'Dukem, Ethiopia',
        image: 'images/house_1.jpg',
        type: 'house',
        price: '3,800,000'),
    HouseModel(
        description:
            '200 ካሬ ላይ ያረፈ ከዋናው መንገድ 10M ገባ ያለ ፣መብራት እና ዉሃ የገባለት ከበቂ የመኪና መቆሚያ ጋር ለሽያጭ ቀርቧል።',
        title: '140 m\u00B2 House, Dukem ',
        area: '140 m\u00B2',
        facility: {
          'beds': 3,
          'bath': 2,
          'parking': 1,
          'area': '200m\u00B2',
        },
        isFavorite: false,
        location: 'Dukem, Ethiopia',
        image: 'images/house_7.jpg',
        type: 'house',
        price: '3,800,000'),
    HouseModel(
        description:
            '140 ካሬ ላይ ያረፈ L ላይ ያለ፣ ያለቀለት፣ ለንግድ ሚሆን ቦታ ያለው፣ መብራት እና ዉሃ የገባለት ከበቂ የመኪና መቆሚያ ጋር ለሽያጭ ቀርቧል።',
        title: '140 m\u00B2 House, Dukem ',
        area: '140 m\u00B2',
        facility: {
          'beds': 3,
          'bath': 2,
          'parking': 1,
          'area': '140m\u00B2',
        },
        isFavorite: false,
        location: 'Dukem, Ethiopia',
        image: 'images/house_8.jpg',
        type: 'house',
        price: '3,800,000'),
    HouseModel(
        description:
            '140 ካሬ ላይ ያረፈ L ላይ ያለ፣ ያለቀለት፣ ለንግድ ሚሆን ቦታ ያለው፣ መብራት እና ዉሃ የገባለት ከበቂ የመኪና መቆሚያ ጋር ለሽያጭ ቀርቧል።',
        title: '140 m\u00B2 House, Dukem ',
        area: '140 m\u00B2',
        facility: {
          'beds': 3,
          'bath': 2,
          'parking': 1,
          'area': '140m\u00B2',
        },
        isFavorite: false,
        location: 'Dukem, Ethiopia',
        image: 'images/house_9.jpg',
        type: 'house',
        price: '3,800,000')
  ];
}
