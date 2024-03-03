import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:icabapp/src/blocs/auth_blocs.dart';
import 'package:icabapp/src/dialogs/loading_dialog.dart';
import 'package:icabapp/src/dialogs/showerr_dialog.dart';
import 'package:icabapp/src/resourcers/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  final SignUpBloc _bloc = SignUpBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

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
                padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: Image(
                  image: AssetImage("assets/ic_red_Car.png"),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Text(
                  "Wellcome Abroad!",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(
                  "Sign up with iCab in simple steps",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                child: StreamBuilder(
                  stream: _bloc.getNameStream,
                  builder: (context, snapshot) => TextField(
                    controller: _nameController,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    decoration: InputDecoration(
                      errorText:
                          snapshot.hasError ? snapshot.error.toString() : null,
                      prefixIcon: const SizedBox(
                          width: 50,
                          child:
                              Image(image: AssetImage("assets/ic_user.png"))),
                      labelStyle: const TextStyle(color: Colors.grey),
                      labelText: "Name",
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: StreamBuilder(
                  stream: _bloc.getPhoneStream,
                  builder: (context, snapshot) => TextField(
                    controller: _phoneController,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    decoration: InputDecoration(
                      errorText:
                          snapshot.hasError ? snapshot.error.toString() : null,
                      prefixIcon: const SizedBox(
                          width: 1,
                          child:
                              Image(image: AssetImage("assets/ic_shape.png"))),
                      labelStyle: const TextStyle(color: Colors.grey),
                      labelText: "Phone Number",
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: StreamBuilder(
                  stream: _bloc.getMailStream,
                  builder: (context, snapshot) => TextField(
                    controller: _mailController,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    decoration: InputDecoration(
                        errorText: snapshot.hasError
                            ? snapshot.error.toString()
                            : null,
                        labelStyle: const TextStyle(color: Colors.grey),
                        prefixIcon: const SizedBox(
                            width: 50,
                            child:
                                Image(image: AssetImage("assets/ic_mail.png"))),
                        labelText: "Email",
                        border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: StreamBuilder(
                  stream: _bloc.getPassStream,
                  builder: (context, snapshot) => TextField(
                    obscureText: true,
                    controller: _passController,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    decoration: InputDecoration(
                        errorText: snapshot.hasError
                            ? snapshot.error.toString()
                            : null,
                        prefixIcon: const SizedBox(
                            width: 50,
                            child:
                                Image(image: AssetImage("assets/ic_lock.png"))),
                        labelStyle: const TextStyle(color: Colors.grey),
                        labelText: "Password",
                        border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.blue),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))))),
                      onPressed: onPressedSignUp,
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                    children: [
                      const TextSpan(text: "Already Account? "),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage())),
                          text: "Login now",
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

  void onPressedSignUp() {
    if (_bloc.isValid(_nameController.text, _phoneController.text,
        _mailController.text, _passController.text)) {
      LoadingDialog.showLoadingDialog(context, "Loading...");
      _bloc.signUp(_mailController.text, _passController.text,
          _nameController.text, _phoneController.text, () {
        LoadingDialog.hideLoadingDialog(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      }, (msg) {
        LoadingDialog.hideLoadingDialog(context);
        ErrorDialog.showErrDialog(context, "Error Sign-in", msg);
      });
    }
  }
}
