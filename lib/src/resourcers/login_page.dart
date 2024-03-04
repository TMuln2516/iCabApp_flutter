import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:icabapp/src/blocs/auth_blocs.dart';
import 'package:icabapp/src/dialogs/loading_dialog.dart';
import 'package:icabapp/src/dialogs/showerr_dialog.dart';
import 'package:icabapp/src/resourcers/home_page.dart';
import 'package:icabapp/src/resourcers/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  final SignUpBloc _bloc = SignUpBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        color: Colors.white,
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 100, 0, 10),
                child: SizedBox(
                  height: 140,
                  child: Image(
                    image: AssetImage("assets/ic_green_Car.png"),
                  ),
                ),
              ),
              const Text(
                "Wellcome Back!",
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                child: Text(
                  "Login to continue using iCab",
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: TextField(
                  controller: _emailController,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: SizedBox(
                        width: 50,
                        child: Image(image: AssetImage("assets/ic_mail.png"))),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: TextField(
                  obscureText: true,
                  controller: _passController,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                  decoration: const InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: SizedBox(
                        width: 50,
                        child: Image(image: AssetImage("assets/ic_lock.png"))),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: AlignmentDirectional.bottomEnd,
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: onPressedLogIn,
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.blue),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))))),
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                    children: [
                      const TextSpan(text: "New User? "),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpPage())),
                          text: "Sign up for a new account",
                          style: const TextStyle(color: Colors.blue))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onPressedLogIn() {
    String mail = _emailController.text;
    String pass = _passController.text;
    LoadingDialog.showLoadingDialog(context, "Loading...");
    _bloc.signIn(mail, pass, () {
      LoadingDialog.hideLoadingDialog(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }, (msg) {
      ErrorDialog.showErrDialog(context, "Sign-in Error", msg);
    });
  }
}
