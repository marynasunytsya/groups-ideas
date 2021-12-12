import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:todo_app/services/authenticationfirebase.dart';

//Création de la page Taskpage
class TaskApp extends StatefulWidget {
  const TaskApp({Key? key}) : super(key: key);

  @override
  _TaskAppState createState() => _TaskAppState();
}

// On instancie la classe avec une list vide et un string
class _TaskAppState extends State<TaskApp> {
  final List matodolist = [];
  String input = '';

// initialisation de l'état
  @override
  void initState() {
    super.initState();
  }

  // appel à firebase pour la deconnexion
  final AuthenticationFirebase _auth = AuthenticationFirebase();

  // création des différents composant de la page pour ajouter de tache
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF151b2a),
        elevation: 5.0,
        title: Text('Idées du groupe',
            style: TextStyle(
              color: Color(0xFFe6aa2d),
            )),
        // Bouton deconnexion
        actions: <Widget>[
          TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: const Icon(Icons.person, color: Color(0xFF45be9e)),
              label: const Text(
                'Se deconnecter',
                style: TextStyle(color: Color(0xFF45be9e)),
              )),
        ],
      ),
      // Création & suppression des tasks
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                  contentPadding: EdgeInsets.all(15.0),
                  elevation: 15.0,
                  title: Text("Nouvelle tâche",
                      style: TextStyle(
                        color: Color(0xFF27779d),
                      )),
                  content: TextField(
                    onChanged: (String value) {
                      input = value;
                    },
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        setState(() {
                          matodolist.add(input);
                        });
                        Navigator.of(
                          context,
                        ).pop();
                      },
                      child: Text(
                        "Ajouter",
                        style: TextStyle(
                          color: Color(0xFF113857),
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              });
        },
        backgroundColor: Color(0xFF27779d),
        child: Icon(
          Icons.add,
          size: 35.0,
          color: Color(0xFFe6aa2d),
        ),
      ),
      body: ListView.builder(
          itemCount: matodolist.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
                key: Key(matodolist[index]),
                child: Card(
                  elevation: 45,
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      matodolist[index],
                    ),
                    trailing: IconButton(
                        icon: Icon(
                          Icons.done_outline_rounded,
                          color: Color(0xFF27779d),
                        ),
                        onPressed: () {
                          setState(() {
                            matodolist.removeAt(index);
                          });
                        }),
                  ),
                ));
          }),
    );
  }
}
