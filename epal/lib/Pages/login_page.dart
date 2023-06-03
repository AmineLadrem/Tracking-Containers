import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:epal/chef_pages/home.dart';
import 'package:epal/conducteur_pages/home.dart';
import 'package:epal/constants/style.dart';
import 'package:epal/helpers/ipAddresses.dart';

import 'package:epal/pointeur_pages/home.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: PasswordController.text.trim(),
      );

      String url;

      url = Platform.isAndroid ? usedIPAddress : 'http://0.0.0.0:8000';

      var response = await http.get(
          Uri.parse(url + '/api/utilisateur/' + emailController.text.trim()));
      var user = json.decode(response.body);
      if (user['Role'] == 'pointeur')
        Navigator.pushNamed(context, PointeurHome.routeName);
      else if (user['Role'] == 'chef_de_parc')
        Navigator.pushNamed(context, ChefHome.routeName);
      else
        Navigator.pushNamed(context, ConducteurHome.routeName);
      print('Login successfull');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void showNotificationToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String? title = message.notification?.title;
      String? body = message.notification?.body;
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 123,
              channelKey: 'basic_channel',
              title: title,
              body: body,
              category: NotificationCategory.Call,
              largeIcon: 'https://i.postimg.cc/xTnb0c7V/container.png',
              displayOnForeground: true,
              displayOnBackground: true,
              showWhen: true,
              wakeUpScreen: true,
              autoDismissible: false,
              backgroundColor: Colors.blueGrey,
              notificationLayout: NotificationLayout.Default),
          actionButtons: [
            NotificationActionButton(
              key: 'REJECT',
              label: 'OK',
              buttonType: ActionButtonType.DisabledAction,
            ),
          ]);
      AwesomeNotifications().actionStream.listen((receivedNotification) {});
    });
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
                    fillColor: Color(0xFFcae4ed),
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
                        emailController.clear();
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
                    fillColor: Color(0xFFcae4ed),
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
                height: 15.0,
              ),
              //Login button
              Container(
                child: ElevatedButton.icon(
                  onPressed: signIn,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: light,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
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
            ],
          ),
        )),
      ),
    );
  }
}
