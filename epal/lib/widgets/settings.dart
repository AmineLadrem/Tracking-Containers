import 'package:epal/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;

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
      try {
        await _auth.currentUser!.updatePassword(newPassword);
        print('Password updated successfully!');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'requires-recent-login') {
          print('Please reauthenticate to change your password.');
          success = false;
          // You can prompt the user to reauthenticate here
        } else {
          print('Error changing password: $e');
          success = false;
        }
      }

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Mot de passe changé avec succès !'),
            backgroundColor: Colors.green,
          ),
        );
        await FirebaseAuth.instance.signOut();
        Navigator.of(context).popUntil((route) => route.isFirst);
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
                  color: light,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
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
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon:
                        IconButton(onPressed: () {}, icon: Icon(Icons.clear)),
                    labelText: 'Mot de passe actuel',
                    hintText: 'Mot de passe actuel'),
                controller: _oldPasswordController,
                obscureText: true,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon:
                        IconButton(onPressed: () {}, icon: Icon(Icons.clear)),
                    labelText: 'Nouveau mot de passe',
                    hintText: 'Nouveau mot de passe'),
                controller: _newPasswordController,
                obscureText: true,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon:
                        IconButton(onPressed: () {}, icon: Icon(Icons.clear)),
                    labelText: 'Confirmer le nouveau mot de passe',
                    hintText: 'Confirmer le nouveau mot de passe'),
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
                    // Show the alert dialog
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
                        MaterialStateProperty.all<Color>(Color(0xFF8FABFE)),
                  ),
                  child: Text('Changer !',
                      style: TextStyle(fontFamily: 'Poppins')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
