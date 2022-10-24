import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  final TextEditingController _forgetPassTextController =
      TextEditingController(text: '');

  @override
  void dispose() {
    _animationController.dispose();
    _forgetPassTextController.dispose();

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

  void _forgetPasFCT() {
    print('_forgetPassTextController.text ${_forgetPassTextController.text}');
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
                'Forget password',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Email address',
                style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _forgetPassTextController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              GestureDetector(
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
                      'Reset Now',
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
      ],
    ));
  }
}
