import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseAuthen {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void signUp(String mail, String pass, String name, String phone,
      Function onSuccess, Function(String) onRegisterErr) {
    try {
      _firebaseAuth
          .createUserWithEmailAndPassword(email: mail, password: pass)
          .then((userCredential) {
        User? user = userCredential.user;
        if (user != null) {
          String? userID = user.uid;
          _createUser(userID, name, phone, onSuccess, onRegisterErr);
        }
      });
    } on FirebaseAuthException catch (error) {
      _signUpErr(error.code, onRegisterErr);
    }
  }

  _createUser(String userID, String name, String phone, Function onSuccess,
      Function(String) onRegisterErr) {
    var user = {"name": name, "phone": phone};
    var ref = FirebaseDatabase.instance.ref().child("users");
    ref.child(userID).set(user).then((user) {
      onSuccess();
    }).catchError((err) {
      onRegisterErr("Signup Fail! Try again!!!");
    });
  }

  void _signUpErr(String code, Function(String) onRegisterErr) {
    switch (code) {
      case "email-already-in-use":
        onRegisterErr(
            "Already exists an account with the given email address.");
        break;
      case "invalid-email":
        onRegisterErr("The email address is not valid.");
        break;
      case "operation-not-allowed":
        onRegisterErr("Email/Password accounts are not enabled");
        break;
      case "weak-password":
        onRegisterErr("The password is not strong enough");
        break;
    }
  }
}
