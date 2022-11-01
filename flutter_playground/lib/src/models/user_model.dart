class User {
  String? _mail;
  String? _password;

  User(String mail, String password){
    _mail=mail;
    _password=password;
  }

  String get password => _password!;

  set password(String value) {
    _password = value;
  }

  String get mail => _mail!;

  set mail(String value) {
    _mail = value;
  }
}