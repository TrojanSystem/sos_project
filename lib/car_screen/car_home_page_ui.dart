import 'package:ada_bread/car_screen/car_model.dart';
import 'package:flutter/material.dart';

import 'list_of_available_car.dart';

class CarBrandsList extends StatelessWidget {
  CarBrandsList({
    Key key,
    @required this.carBrand,
    @required this.carList,
  }) : super(key: key);

  final List<String> carBrand;
  final List<CarModel> carList;
  List<String> carBrands = [
    'Tesla',
    'Honda',
    'Ford',
    'Mazda',
    'Toyota',
    'Suzuki'
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              ' Brands',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: ListView.builder(
            itemBuilder: (context, index) {
              final carBrandList = carList
                  .where((element) => element.type == carBrands[index])
                  .toList();

              return GestureDetector(
                onTap: () {
                  print(carBrands[index]);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) =>
                          ListOfAvailableCars(carType: carBrandList)));
                },
                child: Container(
                  width: 80,
                  margin: const EdgeInsets.all(10),
                  child: Material(
                    //shadowColor: Colors.grey[200],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    elevation: 50,
                    child: Image.asset(
                      'images/${carBrand[index]}',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            },
            itemCount: carBrand.length,
            scrollDirection: Axis.horizontal,
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromRGBO(40, 53, 147, 1),
                  const Color.fromRGBO(40, 53, 147, 1).withOpacity(0.9)
                ],
              ),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'New Cars',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                MaterialButton(
                  color: Colors.blue[800],
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.blue[800]),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => ListOfAvailableCars(carType: carList),
                      ),
                    );
                  },
                  child: const Text(
                    'More',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
