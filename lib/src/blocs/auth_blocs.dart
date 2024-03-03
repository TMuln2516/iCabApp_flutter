import 'dart:async';

import 'package:icabapp/src/firebase/firebase_auth.dart';
import 'package:icabapp/src/validators/auth_valid.dart';

class SignUpBloc {
  final _firebaseAuth = FirebaseAuthen();
  final StreamController _nameStreamController = StreamController();
  final StreamController _phoneStreamController = StreamController();
  final StreamController _mailStreamController = StreamController();
  final StreamController _passStreamController = StreamController();

  Stream get getNameStream => _nameStreamController.stream;
  Stream get getPhoneStream => _phoneStreamController.stream;
  Stream get getMailStream => _mailStreamController.stream;
  Stream get getPassStream => _passStreamController.stream;

  bool isValid(String name, String phone, String mail, String pass) {
    if (!Validations.isValidName(name)) {
      _nameStreamController.sink.addError("Invalid Name");
      return false;
    }
    _nameStreamController.sink.add("OK");

    if (!Validations.isValidPhone(phone)) {
      _phoneStreamController.sink.addError("Invalid Phone");
      return false;
    }
    _phoneStreamController.sink.add("OK");

    if (!Validations.isValidMail(mail)) {
      _mailStreamController.sink.addError("Invalid Mail");
      return false;
    }
    _mailStreamController.sink.add("OK");

    if (!Validations.isValidPass(pass)) {
      _passStreamController.sink.addError("Password has > 6 charater");
      return false;
    }
    _passStreamController.sink.add("OK");

    return true;
  }

  void signUp(String mail, String pass, String name, String phone,
      Function onSuccess, Function(String) onRegisterErr) {
    _firebaseAuth.signUp(mail, pass, name, phone, () {
      onSuccess();
    }, onRegisterErr);
  }

  void dispose() {
    _nameStreamController.close();
    _phoneStreamController.close();
    _mailStreamController.close();
    _passStreamController.close();
  }
}
