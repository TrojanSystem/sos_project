import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../crediential/login.dart';
import '../home_page.dart';
import 'data_provider.dart';

bool _isRegistering = false;

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with TickerProviderStateMixin {
  AnimationController _animationController;
  final _auth = FirebaseAuth.instance;
  Animation<double> _animation;
  final TextEditingController _fullNameController =
      TextEditingController(text: '');
  final TextEditingController _emailTextController =
      TextEditingController(text: '');
  final TextEditingController _passTextController =
      TextEditingController(text: '');

  final TextEditingController _phoneNumberController =
      TextEditingController(text: '');

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passFocusNode = FocusNode();
  final FocusNode _postitionCPFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  bool _obscureText = true;
  final _signUpFormKey = GlobalKey<FormState>();
  File imageFile;
  String userFullName = '';
  String userEmail = '';
  String userPassword = '';
  String userPhone = '';
  @override
  void dispose() {
    _animationController.dispose();
    _fullNameController.dispose();
    _emailTextController.dispose();
    _passTextController.dispose();

    _emailFocusNode.dispose();
    _passFocusNode.dispose();
    _postitionCPFocusNode.dispose();
    _phoneNumberController.dispose();
    _phoneNumberFocusNode.dispose();
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

  void _submitFormOnSignUp() {
    final isValid = _signUpFormKey.currentState.validate();
    if (isValid) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const HomePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: _isRegistering
          ? Center(
              child: SpinKitWave(
                color: Colors.blue[800],
                size: 80.0,
                itemCount: 5,
              ),
            )
          : Stack(
              children: [
                CachedNetworkImage(
                  imageUrl:
                      "https://www.dreamgrow.com/wp-content/uploads/2018/11/brokerspic.jpg",
                  placeholder: (context, url) => Image.network(
                    'https://images.unsplash.com/photo-1585144860106-998ca0f2922a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=604&q=80',
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
                        height: size.height * 0.05,
                      ),
                      const Text(
                        'SignUp',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Already have an account',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            const TextSpan(text: '    '),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (ctx) => Login())),
                              text: 'Login',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Form(
                        key: _signUpFormKey,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    onEditingComplete: () =>
                                        FocusScope.of(context)
                                            .requestFocus(_emailFocusNode),
                                    keyboardType: TextInputType.name,
                                    controller: _fullNameController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "This Field is missing";
                                      } else {
                                        return null;
                                      }
                                    },
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      hintText: 'Full name',
                                      hintStyle: TextStyle(color: Colors.black),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      errorBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                    ),
                                    onSaved: (fullName) {
                                      userFullName = fullName;
                                    },
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: size.width * 0.24,
                                        height: size.width * 0.24,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: imageFile == null
                                              ? Image.network(
                                                  'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png',
                                                  fit: BoxFit.fill,
                                                )
                                              : Image.file(
                                                  imageFile,
                                                  fit: BoxFit.fill,
                                                ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: InkWell(
                                        onTap: () {
                                          _showImageDialog();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.pink,
                                            border: Border.all(
                                                width: 2, color: Colors.white),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              imageFile == null
                                                  ? Icons.add_a_photo
                                                  : Icons.edit_outlined,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            //Email
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_passFocusNode),
                              focusNode: _emailFocusNode,
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailTextController,
                              validator: (value) {
                                if (value.isEmpty || !value.contains("@")) {
                                  return "Please enter a valid Email address";
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
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                              onSaved: (email) {
                                userEmail = email;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            //Password

                            TextFormField(
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_phoneNumberFocusNode),
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
                              style: const TextStyle(color: Colors.white),
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
                              onSaved: (pass) {
                                userPassword = pass;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              focusNode: _phoneNumberFocusNode,
                              textInputAction: TextInputAction.go,
                              keyboardType: TextInputType.phone,
                              controller: _phoneNumberController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "This Field is missing";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (v) {
                                // print(' Phone number ${_phoneNumberController.text}');
                              },
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                hintText: 'Phone number',
                                hintStyle: TextStyle(color: Colors.black),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                              onSaved: (phone) {
                                userPhone = phone;
                              },
                            ),

                            //Position in the company
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (_signUpFormKey.currentState.validate()) {
                            _signUpFormKey.currentState.save();
                            setState(() {
                              _isRegistering = true;
                            });
                            try {
                              _emailTextController.clear();
                              _fullNameController.clear();
                              _passTextController.clear();
                              _phoneNumberController.clear();
                              final user =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: userEmail, password: userPassword);
                              if (user != null) {
                                setState(() {
                                  _isRegistering = false;
                                });
                                FirebaseFirestore.instance
                                    .collection('Members')
                                    .add({
                                  'userFullName': userFullName,
                                  'userEmail': userEmail,
                                  'userPhoneNumber': userPhone,
                                  'loggedDate': DateTime.now().toString()
                                });
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (ctx) => const HomePage(),
                                  ),
                                );
                                setState(() {
                                  Provider.of<DataProvider>(context,
                                          listen: false)
                                      .checker(_auth.currentUser.email);
                                });
                              }
                            } catch (e) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                        'Error Occurred',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      content: Text(e.toString(),
                                          overflow: TextOverflow.visible),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(true);
                                            },
                                            child: const Text('Ok'))
                                      ],
                                    );
                                  });
                              setState(() {
                                _isRegistering = false;
                              });
                            }
                          }
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  void _showImageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Please choose an option'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    _getFromCamera();
                  },
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.camera,
                          color: Colors.purple,
                        ),
                      ),
                      Text(
                        'Camera',
                        style: TextStyle(color: Colors.purple),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _getFromGallery();
                  },
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.image,
                          color: Colors.purple,
                        ),
                      ),
                      Text(
                        'Gallery',
                        style: TextStyle(color: Colors.purple),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    setState(() {
      imageFile = File(pickedFile.path);
    });
    //_cropImage(pickedFile.path);
    Navigator.pop(context);
  }

  void _getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    setState(() {
      imageFile = File(pickedFile.path);
    });
    // _cropImage(pickedFile.path);
    Navigator.pop(context);
  }

  // void _cropImage(filePath) async {
  //   File croppedImage = await ImageCropper()
  //       .cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);
  //   if (croppedImage != null) {
  //     setState(() {
  //       imageFile = croppedImage;
  //     });
  //   }
  // }

  void _showTaskCategoriesDialog({@required Size size}) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              'choose your Jobs',
              style: TextStyle(fontSize: 20, color: Colors.pink.shade800),
            ),
            content: SizedBox(
              width: size.width * 0.9,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (ctxx, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: Colors.red.shade200,
                          ),
                          // SizedBox(width: 10,),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              ' Job',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        });
  }
}
