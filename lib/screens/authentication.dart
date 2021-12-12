import 'package:flutter/material.dart';
import 'package:todo_app/general/constants.dart';
import 'package:todo_app/general/loading.dart';
import 'package:todo_app/services/authenticationfirebase.dart';

// Création du Vue du formulaire Avec un Stateful widget
class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

// Création d'un formKey, un String pour afficher les erreurs et un bool loading pour afficher le composant loading en cas de chargement
class _AuthenticationState extends State<Authentication> {
  final AuthenticationFirebase _auth = AuthenticationFirebase();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // création de deux controlleurs: email & password et Showsignin qui permet d'alterner entre deux formulaires
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool showSignIn = true;

  // appel de dispose pour enlever les controlleurs du Tree flutter
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // création de la méthode qui permet de switcher entre les deux formulaires
  void toggleView() {
    setState(() {
      _formKey.currentState?.reset();
      error = '';
      emailController.text = '';
      passwordController.text = '';
      showSignIn = !showSignIn;
    });
  }

// Création de différents composants pour les pages inscription & connexions
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Color(0xFF151b2a),
              elevation: 5.0,
              title: Text(
                showSignIn
                    ? "Connexion à Group's Ideas"
                    : "S\'enregister et accéder à Group's Ideas",
                style: TextStyle(color: Color(0xFFe6aa2d), fontSize: 13.5),
              ),
              actions: <Widget>[
                TextButton.icon(
                  onPressed: () => toggleView(),
                  icon: Icon(Icons.person, color: Color(0xFF45be9e)),
                  label: Text(
                    showSignIn ? 'S\'enregistrer' : 'Se connecter',
                    style: TextStyle(
                      color: Color(0xFF45be9e),
                    ),
                  ),
                ),
              ],
            ),
            body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("image.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        !showSignIn ? SizedBox(height: 10.0) : Container(),
                        TextFormField(
                          controller: emailController,
                          decoration: textInputDecoration.copyWith(
                              hintText: 'adresse mail'),
                          validator: (value) => value == null || value.isEmpty
                              ? "Saisissez votre adrese mail"
                              : null,
                        ),
                        SizedBox(height: 5.0),
                        TextFormField(
                          controller: passwordController,
                          decoration: textInputDecoration.copyWith(
                              hintText: 'mot de passe'),
                          obscureText: true,
                          validator: (value) => value != null &&
                                  value.length < 6
                              ? "Saisissez un mot de passe avec au moins 6 caractères"
                              : null,
                        ),
                        SizedBox(height: 5.0),
                        ElevatedButton(
                          child: Text(
                            showSignIn ? "Connexion" : "S'enregister",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState?.validate() == true) {
                              setState(() => loading = true);
                              var password = passwordController.value.text;
                              var email = emailController.value.text;

                              //L'appel pour firebase

                              dynamic result = showSignIn
                                  ? await _auth.signWithEmailAndPassword(
                                      email, password)
                                  : await _auth.registerWithEmailAndPassword(
                                      email, password);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error = 'Vérifiez le champ saisi';
                                });
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFF151b2a),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 18),
                              textStyle: TextStyle(
                                  fontSize: 17.0, fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 15.0),
                        )
                      ],
                    ))));
  }
}
