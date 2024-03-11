import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:local_event_finder/global/firebase/firebase_auth_helper.dart';
import 'package:local_event_finder/global/firebase/firestore_service.dart';
import 'package:local_event_finder/global/tools/constants/constant_helper.dart';
import 'package:local_event_finder/global/tools/widgets/form_container_widget.dart';
import 'package:local_event_finder/global/validator/validator.dart';
import 'package:local_event_finder/modules/home/home_page.dart';
import 'package:local_event_finder/modules/local_event_map/widget/local_event_map.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool isSigningUp = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isSigning = false;
  // final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  String? email;
  String? password;
  String? emailErrorMessage;
  String? passwordErrorMessage;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      ConstantHelper.user = user;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LocalEventMap()),
      );
    }

    return firebaseApp;
  }

  late Map<String, dynamic> dataFromFirestore;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        body: Center(
          child: FutureBuilder(
            future: _initializeFirebase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 24.0, right: 24.0, top: 48),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Sign In",
                                style: TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              FormContainerWidget(
                                controller: _emailController,
                                hintText: "Email",
                                isPasswordField: false,
                              ),
                              SizedBox(height: 8.0),
                              SizedBox(height: 16.0),
                              FormContainerWidget(
                                controller: _passwordController,
                                hintText: "Password",
                                isPasswordField: true,
                              ),
                              SizedBox(height: 24.0),
                              _isProcessing
                                  ? CircularProgressIndicator()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Color(0xff648ddb),
                                              minimumSize:
                                                  const Size.fromHeight(50),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            onPressed: () async {
                                              _focusEmail.unfocus();
                                              _focusPassword.unfocus();

                                              if (_formKey.currentState!
                                                  .validate()) {
                                                setState(() {
                                                  _isProcessing = true;
                                                });

                                                User? user =
                                                    await FirebaseAuthHelper
                                                        .signInUsingEmailPassword(
                                                  email: _emailController.text,
                                                  password:
                                                      _passwordController.text,
                                                );

                                                setState(() {
                                                  _isProcessing = false;
                                                  print("user info : ${user}");
                                                });
                                                String phoneNumber = "";

                                                await FirestoreHandler()
                                                    .getDataFromFirestore(
                                                        user!.displayName)
                                                    .then((value) {
                                                  dataFromFirestore = value[0]
                                                      as Map<String, dynamic>;
                                                  setState(() {
                                                    phoneNumber =
                                                        dataFromFirestore[
                                                            "phoneNumber"];
                                                  });
                                                  print(
                                                      "valeur -------> ${dataFromFirestore["phoneNumber"]}");
                                                });

                                                if (user != null) {
                                                  print(
                                                      "value***${dataFromFirestore["phoneNumber"]}");
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomePage()),
                                                  );
                                                }
                                              }
                                            },
                                            child: Text(
                                              'Sign In',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 100,
                                  ),
                                  Flexible(
                                    child: Divider(
                                      indent:
                                          MediaQuery.of(context).size.width *
                                              .1,
                                      endIndent:
                                          MediaQuery.of(context).size.width *
                                              .05,
                                      color: Color.fromARGB(255, 188, 188, 188),
                                      height: 10,
                                    ),
                                  ),
                                  Text(
                                    "or",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 188, 188, 188)),
                                  ),
                                  Flexible(
                                    child: Divider(
                                      indent:
                                          MediaQuery.of(context).size.width *
                                              .05,
                                      endIndent:
                                          MediaQuery.of(context).size.width *
                                              .1,
                                      color: Color.fromARGB(255, 188, 188, 188),
                                      height: 10,
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    minimumSize: const Size.fromHeight(50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                onPressed: () async {
                                  final GoogleSignInAccount? gUser =
                                      await GoogleSignIn().signIn();

                                  final GoogleSignInAuthentication gAuth =
                                      await gUser!.authentication;
                                  final credential =
                                      GoogleAuthProvider.credential(
                                    accessToken: gAuth.accessToken,
                                    idToken: gAuth.idToken,
                                  );
                                  await FirebaseAuth.instance
                                      .signInWithCredential(credential)
                                      .then((value) {
                                    print("-----> $value");
                                    if (FirebaseAuth.instance.currentUser !=
                                        null) {
                                      //create a logic if the email is omartaamallah4@gmail.com go to welcome screen if not go to welcomescreen withn the email the user will sign in with
                                      print(
                                          "Info=====${FirebaseAuth.instance.currentUser!.email}");
                                      print(
                                          "Info=====${FirebaseAuth.instance.currentUser!.displayName}");
                                      print(
                                          "Info=====${FirebaseAuth.instance.currentUser!.phoneNumber}");
                                      print(
                                          "Info=====${FirebaseAuth.instance.currentUser!.photoURL}");
                                      print(
                                          "Info=====${FirebaseAuth.instance.currentUser!.metadata}");
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()),
                                      );
                                    }
                                  });
                                },
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Image(
                                        image: AssetImage(
                                            "assets/google_logo.png"),
                                        height: 25.0,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Text(
                                          'Login with Google',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
