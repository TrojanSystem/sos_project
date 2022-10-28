import 'package:ada_bread/crediential/login.dart';
import 'package:flutter/material.dart';

import 'crediential/registration.dart';

class FrontScreen extends StatefulWidget {
  const FrontScreen({Key key}) : super(key: key);

  @override
  State<FrontScreen> createState() => _FrontScreenState();
}

class _FrontScreenState extends State<FrontScreen> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Are you sure?',
              style: TextStyle(color: Colors.white),
            ),
            content: const Text(
              'Do you want to exit an App',
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), //<-- SEE HERE
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(true), // <-- SEE HERE
                child: const Text('Yes'),
              ),
            ],
            backgroundColor: Colors.black.withOpacity(0.3),
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                        builder: (ctx) => const SignUp(),
                      ));
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(50, 10, 50, 0),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.05,
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
                        builder: (ctx) => const Login(),
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
      ),
    );
  }
}
