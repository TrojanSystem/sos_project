import 'package:ada_bread/buttons/slide_show.dart';
import 'package:ada_bread/crediential/forgot_password.dart';
import 'package:ada_bread/crediential/register_screen.dart';
import 'package:ada_bread/home_page.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _hidden = true;
  String loggedUserEmail = '';
  String loggedUserPassword = '';
  final formLoginKey = GlobalKey<FormState>();
  final TextEditingController _emailControl = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final TextEditingController _passwordControl = TextEditingController();
  @override
  void dispose() {
    _emailFocus.dispose();
    _emailControl.dispose();
    _passwordControl.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 1.05,
          child: Form(
            key: formLoginKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  flex: 2,
                  child: SlideShow(),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
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
                                      controller: _emailControl,
                                      focusNode: _emailFocus,
                                      textInputAction: TextInputAction.next,
                                      onEditingComplete: () =>
                                          FocusScope.of(context)
                                              .requestFocus(_passwordFocus),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Email can\'t be empty';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onSaved: (value) {
                                        loggedUserEmail = value;
                                      },
                                      decoration: const InputDecoration(
                                        hintText: 'Email ID',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              margin:
                                  const EdgeInsets.only(left: 10, right: 50),
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
                                      controller: _passwordControl,
                                      focusNode: _passwordFocus,
                                      textInputAction: TextInputAction.go,
                                      obscureText: _hidden,
                                      obscuringCharacter: '*',
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Email can\'t be empty';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onSaved: (value) {
                                        loggedUserPassword = value;
                                      },
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _hidden = !_hidden;
                                            });
                                          },
                                          icon: Icon(_hidden
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                        ),
                                        hintText: 'Password',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              margin:
                                  const EdgeInsets.only(left: 10, right: 50),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) =>
                                            const ForgotPassword(),
                                      ),
                                    );
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.only(right: 18.0),
                                    child: Text(
                                      'Forgot password ?',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () async {
                                try {
                                  if (formLoginKey.currentState.validate()) {
                                    formLoginKey.currentState.save();
                                    _passwordControl.clear();
                                    _emailControl.clear();
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (ctx) => const HomePage(),
                                      ),
                                    );
                                  }
                                } catch (e) {}
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.fromLTRB(50, 10, 50, 0),
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
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => const HomePage(),
                                  ),
                                );
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.fromLTRB(50, 10, 50, 0),
                                width: double.infinity,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                                          builder: (ctx) =>
                                              const RegisterScreen(),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
