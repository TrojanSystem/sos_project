import 'package:ada_bread/login_screen.dart';
import 'package:ada_bread/slide_show.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key key}) : super(key: key);

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
                    'Sign up',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Icon(Icons.person),
                      ),
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Username',
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
                        child: Icon(Icons.alternate_email),
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
                const SizedBox(
                  height: 10,
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
                      'Continue',
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
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Joined us before?',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }
}
