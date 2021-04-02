import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

User googleUser = null;

Future<void> initializeFirebase() async{
  await Firebase.initializeApp();
}

Future<dynamic> googleSignInProcess() async{
  try {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      final UserCredential authResult =
      await auth.signInWithCredential(credential);
      googleUser = authResult.user;

      if (googleUser != null) {
        assert(!googleUser.isAnonymous);
        assert(await googleUser.getIdToken() != null);

        final User currentUser = auth.currentUser;
        assert(googleUser.uid == currentUser.uid);
        print("Sign in Success: $googleUser");
        return googleUser;
      }
    }
  } on Exception catch (e) {
    print("Exception SignIN: " + e.toString());
    return null;
  }
  return null;

}

Future<void> signOut() async {
  await auth.signOut();
  await googleSignIn.signOut();
  googleUser = null;
  print("User Signed Out");
}

