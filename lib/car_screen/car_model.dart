import 'package:flutter/foundation.dart';

class CarModel {
  String title;
  String description;
  String make;
  String type;
  String color;
  String image;
  String exchangePossible;
  String condition;

  String fuel;
  String location;
  String capacity;
  String transmission;
  String year;
  String price;
  String mileage;
  bool isFavorite = false;
  CarModel({
    @required this.type,
    @required this.price,
    @required this.image,
    @required this.description,
    @required this.location,
    @required this.title,
    @required this.isFavorite,
    @required this.year,
    @required this.capacity,
    @required this.color,
    @required this.condition,
    @required this.exchangePossible,
    @required this.fuel,
    @required this.make,
    @required this.mileage,
    @required this.transmission,
  });
}

class CarData extends ChangeNotifier {
  List<CarModel> carList = [
    CarModel(
      type: 'Toyota',
      price: '1,000,000',
      image: 'images/car_4.jpg',
      description: 'ምንም ግጭት የሌለባት ',
      location: 'Adama, Ethiopia',
      title: 'Vitz 2006',
      isFavorite: false,
      year: '2006',
      capacity: '1000 cc',
      color: 'Silver',
      condition: 'Ethiopia Used',
      exchangePossible: 'No',
      fuel: 'Benzene',
      make: 'Toyota',
      mileage: '1500',
      transmission: 'Auto',
    ),
    CarModel(
      type: 'Suzuki',
      price: '250,000',
      image: 'images/car_3.jpg',
      description: 'ምንም ግጭት የሌለባት, አስራ ሁለት ሺ ቤት ',
      location: 'Dukem, Ethiopia',
      title: 'TVS Bajaj',
      isFavorite: false,
      year: '2006',
      capacity: '200 cc',
      color: 'Blue',
      condition: 'Used',
      exchangePossible: 'No',
      fuel: 'Benzene',
      make: 'TVS',
      mileage: '150',
      transmission: 'Auto',
    ),
    CarModel(
      type: 'Mazda',
      price: '1,100,000',
      image: 'images/car_5.png',
      description: 'ምንም ግጭት የሌለባት, ሞተሯ የታደሰ ',
      location: 'Adama, Ethiopia',
      title: 'Isuzu 2001',
      isFavorite: false,
      year: '2001',
      capacity: '2400 cc',
      color: 'White',
      condition: 'Ethiopia Used',
      exchangePossible: 'No',
      fuel: 'Diesel',
      make: 'Isuzu',
      mileage: '70,000',
      transmission: 'Manual',
    ),
  ];
}
