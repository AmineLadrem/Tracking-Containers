import 'package:epal/constants/style.dart';
import 'package:epal/pages/admin_home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final PasswordController = TextEditingController();

  Future<void> signIn() async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: PasswordController.text.trim(),
      );
      // If sign-in was successful, navigate to the home page
      Navigator.pushNamed(context, AdminHome.routeName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    PasswordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFEAF6F6),
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset("assets/epal.png", width: 184, height: 140),
              Image.asset("assets/navire.png", width: 321, height: 397),
              //2 inputs for username and password
              Container(
                width: 300,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: light,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    labelText: 'E-mail',
                    labelStyle: TextStyle(
                      color: dark,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    hintText: 'E-mail',
                    hintStyle: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    prefixIcon: Icon(Icons.email, color: dark),
                    suffixIcon: IconButton(
                      onPressed: () {
                        PasswordController.clear();
                      },
                      icon: Icon(Icons.clear, color: Colors.red),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: light,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    labelText: 'Mot de passe',
                    labelStyle: TextStyle(
                      color: dark,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    hintText: 'Mot de passe',
                    hintStyle: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    prefixIcon: Icon(Icons.lock_open, color: dark),
                    suffixIcon: IconButton(
                      onPressed: () {
                        PasswordController.clear();
                      },
                      icon: Icon(Icons.clear, color: Colors.red),
                    ),
                  ),
                  controller: PasswordController,
                  obscureText: true,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              //Login button
              Container(
                width: 350,
                child: ElevatedButton.icon(
                  onPressed: signIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  icon: Icon(Icons.login_rounded, color: dark),
                  label: Text(
                    'Se connecter',
                    style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Colors.grey,
                        ),
                      ],
                      color: dark,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    print('object');
                  },
                  child: Text(
                    'Mot de passe oublié?',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ), //Forget password
              )
            ],
          ),
        )),
      ),
    );
  }
}
