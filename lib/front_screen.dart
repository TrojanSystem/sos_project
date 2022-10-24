import 'package:ada_bread/crediential/login.dart';
import 'package:flutter/material.dart';

import 'crediential/registration.dart';

class FrontScreen extends StatelessWidget {
  const FrontScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Container(
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                'images/images.jpg',
                fit: BoxFit.fill,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40), color: Colors.red),
              margin: const EdgeInsets.fromLTRB(15, 15, 15, 30),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                const Text(
                  'Discover dream house',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 25,
                  ),
                ),
                const Text(
                  'from smartphone',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'The No. 1 app for searching and finding',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const Text(
                  'the most suitable things with you.',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => SignUp(),
                    ));
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(50, 10, 50, 0),
                    width: double.infinity,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Colors.green[500],
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: const Center(
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(color: Colors.black),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => Login(),
                    ));
                  },
                  child: const Text(
                    'Log In',
                    style: TextStyle(color: Colors.blue),
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
