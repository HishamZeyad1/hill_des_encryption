import 'package:firebase_auth/firebase_auth.dart';

class FbAuth{
  FirebaseAuth _firebaseAuth =FirebaseAuth.instance;
  UserCredential? userCredential;
  Future<String?> signEmailAndPassword({required String emailAddress,required String password}) async {
    try {
      print("enter here");
      userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      if (userCredential!=null && userCredential!.user != null){
        // return true;
        return null;
      }
      // print("is Logged:${FirebaseAuth.instance.currentUser!=null}");

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return e.code;
    }catch(e){
      return "Something wrong has occurred";
      // return e.toString();

    }
  }
  Future<String?> createAccount({required String emailAddress,required String password}) async {
    try {
      userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      if(userCredential!=null && userCredential!.user !=null){
        print(userCredential!.user);
        print(userCredential!.user!.email);
        return null;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return "The account already exists for that email.";
      }
      return e.code;
    } catch (e) {
      print(e);
      // return e.toString();
      return "Something wrong has occurred";

    }
  }

  // Future<bool> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  //
  //   // Create a new credential
  //   OAuthCredential userCredential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //
  //   UserCredential userCredential1=await FirebaseAuth.instance.signInWithCredential(userCredential);
  //
  //   if (userCredential1.user != null){
  //     print("is Logged:${FirebaseAuth.instance.currentUser!=null}");
  //     return true;
  //   }
  //   return false;
  //
  //   // Once signed in, return the UserCredential
  // }
  Future<bool> islogged()async{
    print(FirebaseAuth.instance.currentUser);
    print("is Logged:${FirebaseAuth.instance.currentUser!=null}");

    return FirebaseAuth.instance.currentUser!=null;
  }

  Future<bool> logout() async {
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseAuth.instance.signOut();
      return true;
    }
    return false;
  }

}