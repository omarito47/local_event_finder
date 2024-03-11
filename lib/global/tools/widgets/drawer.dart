import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:local_event_finder/global/tools/constants/constant_helper.dart';

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
                          // const Text('Bienvenue chez BRP',
                          //     style: TextStyle(
                          //         fontWeight: FontWeight.bold,
                          //         color: Colors.white)),
                          // const SizedBox(
                          //   height: 12,
                          // ),
                          Container(
                            padding: const EdgeInsets.only(
                                right: 24, left: 4, top: 4, bottom: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(120.0),
                              color: Colors.white.withOpacity(.2),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // CircleAvatar(
                                //   backgroundColor: ThemeColor.whiteColor,
                                //   child: SvgPicture.asset(
                                //     ConstantsHelper.userAvatarIcon,
                                //     semanticsLabel: 'User avatar',
                                //   ),
                                // ),
                                const SizedBox(
                                  width: 12,
                                ),
                                // Text(
                                //     isUserInfoLoaded
                                //         ? driverName
                                //         : HttpRequest.driverCode,
                                //     style: TextStyle(
                                //         fontSize: ConstantsHelper.sizex12,
                                //         fontWeight: FontWeight.bold,
                                //         color: Colors.white))
                              ],
                            ),
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
                        onTap: () {}),
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
                      onTap: () {},
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
                      onTap: () {},
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
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),

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
