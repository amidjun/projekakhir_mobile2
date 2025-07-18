import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'home_page.dart';

class Authentication {
  static Future<FirebaseApp> initializeFirebase({BuildContext? context}) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(
        context!,
      ).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    }

    return firebaseApp;
  }

  static Future<User> signInWithGoogle({BuildContext? context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential = await auth.signInWithPopup(
          authProvider,
        );

        user = userCredential.user!;
      } catch (e) {
        print(e);
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount = await googleSignIn
          .signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential = await auth.signInWithCredential(
            credential,
          );

          user = userCredential.user!;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            ScaffoldMessenger.of(context!).showSnackBar(
              SnackBar(
                content: Text(
                  'The account already exists with a different credential',
                ),
              ),
            );
          } else if (e.code == 'invalid-credential') {
            ScaffoldMessenger.of(context!).showSnackBar(
              SnackBar(
                content: Text(
                  'Error occurred while accessing credentials. Try again.',
                ),
              ),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context!).showSnackBar(
            SnackBar(
              content: Text('Error occurred using Google Sign In. Try again.'),
            ),
          );
        }
      }
    }

    return user!;
  }

  static Future<void> signOut({BuildContext? context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      ScaffoldMessenger.of(
        context!,
      ).showSnackBar(SnackBar(content: Text('Error signing out. Try again.')));
    }
  }
}
