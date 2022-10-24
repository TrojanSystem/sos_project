import 'package:ada_bread/buying_process/loan_bank.dart';
import 'package:flutter/material.dart';

import 'buying_process/cash_buyer.dart';

String dropdownvalue = 'Abyssinia';

// List of items in our dropdown menu
var items = [
  'Abyssinia',
  'Awach',
  'Birhan',
  'CBE',
  'Dashen',
];
Future<dynamic> buyingProcess(BuildContext context) {
  return showDialog(
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return AlertDialog(
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const CashBuyer(),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromRGBO(40, 53, 147, 1),
                      const Color.fromRGBO(40, 53, 147, 1).withOpacity(0.9)
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 4,
                      offset: const Offset(4, 8), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.fromLTRB(16.0, 8, 8, 8),
                child: Row(
                  children: [
                    Image.asset(
                      'images/cash-bag.png',
                      width: 33,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'CASH',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromRGBO(40, 53, 147, 1),
                    const Color.fromRGBO(40, 53, 147, 1).withOpacity(0.9)
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 4,
                    offset: const Offset(4, 8), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.fromLTRB(16.0, 8, 8, 8),
              child: Row(
                children: [
                  Image.asset(
                    'images/loan.png',
                    width: 33,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'LOAN',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.04,
                  ),
                  DropdownButton(
                    // Initial Value
                    value: dropdownvalue,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                    // Down Arrow Icon
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownvalue = newValue;
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => LoanBank(loanBank: dropdownvalue),
                          ),
                        );
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
          title: const Text('Buying Process'),
          alignment: Alignment.center,
        );
      });
    },
  );
}

void searchFilter(BuildContext context, RangeValues newRate) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Type',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    child: const Center(
                      child: Text('Location'),
                    ),
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Price Range',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  RangeSlider(
                      values: newRate,
                      labels: RangeLabels('${newRate.start}', '${newRate.end}'),
                      min: 0,
                      max: 100.0,
                      divisions: 5,
                      onChanged: (newRating) {
                        setState(() {
                          newRate = newRating;
                        });
                      }),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.fromLTRB(50, 10, 50, 0),
                  width: double.infinity,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.blue[500],
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: const Center(
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
      });
}
