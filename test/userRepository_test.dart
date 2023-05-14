import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/subjects.dart';
import 'package:tracker_habit/Help/userRepository.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  Stream<User> get onAuthStateChanged {
    return Stream.empty();
  }
}

class MockFirebaseUser extends Mock implements User {}
class MockUserCredential extends Mock implements UserCredential{}

void main() {
  group('user repository test', () {
    UserRepository? _repo;
    MockFirebaseAuth _auth;
    BehaviorSubject<MockFirebaseUser> _user;

    setUp(() {
      _auth = MockFirebaseAuth();
      _user = BehaviorSubject<MockFirebaseUser>();
      _repo = UserRepository.instance(auth: _auth);
      when(_auth.onAuthStateChanged).thenAnswer((_) => _user);

      when(_auth.signInWithEmailAndPassword(email: "email",password: "password")).thenAnswer((_)async{
        _user.add(MockFirebaseUser());
        return MockUserCredential();
      });
      when(_auth.signInWithEmailAndPassword(email: "mail",password: "pass")).thenThrow((){
        return null;
      });
    });

    test("sign in with email and password", () async {
      bool signedIn = await _repo!.signIn("email", "password");
      expect(signedIn, true);
      expect(_repo!.status, Status.Authenticated);
    });

    test("sing in fails with incorrect email and password",() async {
      bool signedIn = await _repo!.signIn("mail", "pass");
      expect(signedIn, false);
      expect(_repo!.status, Status.Unauthenticated);
    });

    test('sign out', ()async{
      await _repo!.signOut();
      expect(_repo!.status, Status.Unauthenticated);
    });
  });
}

