import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_event_finder/global/firebase/firebase_auth_helper.dart';
import 'package:local_event_finder/global/tools/widgets/form_container_widget.dart';
import 'package:local_event_finder/modules/home/home_page.dart';
import 'package:local_event_finder/modules/sign_in_up/sign_in_up_page.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool isSigningUp = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign Up",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              FormContainerWidget(
                controller: _usernameController,
                hintText: "Username",
                isPasswordField: false,
              ),
              SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _emailController,
                hintText: "Email",
                isPasswordField: false,
              ),
              SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _passwordController,
                hintText: "Password",
                isPasswordField: true,
              ),
              SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _confirmPasswordController,
                hintText: "Confirm Password",
                isPasswordField: true,
              ),
              SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _phoneNumberController,
                hintText: "PhoneNumber",
                isPasswordField: false,
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  // FirebaseAuthService().signUpWithEmailAndPassword(
                  //     _emailController.text, _passwordController.text);
                  _signUp();
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Color(0xff648ddb),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: isSigningUp
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInUpPage()),
                            (route) => false);
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Color(0xff648ddb),
                            fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    setState(() {
      isSigningUp = true;
    });

    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    String phoneNumber = _phoneNumberController.text;

    if (password != confirmPassword) {
      showToast(message: "Passwords do not match");
      setState(() {
        isSigningUp = false;
      });
      return;
    }

    User? user = await FirebaseAuthHelper.registerUsingEmailPassword(
      name: username,
      email: email,
      password: password,
      phoneNumer: phoneNumber,
    );

    setState(() {
      isSigningUp = false;
    });

    if (user != null) {
      showToast(message: "User is successfully created");
      await FirebaseAuthHelper.signInUsingEmailPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ).then((value) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage()
          ),
        );
      });
      // Navigator.pushNamed(context, "/home");
    } else {
      showToast(message: "Some error happened!!");
    }
  }
}