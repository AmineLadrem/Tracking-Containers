import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFE1E2E2),
        body: Center(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
                color: Color(0xFFEAF6F6),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                      width: 350,
                    ),
                    Image.asset("assets/epal.png", width: 184, height: 140),
                    Image.asset("assets/navire.png", width: 321, height: 397),
                    //2 inputs for username and password
                    Container(
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Identifiant',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: 300,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Mot de passe',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    //Login button
                    Container(
                      width: 350,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Navigate to the second screen using a named route.
                          Navigator.pushNamed(context, '/home');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors
                              .transparent, // Set the background color to transparent
                          elevation: 0, // Remove the shadow
                        ),
                        icon: Icon(Icons.login_rounded, color: Colors.black),
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
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        )),
      ),
    );
  }
}
