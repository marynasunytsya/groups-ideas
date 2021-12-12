import 'package:flutter/material.dart';
// Création des constantes qu'on pourra utiliser pour le formulaire et les differentes parties du Front-end
const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  errorBorder:OutlineInputBorder(
    borderSide: BorderSide(color:Colors.red, width:1.0),
  ),
  focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color:Colors.red, width:1.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color:Color(0xFF151b2a), width:1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF151b2a) , width:3.0),
  ),
);

