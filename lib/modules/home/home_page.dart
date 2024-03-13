import 'package:flutter/material.dart';
import 'package:local_event_finder/global/firebase/firebase_auth_helper.dart';
import 'package:local_event_finder/global/tools/widgets/drawer.dart';
import 'package:local_event_finder/modules/sign_in_up/sign_in_up_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () async {
                  await FirebaseAuthHelper.firebaseSignOut().then((value) {
                    if (value = true) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInUpPage(),
                        ),
                      );
                    }
                  });
                },
                icon: const Icon(Icons.logout)),
          )
        ],
      ),
      drawer: AppMainDrawer(),
      body: Center(child: Text("Welcome !!")),
    );
  }
}
