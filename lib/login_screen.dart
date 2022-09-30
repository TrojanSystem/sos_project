import 'package:ada_bread/forgot_password.dart';
import 'package:ada_bread/register_screen.dart';
import 'package:ada_bread/slide_show.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

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
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                    ),
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
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Icon(Icons.lock_open),
                      ),
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.remove_red_eye_outlined),
                            hintText: 'Password',
                          ),
                        ),
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.only(left: 10, right: 50),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => ForgotPassword(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 18.0),
                        child: Text(
                          'Forgot password ?',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
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
                      'Login',
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
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(left: 12),
                  width: double.infinity,
                  height: 3,
                  color: Colors.grey,
                ),
              ),
              const Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(left: 28.0),
                  child: Text(
                    'OR',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  width: double.infinity,
                  height: 3,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(50, 10, 50, 0),
                  width: double.infinity,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'images/google.png',
                          width: 30,
                        ),
                        const Text(
                          'Login with Google',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'New to SOS?',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                        child: const Text(
                          ' Register',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => RegisterScreen(),
                            ),
                          );
                        }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
