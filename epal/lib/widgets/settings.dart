import 'package:epal/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final _auth = FirebaseAuth.instance;
String userEmail = FirebaseAuth.instance.currentUser?.email ?? "";
//controllers
TextEditingController _oldPasswordController = TextEditingController();
TextEditingController _newPasswordController = TextEditingController();
TextEditingController _confirmPasswordController = TextEditingController();

class settings extends StatelessWidget {
  const settings({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> changePassword(String newPassword) async {
      bool success = true;
      var response = await http.put(Uri.parse(
          'http://127.0.0.1:8000/api/utilisateur/' +
              userEmail +
              '/' +
              newPassword));
      var user = json.decode(response.body);
      if (user['success'] == true) {
        await _auth.currentUser!.updatePassword(newPassword);
        print('Password updated successfully!');
      } else {
        success = false;
      }

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Mot de passe changé avec succès !'),
            backgroundColor: Colors.green,
          ),
        );
        Future.delayed(Duration(seconds: 3), () async {
          await FirebaseAuth.instance.signOut();
          Navigator.of(context).popUntil((route) => route.isFirst);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors du changement de mot de passe !'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    return Container(
      height: 1000,
      width: 300,
      child: Center(
        child: Container(
          width: 350,
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF80CFCC),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    Center(
                      child: Text(
                        'Changer le mot de passe',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          color: Colors.white,
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
              TextField(
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
              SizedBox(height: 10),
              TextField(
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
              SizedBox(height: 10),
              TextField(
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
                    var response = await http.get(Uri.parse(
                        'http://127.0.0.1:8000/api/utilisateur/' + userEmail));
                    var user = json.decode(response.body);
                    if (_oldPasswordController.text.isEmpty ||
                        _newPasswordController.text.isEmpty ||
                        _confirmPasswordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Veuillez remplir tous les champs !'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    if (_oldPasswordController.text != user['MotPass']) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Veuillez confirmer bien l\'ancien mot de passe !'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    if (_newPasswordController.text !=
                        _confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Veuillez confirmer bien le nouveau mot de passe !'),
                          backgroundColor: Colors.red,
                        ),
                      );
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
                  child: Text('Changer !',
                      style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
