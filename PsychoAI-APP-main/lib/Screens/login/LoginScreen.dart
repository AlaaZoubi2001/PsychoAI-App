import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:psychoai/Screens/Home/HomePageScreen.dart';
import 'package:psychoai/Screens/MyHomeScreen.dart';
import 'package:psychoai/Screens/SignUp.dart';
import 'package:psychoai/common/db_functions.dart';
import 'package:psychoai/main.dart';
import 'package:sizer/sizer.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.title});

  final String title;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _counter = 0;
  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController =TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  

  // Method to navigate to the home screen
  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePageScreen(title: 'Home')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
          return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: 100.w, // Use percentage width
            padding: EdgeInsets.all(4.w), // Use responsive padding
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.w), // Use responsive radius
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Top Image Section
                Container(
                  width: 100.w,
                  height: 30.h, // Adjust height
                 child: Image.asset("assets/images/Blue Mind Psychology Care Mental Health Logo.png"),
                ),
                SizedBox(height: 4.h), // Responsive spacing
      
                // Text Section
                Text(
                  'Let’s Connect With Us!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.sp, // Use responsive text size
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2.h),
      
                // Email and Password Fields
                Column(
                  children: [
                    _buildEmailTextField('Email Address'),
                    SizedBox(height: 2.h),
                    _buildPasswordTextField('Password'),
                  ],
                ),
      
                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {}, // Implement forgot password logic
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
      
                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                                         onPressed: ()async{
                                           await DBFunctions.instance.signInOrSignUp(emailController.text, passwordController.text ,context);
                                          }, // Call sign in methodlement login logic
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.w),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
      
                // Divider with 'or'
                Row(
                  children: [
                    Expanded(
                      child: Divider(color: Colors.black.withOpacity(0.5)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Text('or', style: TextStyle(fontSize: 14.sp)),
                    ),
                    Expanded(
                      child: Divider(color: Colors.black.withOpacity(0.5)),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
      
                // Sign Up with Apple/Google
                _buildSocialButton('Sign up with Google', Colors.white, borderColor: Colors.black),
      
                SizedBox(height: 4.h),
      
                // Don't have an account
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Don’t have an account?',
                        style: TextStyle(color: Colors.black, fontSize: 14.sp),
                      ),
                      TextSpan(

                         recognizer: TapGestureRecognizer()
                        ..onTap = () {
                           Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => SignUpScreen()),
                          );
                        },
                        text: ' Sign up',
                        style: TextStyle(
                          color: Color(0xFF0098FF), fontSize: 14.sp),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
      }
    );
  }

  Widget _buildEmailTextField(String hint) {
    return TextField(
      controller: emailController,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.w), // Use responsive radius
        ),
      ),
    );
  }

    Widget _buildPasswordTextField(String hint) {
    return TextField(
      controller: passwordController,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.w), // Use responsive radius
        ),
      ),
    );
  }


  Widget _buildSocialButton(String text, Color backgroundColor, {Color? borderColor}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {}, // Implement social sign up logic
        style: ElevatedButton.styleFrom(
          side: borderColor != null ? BorderSide(color: borderColor) : null,
          padding: EdgeInsets.symmetric(vertical: 2.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.w),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16.sp),
        ),
      ),
    );
  }
}
