import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<void> signUp({ required String email, required String password})
  async {
    try {
                 await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);  
    } on FirebaseAuthException catch (e)
    {
                String message = "";
                if(e.code == 'weak-password')
                {
                  message = "The password provided is too weak.";
                }
                else if(e.code == 'email-already-in-use')
                {
                  message = "The account already exists for that email.";
                } 
    }
  }

  Future<void> signIn({ required String email, required String password})
  async {
    try {
       await  FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e)
    {
      String message = "";
      if(e.code == 'user-not-found')
      {
        message = "No user found for that email.";
      }
      else if(e.code == 'wrong-password')
      {
        message = "Wrong password provided for that user.";
      }
    }
  }
}