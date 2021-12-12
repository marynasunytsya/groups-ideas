import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/home/splashscreen_wrapper.dart';
import 'package:todo_app/services/authenticationfirebase.dart';
import 'package:todo_app/models/user.dart';
import 'package:provider/provider.dart';

// classe principale de l'application
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// on appel le Stream provider permettant de récuperer l'user qui est connecté
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      value: AuthenticationFirebase().user,
      initialData: null,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
      home: SplashScreenWrapper(),
      theme: ThemeData(
        primarySwatch: Colors.grey,
      )
    ),
    );
  }
}
