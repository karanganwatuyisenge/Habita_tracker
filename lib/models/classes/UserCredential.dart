import 'package:firebase_auth/firebase_auth.dart';

class AppUserCredential {
  late User user;
  late AuthCredential credential;

  AppUserCredential({required this.user, required this.credential});
}
