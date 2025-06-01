import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psychoai/common/Common_functions.dart';
import 'package:psychoai/common/Objects/User.dart';

class DBFunctions with ChangeNotifier  {
    // Public factory method to get the singleton instance
  static DBFunctions get instance => _instance;
  late List<Map<String, dynamic>> _sentiments = [];
  late List<Map<String, dynamic>> _recommendations = [];
  late List<Map<String, dynamic>> _activitys = [];
  // Private fields
  DBFunctions(){
   this._sentiments = [];
   this._recommendations = [];
   this._activitys = [];
   
  }
  // Private constructor for the Singleton pattern
  DBFunctions._privateConstructor();

  // The single instance of DBFunctions

  static final DBFunctions _instance = DBFunctions._privateConstructor();


  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  CommonFunctions commonFunctions = CommonFunctions();
  late List<Map<String, dynamic>> _reports;
  late List<Map<String, dynamic>> _reminders;
  AppUser? logedInUser;
  
  // Getter for _firestore
  FirebaseFirestore get firestore => _firestore;

  // Setter for _firestore
  set firestore(FirebaseFirestore firestoreInstance) {
    _firestore = firestoreInstance;
  }
  FirebaseAuth get auth => _auth;

  List<Map<String, dynamic>>  get sentiments => _sentiments ?? [];

  List<Map<String, dynamic>>  get recommendations => _recommendations;
  List<Map<String, dynamic>>  get reminders => _reminders;

  List<Map<String, dynamic>>  get activitys => _activitys;

  List<Map<String, dynamic>>  get reports => _reports;

  // Setter for _auth
  set auth(FirebaseAuth authInstance) {
    _auth = authInstance;
  }

