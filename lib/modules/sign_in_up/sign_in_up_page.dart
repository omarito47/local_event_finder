import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_event_finder/global/tools/constants/constant_helper.dart';
import 'package:local_event_finder/modules/home/home_page.dart';
import 'package:local_event_finder/modules/sign_in/sign_in_page.dart';
import 'package:local_event_finder/modules/sign_up/sign_up.dart';

class SignInUpPage extends StatefulWidget {
  const SignInUpPage({super.key});

  @override
  _SignInUpPageState createState() => _SignInUpPageState();
}

class _SignInUpPageState extends State<SignInUpPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        // drawer: ,
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 10,
          bottom: const TabBar(
            labelColor: Color(0xff648ddb),
            indicatorColor: Color(0xff648ddb),
            tabs: [
              Tab(
                text: 'Sign In',
              ),
              Tab(text: 'Sign Up'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            // First Tab: Sign In
            SignInPage(),

            // Second Tab: Sign Up
            SignUpPage()
          ],
        ),
      ),
    );
  }
}

void showToast({required String message}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0);
}
