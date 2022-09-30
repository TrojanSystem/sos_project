import 'package:ada_bread/slide_show.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            flex: 2,
            child: SlideShow(),
          ),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Forgot',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Password?',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: const [
                      Text(
                        'Dont worry! It happens.',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Please enter your email address.',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Icon(Icons.alternate_email_outlined),
                      ),
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Email ID',
                          ),
                        ),
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.only(left: 10, right: 50),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(50, 10, 50, 0),
                  width: double.infinity,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.blue[500],
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: const Center(
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