  // Method to sign up a new user
  Future<bool> signUpUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Save the user data to Firestore
      await saveUserToFirestore(userCredential.user, password);
      logedInUser = await fetchUserData(userCredential.user!.uid);
      notifyListeners(); // Notify listeners whenever the user is updated
      return true;
    } on FirebaseAuthException catch (e) {
      print('Sign Up Error: ${e.message}');
      return false;
    }
  }


  // Method to sign up a new user
  Future<bool> signUpUserwithinfo(String email, String password, name, age,address, parent_phone) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Save the user data to Firestore
      await saveUserToFirestorewithinfo(userCredential.user, password, name, "0",address, parent_phone);
      logedInUser = await fetchUserData(userCredential.user!.uid);
      notifyListeners(); // Notify listeners whenever the user is updated
      return true;
    } on FirebaseAuthException catch (e) {
      print('Sign Up Error: ${e.message}');
      return false;
    }
  }

  // Method to save the user data to Firestore
  Future<void> saveUserToFirestore(User? user, String password) async {
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
         'email': user.email,
        "user_id":user.uid,
        "age":logedInUser!.age,
        "email":logedInUser!.email,
        "first_name":logedInUser!.name,
        "points":logedInUser!.points,
        "sex": logedInUser!.sex,
        'password': password, // Store the password
        'lastLogin': DateTime.now().toString(),
      });
      logedInUser = await fetchUserData(user.uid);
    notifyListeners(); // Notify listeners whenever the user is updated
    }
  }

  // Method to update the user's last login in Firestore
  Future<void> updateUserInFirestore(User? user) async {
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'lastLogin': DateTime.now().toString(),
      });
    notifyListeners(); // Notify listeners whenever the user is updated


    }
  }

    // Method to update the user's last login in Firestore
  Future<void> updateReminderAsDoneInFirestore(String? id) async {
    if (id != null && id != "") {
      await _firestore.collection('reminders').doc(id).update({
        'status': "Done",
      });
    notifyListeners(); // Notify listeners whenever the user is updated

    }
  }


    // Method to update the user's last login in Firestore
  Future<void> updateUserInPoints(AppUser? user, int score) async {
    if (user != null) {
      DocumentSnapshot  documentSnapshot = await _firestore.collection('users').doc(user.id).get();
      var points = await documentSnapshot.get("points");
      await _firestore.collection('users').doc(user.id).update({
        'points': FieldValue.increment(score)
      });
      user.points = (int.parse(points.toString()) +  int.parse(score.toString())).toString();
      debugPrint("added");
      notifyListeners();
    }
  }

  // Method to sign in or sign up the user
  Future<void> signInOrSignUp(String email, String password, context) async {
    try {
      // Try to sign in the user
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // If sign in is successful, update last login and navigate to home screen
      await updateUserInFirestore(userCredential.user);
      commonFunctions.navigateToHome(context);
      logedInUser = await fetchUserData(userCredential.user!.uid);
      notifyListeners(); // Notify listeners whenever the user is updated

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
        // If user doesn't exist, sign up the user

      } else {
        // If another error, show the error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.message}')),
        );
      }
    }
  }

  // Method to fetch user data from Firestore
  Future<AppUser> fetchUserData(String userId) async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();

    if (doc.exists) {
      // Convert Firestore document to User object
      notifyListeners();
      return AppUser.fromFirestore(doc.data() as Map<String, dynamic>,doc.id);
    } else {
      throw Exception('User not found');
    }
  }

 
  // New method to fetch user sentiments from Firestore
  Future<List<Map<String, dynamic>>> fetchUserSentiments() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Synteiments') // The name of the collection where sentiments are stored
          .where('user_id', isEqualTo: logedInUser!.id) // Query where user_id equals the passed userId
          .get();

      // Extracting the sentiment data from each document
      _sentiments = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();
      notifyListeners();
      return _sentiments; // Return the list of sentiment data
    } catch (e) {
      print('Error fetching sentiments: $e');
      return [];
    }
  }

  
  // New method to fetch user sentiments from Firestore
  Future<List<Map<String, dynamic>>> fetchUserReminders() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('reminders') // The name of the collection where sentiments are stored
          .where('user_id', isEqualTo: logedInUser!.id) // Query where user_id equals the passed userId
          .get();

      // Extracting the sentiment data from each document
      _reminders = querySnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data["id"]= doc.id;
        return data;
      }).toList();
    notifyListeners(); // Notify listeners whenever the user is updated

      return _reminders; // Return the list of sentiment data
    } catch (e) {
      print('Error fetching sentiments: $e');
      return [];
    }
  }


  
  // New method to fetch user sentiments from Firestore
  Future<List<Map<String, dynamic>>> fetchUserActivitys() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('activity') // The name of the collection where sentiments are stored
          .where('user_id', isEqualTo: logedInUser!.id) // Query where user_id equals the passed userId
          .get();

      // Extracting the sentiment data from each document
      _activitys = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();
    notifyListeners(); // Notify listeners whenever the user is updated

      return _activitys; // Return the list of sentiment data
    } catch (e) {
      print('Error fetching sentiments: $e');
      return [];
    }
  }


  
  // New method to fetch user sentiments from Firestore
  Future<List<Map<String, dynamic>>> fetchUserReports() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Reports') // The name of the collection where sentiments are stored
          .where('user_id', isEqualTo: logedInUser!.id) // Query where user_id equals the passed userId
          .get();

      // Extracting the sentiment data from each document
      _reports = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();
    notifyListeners(); // Notify listeners whenever the user is updated

      return _reports; // Return the list of sentiment data
    } catch (e) {
      print('Error fetching sentiments: $e');
      return [];
    }
  }

   
   
  
  // New method to fetch user sentiments from Firestore
  Future<List<Map<String, dynamic>>> fetchUserRecomendations() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Recomendation') // The name of the collection where sentiments are stored
          .get();

      // Extracting the sentiment data from each document
      _recommendations = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();
          notifyListeners(); // Notify listeners whenever the user is updated


      return _recommendations; // Return the list of sentiment data
    } catch (e) {
      print('Error fetching sentiments: $e');
      return [];
    }
  }

  void addReminderToFirestore(String title, String user, DateTime date, String reminder_type,) async{
      await _firestore.collection('reminders').doc().set({
         'creation_timestamp': DateTime.now(),
        "user_id":logedInUser!.id,
        "status":"New",
        "reminder_type":reminder_type,
        "reminder_message":title,
        "reminder_id":reminder_type,
        "duo_timestamp": DateTime.now(),

      });
    notifyListeners(); // Notify listeners whenever the user is updated
  }
  
   Future<void> saveUserToFirestorewithinfo(User? user, String password, email,age, name, parent) async {
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'email': user.email,
        "user_id":user.uid,
        "age":age,
        "email":logedInUser!.email,
        "first_name":name,
        "points": "0",
        'password': password, // Store the password
        'lastLogin': DateTime.now().toString(),
      });
      logedInUser = await fetchUserData(user.uid);
    notifyListeners(); // Notify listeners whenever the user is updated
    }
  }

   
}
