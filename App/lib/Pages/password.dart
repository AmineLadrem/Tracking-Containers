import 'package:epal/helpers/ipAddresses.dart';
import 'package:epal/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final _auth = FirebaseAuth.instance;
String userEmail = FirebaseAuth.instance.currentUser?.email ?? "";
//controllers
TextEditingController _oldPasswordController = TextEditingController();
TextEditingController _newPasswordController = TextEditingController();
TextEditingController _confirmPasswordController = TextEditingController();

class Password extends StatefulWidget {
  const Password({super.key});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  @override
  Widget build(BuildContext context) {
    Future<void> changePassword(String newPassword) async {
      bool success = true;
      var response = await http.put(
          Uri.parse(usedIPAddress +
              '/api/utilisateur/' +
              userEmail +
              '/' +
              newPassword),
          headers: headers);
      var user = json.decode(response.body);
      if (user['success'] == true) {
        await _auth.currentUser!.updatePassword(newPassword);
        print('Password updated successfully!');
      } else {
        success = false;
      }

      if (success) {
        Fluttertoast.showToast(
          msg: 'Mot de passe changé avec succès !',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        Future.delayed(Duration(seconds: 3), () async {
          await FirebaseAuth.instance.signOut();
          Navigator.of(context).popUntil((route) => route.isFirst);
        });
      } else {
        Fluttertoast.showToast(
          msg: 'Mot de passe incorrect !',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    }

    return Scaffold(
      backgroundColor: Color(0xFFEAF6F6),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 250.0, left: 15, right: 15),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              height: 326,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Column(
                      children: [
                        SizedBox(height: 5),
                        Center(
                          child: Text(
                            'Changer le mot de passe',
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              color: dark,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: back,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        labelText: 'Mot de passe actuel',
                        labelStyle: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        hintText: 'Mot de passe actuel',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(Icons.lock, color: Colors.red),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _oldPasswordController.clear();
                          },
                          icon: Icon(Icons.clear, color: Colors.grey[700]),
                        ),
                      ),
                      controller: _oldPasswordController,
                      obscureText: true,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: back,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        labelText: 'Nouveau mot de passe',
                        labelStyle: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        hintText: 'Nouveau mot de passe',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(Icons.lock_open, color: Colors.orange),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _newPasswordController.clear();
                          },
                          icon: Icon(Icons.clear, color: Colors.grey[700]),
                        ),
                      ),
                      controller: _newPasswordController,
                      obscureText: true,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: back,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        labelText: 'Confirmer le nouveau mot de passe',
                        labelStyle: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        hintText: 'Confirmer le nouveau mot de passe',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(Icons.check, color: Colors.green),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _confirmPasswordController.clear();
                          },
                          icon: Icon(Icons.clear, color: Colors.grey[700]),
                        ),
                      ),
                      controller: _confirmPasswordController,
                      obscureText: true,
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 45,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF8FABFE),
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        var response = await http.get(
                            Uri.parse(usedIPAddress +
                                '/api/utilisateur/' +
                                userEmail),
                            headers: headers);
                        var user = json.decode(response.body);
                        if (_oldPasswordController.text.isEmpty ||
                            _newPasswordController.text.isEmpty ||
                            _confirmPasswordController.text.isEmpty) {
                          Fluttertoast.showToast(
                            msg: 'Veuillez remplir tous les champs !',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          return;
                        }
                        if (_oldPasswordController.text != user['MotPass']) {
                          Fluttertoast.showToast(
                              msg: 'Mot de passe actuel incorrect !',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          return;
                        }
                        if (_newPasswordController.text !=
                            _confirmPasswordController.text) {
                          Fluttertoast.showToast(
                              msg: 'Les mots de passe ne correspondent pas !',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          return;
                        }

                        bool confirmed = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Changer le mot de passe'),
                              content: Text(
                                  'Êtes-vous sûr de vouloir changer votre mot de passe ?'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Annuler'),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                ),
                                TextButton(
                                  child: Text('Confirmer'),
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                ),
                              ],
                            );
                          },
                        );

                        // Call the changePassword function if the user confirms the action
                        if (confirmed == true) {
                          await changePassword(_newPasswordController.text);
                          _oldPasswordController.clear();
                          _newPasswordController.clear();
                          _confirmPasswordController.clear();
                          // Update UI here
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFF80CFCC)),
                      ),
                      child: Text('Changer ',
                          style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 163),
          Container(
            height: 60,
            width: 600,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(width: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF80CFCC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 43,
                  width: 65,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Icon(Icons.arrow_back),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
            ]),
          )
        ],
      ),
    );
  }
}
