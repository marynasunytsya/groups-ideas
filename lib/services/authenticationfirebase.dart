import 'dart:async';

//importation de la library firebase_auth pour la gestion de connexion
import 'package:firebase_auth/firebase_auth.dart';

// importation de notre model user
import 'package:todo_app/models/user.dart';

// Création de la classe qui s'occupera de la gestion de l'authentification avec firebase
class AuthenticationFirebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// On recupere user de firebase & model

  AppUser? _userFromFirebaseUser(User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }
  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // Création d'une méthode de classe qui permet la connexion avec email & password
  Future signWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result =
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  //  Création d'une méthode de classe qui permet de s'enregistrer  avec email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result =
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }


  // création de la méthode pour la deconnexion
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }
}
