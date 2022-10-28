import 'package:ada_bread/front_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final _auth = FirebaseAuth.instance;

var loggedInUser;

class BottomUserInfo extends StatefulWidget {
  final bool isCollapsed;

  BottomUserInfo({
    Key key,
    this.isCollapsed,
  }) : super(key: key);

  @override
  State<BottomUserInfo> createState() => _BottomUserInfoState();
}

class _BottomUserInfoState extends State<BottomUserInfo> {
  @override
  void initState() {
    getCurrentUser();
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user.email;
      }
    } catch (e) {
      print(e);
    }
  }

  String currentUser = '';

  String currentUserName = '';

  String currentProfilePic = '';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Members').snapshots(),
        builder: (context, logged) {
          if (!logged.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final loggedUser = logged.data.docs;
            for (var message in loggedUser) {
              if (message['userEmail'] == loggedInUser) {
                currentUser = message['userEmail'];
                currentUserName = message['userFullName'];
                currentProfilePic = message['profilePic'];
              }
            }
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: widget.isCollapsed ? 70 : 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(20),
              ),
              child: widget.isCollapsed
                  ? Center(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  currentProfilePic,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      currentUserName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  child: Text(
                                    'MEMBER',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: IconButton(
                                onPressed: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (context) => StatefulBuilder(
                                        builder: (context, setState) {
                                      return AlertDialog(
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
                                                Navigator.of(context)
                                                    .pop(false), //<-- SEE HERE
                                            child: const Text('No'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              await _auth.signOut();
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const FrontScreen(),
                                                ),
                                              );
                                              // Navigator.pop(context);
                                            },
                                            // <-- SEE HERE
                                            child: const Text('Yes'),
                                          ),
                                        ],
                                        backgroundColor:
                                            Colors.black.withOpacity(0.3),
                                      );
                                    }),
                                  );
                                },
                                icon: const Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                currentProfilePic,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () async {
                              await showDialog(
                                context: context,
                                builder: (context) => StatefulBuilder(
                                    builder: (context, setState) {
                                  return AlertDialog(
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
                                        onPressed: () => Navigator.of(context)
                                            .pop(false), //<-- SEE HERE
                                        child: const Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await _auth.signOut();
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const FrontScreen(),
                                            ),
                                          );
                                        },
                                        // <-- SEE HERE
                                        child: const Text('Yes'),
                                      ),
                                    ],
                                    backgroundColor:
                                        Colors.black.withOpacity(0.3),
                                  );
                                }),
                              );
                            },
                            icon: const Icon(
                              Icons.logout,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
            );
          }
        });
  }
}
