import 'package:ada_bread/crediential/registration.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../home_page.dart';
import 'forget_pass.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  final TextEditingController _emailTextController =
      TextEditingController(text: '');
  final TextEditingController _passTextController =
      TextEditingController(text: '');
  final FocusNode _passFocusNode = FocusNode();
  bool _obscureText = true;
  final _loginFormKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _animationController.dispose();
    _emailTextController.dispose();
    _passTextController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();
    super.initState();
  }

  void _submitFormOnLogin() {
    final isValid = _loginFormKey.currentState.validate();
    if (isValid) {}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.blue,
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
                "https://www.dreamgrow.com/wp-content/uploads/2018/11/brokerspic.jpg",
            placeholder: (context, url) => Image.asset(
              'images/back.jpg',
              fit: BoxFit.fill,
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            alignment: FractionalOffset(_animation.value, 0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: ListView(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                const Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Don\'t have an account',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      const TextSpan(text: '    '),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUp(),
                                ),
                              ),
                        text: 'Register',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue.shade300,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Form(
                  key: _loginFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () =>
                            FocusScope.of(context).requestFocus(_passFocusNode),
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailTextController,
                        validator: (value) {
                          if (value.isEmpty || !value.contains("@")) {
                            return "Please enter a valid Email adress";
                          } else {
                            return null;
                          }
                        },
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.black),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //Password

                      TextFormField(
                        focusNode: _passFocusNode,
                        obscureText: _obscureText,
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passTextController,
                        validator: (value) {
                          if (value.isEmpty || value.length < 7) {
                            return "Please enter a valid password";
                          } else {
                            return null;
                          }
                        },
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                          ),
                          hintText: 'Password',
                          hintStyle: const TextStyle(color: Colors.black),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgetPasswordScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Forget password?',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          decoration: TextDecoration.underline,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () async {
                    try {
                      if (_loginFormKey.currentState.validate()) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => const HomePage(),
                          ),
                        );
                      }
                    } catch (e) {}
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(50, 10, 50, 0),
                    width: double.infinity,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Colors.blue[800],
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
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(left: 12),
                        width: double.infinity,
                        height: 3,
                        color: Colors.white,
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
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
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
                        margin: const EdgeInsets.fromLTRB(50, 10, 50, 0),
                        width: double.infinity,
                        height: 50.0,
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
                                  color: Colors.white,
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
