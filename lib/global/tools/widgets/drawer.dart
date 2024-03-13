import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:local_event_finder/global/firebase/firebase_auth_helper.dart';
import 'package:local_event_finder/global/tools/constants/constant_helper.dart';
import 'package:local_event_finder/modules/Favorites/favorites.dart';
import 'package:local_event_finder/modules/home/home_page.dart';
import 'package:local_event_finder/modules/local_event_list/local_event_list.dart';
import 'package:local_event_finder/modules/local_event_map/widget/local_event_map.dart';
import 'package:local_event_finder/modules/sign_in_up/sign_in_up_page.dart';

class AppMainDrawer extends StatefulWidget {
  const AppMainDrawer({super.key});

  @override
  State<AppMainDrawer> createState() => _AppMainDrawerState();
}

class _AppMainDrawerState extends State<AppMainDrawer> {
  late String userName;

  late String driverName;

  bool isUserInfoLoaded = false;

  @override
  void initState() {
    // DriverManager().getDriverData().then((value) => {
    //       userName = value!['driver']['password'] ?? '',
    //       print('DriverValues from Sidebar: $value')
    //     });
    super.initState();
    print("user info = ${ConstantHelper.user?.displayName}");
  }

  Future<void> _showLogoutConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseAuthHelper.firebaseSignOut().then((value) {
                  if (value == true) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInUpPage(),
                      ),
                    );
                  }
                });
              },
              child: const Text('Log Out'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 89, 145, 250),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                  margin: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24.0),
                                    color: Colors.white,
                                  ),
                                  child: const Icon(Icons.close,
                                      color: Color(0xff024562), size: 24.0)),
                            ),
                          ),
                          Text('${ConstantHelper.user?.displayName}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          const SizedBox(
                            height: 12,
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: .2,
                          )
                        ],
                      ),
                    ),
                    ListTile(
                        leading: const Icon(
                          Icons.person_outline_rounded,
                          color: Colors.white,
                        ),
                        title: Text('Profil',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        }),
                    ListTile(
                      leading: const Icon(
                        Icons.map_rounded,
                        color: Colors.white,
                      ),
                      title: Text('Local Events Map',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => LocalEventMap()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.list_alt_rounded,
                        color: Colors.white,
                      ),
                      title: Text('Local Events list',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => LocalEventList()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
                      title: Text('Favorites',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Favorites()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: ()async {
                                await _showLogoutConfirmationDialog();

            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15, right: 5, left: 15),
                  child: Icon(Icons.logout, color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15, right: 5),
                  child: Text('Log out', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          )

          // GestureDetector(
          //   onTap: () => HomeScreenController().showLogoutModal(ctx: context),
          //   child: Container(
          //     alignment: Alignment.bottomLeft,
          //     padding: const EdgeInsets.only(left: 12.0, bottom: 24.0),
          //     child: Container(
          //       padding:
          //           const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(120.0),
          //         color: Colors.white.withOpacity(.2),
          //       ),
          //       child: Row(
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           Icon(
          //             Icons.logout_outlined,
          //             color: Colors.white,
          //           ),
          //           SizedBox(
          //             width: 12,
          //           ),
          //           Text('Se déconnecter',
          //               style: TextStyle(
          //                   fontSize: ConstantsHelper.sizex12,
          //                   fontWeight: FontWeight.bold,
          //                   color: Colors.white))
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
