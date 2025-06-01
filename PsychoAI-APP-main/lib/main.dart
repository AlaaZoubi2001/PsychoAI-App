import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psychoai/Screens/login/LoginScreen.dart';
import 'package:psychoai/common/db_functions.dart';
import 'package:psychoai/firebase_options.dart';
import 'package:psychoai/Screens/Home/imageUploader.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
Future<void> main() async {
  late final FirebaseApp app;
late final FirebaseAuth auth;
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);


   runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DBFunctions.instance), // Provide DBFunctions globally
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
          return MaterialApp(
            title: 'PsychoAI',
           theme: ThemeData(
        // Define a custom color scheme
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue, // Base color for generating the scheme
            inversePrimary: Colors.deepPurple, // Custom color for inversePrimary
            
          ),
        useMaterial3: true, // Optional: To use Material Design 3
          textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black), // For body text
          labelSmall: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black), // For smaller body text
          headlineMedium: TextStyle(color: Colors.black), // For headlines
        ),
      ),
      
            home: const LoginScreen(title: 'PschoAI'),
          );
        },
    );
  }
}

 