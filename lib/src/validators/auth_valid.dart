class Validations {
  static isValidName(String name) {
    return name.isNotEmpty;
  }

  static isValidPhone(String phone) {
    return phone.isNotEmpty && phone.length == 10;
  }

  static isValidMail(String mail) {
    return mail.isNotEmpty && mail.contains("@gmail.com");
  }

  static isValidPass(String pass) {
    return pass.isNotEmpty && pass.length >= 6;
  }
}
