import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// Création de notre animation de loader avec la librabry spinkit
class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitFoldingCube(
          color: Color(0xFFe6aa2d),
          size:50.0,
        )
      )
    );
  }
}
