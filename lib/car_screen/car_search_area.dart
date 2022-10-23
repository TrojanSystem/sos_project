import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../collection_methods.dart';

class CarSearchArea extends StatelessWidget {
  const CarSearchArea({
    Key key,
    @required this.newRate,
  }) : super(key: key);

  final RangeValues newRate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromRGBO(92, 107, 192, 1),
            const Color.fromRGBO(92, 107, 192, 1).withOpacity(0.9)
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0, bottom: 10),
            child: Text(
              'Let\'s Find Car as ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 28.0),
            child: Text(
              'your pocket ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  child: TextFormField(
                    textInputAction: TextInputAction.go,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.search_outlined,
                        color: Colors.white,
                      ),
                      hintText: 'Search a car...',
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  margin: const EdgeInsets.fromLTRB(30, 18, 30, 8),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue[800],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    onPressed: () {
                      searchFilter(context, newRate);
                    },
                    icon: const Icon(
                      MdiIcons.filter,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
