import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psychoai/Screens/Home/HomePageScreen.dart';

class CommonFunctions {
  // Private fields
  // Method to navigate to the home screen
  void navigateToHome(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePageScreen(title: 'Home')),
    );
  }

}
