import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psychoai/Screens/Home/HomePageScreen.dart';
import 'package:psychoai/common/db_functions.dart';

void main() => runApp(SignUpScreen());

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
        ),
        body: SignUpForm(),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool isChild = true; // Toggle between child and parent
  final _formKey = GlobalKey<FormState>();
  // Controllers for form fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  // List to hold child names if the user is a parent
  List<Map<String, TextEditingController>> childrenControllers = [
    {
      'childName': TextEditingController(),
      'childPhone': TextEditingController(),
    }
  ];

  @override
  void dispose() {
    // Dispose controllers
    nameController.dispose();
    addressController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    childrenControllers.forEach((controllers) {
      controllers['childName']?.dispose();
      controllers['childPhone']?.dispose();
    });
    super.dispose();
  }

  void _addChild() {
    setState(() {
      childrenControllers.add({
        'childName': TextEditingController(),
        'childPhone': TextEditingController(),
      });
    });
  }

  void _removeChild(int index) {
    setState(() {
      childrenControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Sign up as:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ToggleButtons(
                    isSelected: [isChild, !isChild],
                    onPressed: (index) {
                      setState(() {
                        isChild = index == 0;
                      });
                    },
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text("Child"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text("Parent"),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(labelText: "Address"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  labelText: isChild
                      ? "Parent's Phone Number"
                      : "Phone Number",
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              if (!isChild)
                Column(
                  children: [
                    ...childrenControllers.asMap().entries.map((entry) {
                      int index = entry.key;
                      var controllers = entry.value;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: controllers['childName'],
                            decoration: InputDecoration(
                                labelText: "Child's Name ${index + 1}"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a child\'s name';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: controllers['childPhone'],
                            decoration: InputDecoration(
                                labelText: "Child's Phone Number ${index + 1}"),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a child\'s phone number';
                              }
                              return null;
                            },
                          ),
                          if (childrenControllers.length > 1)
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () => _removeChild(index),
                                child: Text('Remove Child'),
                              ),
                            ),
                          SizedBox(height: 10),
                        ],
                      );
                    }).toList(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: _addChild,
                        child: Text('Add Another Child'),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    //  name, age,address, parent_phone
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')));
                          bool signedIn = await DBFunctions.instance.signUpUserwithinfo(emailController.text, passwordController.text,
                          nameController.text, "0", addressController.text, phoneNumberController.text
                          );
                          if (signedIn){
                            Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePageScreen(title: 'Home')),
                          );
                          }
                           
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  
}
