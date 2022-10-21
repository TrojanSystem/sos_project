import 'package:flutter/material.dart';

class LoanBank extends StatelessWidget {
  String loanBank;
  LoanBank({@required this.loanBank});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$loanBank'),
      ),
    );
  }
}
