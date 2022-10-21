import 'package:ada_bread/buttons/slide_show.dart';
import 'package:ada_bread/crediential/login_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _hidePass = true;
  String registeredUserName = '';
  String registeredUserEmail = '';
  String registeredUserPassword = '';
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailRegisterControl = TextEditingController();
  final FocusNode _emailRegisterFocus = FocusNode();
  final TextEditingController _userNameRegisterControl =
      TextEditingController();
  final FocusNode _userNameRegisterFocus = FocusNode();
  final FocusNode _passwordRegisterFocus = FocusNode();
  final TextEditingController _passwordRegisterControl =
      TextEditingController();
  @override
  void dispose() {
    _userNameRegisterControl.dispose();
    _userNameRegisterFocus.dispose();
    _emailRegisterFocus.dispose();
    _emailRegisterControl.dispose();
    _passwordRegisterControl.dispose();
    _passwordRegisterFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 1.05,
          child: Form(
            key: formKey,
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 30),
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
                                controller: _userNameRegisterControl,
                                focusNode: _userNameRegisterFocus,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(_emailRegisterFocus),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Username can\'t be empty';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  registeredUserName = value;
                                },
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
                                controller: _emailRegisterControl,
                                focusNode: _emailRegisterFocus,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(_passwordRegisterFocus),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Email can\'t be empty';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  registeredUserEmail = value;
                                },
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
                                obscureText: _hidePass,
                                obscuringCharacter: '*',
                                controller: _passwordRegisterControl,
                                focusNode: _passwordRegisterFocus,
                                textInputAction: TextInputAction.go,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Password can\'t be empty';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  registeredUserPassword = value;
                                },
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _hidePass = !_hidePass;
                                        });
                                      },
                                      icon: Icon(_hidePass
                                          ? Icons.visibility_off
                                          : Icons.visibility)),
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
                      GestureDetector(
                        onTap: () async {
                          try {
                            if (formKey.currentState.validate()) {
                              formKey.currentState.save();
                              //   Navigator.of(context).push(
                              //     MaterialPageRoute(
                              //       builder: (ctx) => const HomePage(),
                              //     ),
                              //   );
                            }
                          } catch (e) {}
                        },
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
          ),
        ),
      ),
    );
  }
}
