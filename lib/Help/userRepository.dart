import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum Status {Uninitialized, Authenticated,Authenticating,Unauthenticated}

class UserRepository with ChangeNotifier{
  final FirebaseAuth auth;
  User? _user = FirebaseAuth.instance.currentUser; // Initialize _user with the current user, if any
  Status _status=Status.Uninitialized;

  UserRepository.instance({required this.auth}){
    auth.authStateChanges().listen(onAuthStateChanged);
  }

  Status get status => _status;
  User? get user => _user;

  Future<bool> signIn(String email,String password) async{
    try{
      _status=Status.Authenticating;
      notifyListeners();
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    }
    catch(e){
      _status=Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future signOut() async{
    auth.signOut();
    _status =Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void onAuthStateChanged(User? firebaseUser) {
    if(firebaseUser == null){
      _status =Status.Unauthenticated;
    }
    else{
      _user=firebaseUser;
      _status=Status.Authenticated;
    }
    notifyListeners();
  }
}
