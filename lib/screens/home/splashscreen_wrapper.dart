import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/user.dart';
import 'package:todo_app/screens/home/taskpage.dart';
import '../authentication.dart';


// création de la classe ou widget qui récupére l'user et permet de switcher entre taskpage et le formulaire
class SplashScreenWrapper extends StatelessWidget {
  const SplashScreenWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    if (user == null) {
      return Authentication();
    }else {
      return TaskApp();
    }
  }
}
