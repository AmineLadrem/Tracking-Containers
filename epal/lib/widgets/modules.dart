import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GererModule extends StatefulWidget {
  const GererModule({super.key});

  @override
  State<GererModule> createState() => _modulesState();
}

class _modulesState extends State<GererModule> {
  @override
  Widget build(BuildContext context) {
    final ModuleIDController = TextEditingController();
    final ModuleBatterieController = TextEditingController();
    Future<void> _makeApiCall() async {
      final String apiUrl = 'http://127.0.0.1:8000/api/modulesuivis?ModNum=' +
          ModuleIDController.text +
          '&ModBatterie=' +
          ModuleBatterieController.text;
      print(apiUrl);

      final response = await http.post(Uri.parse(apiUrl));

      //pop notification
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Module ajouté avec succès'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de l\'ajout du module'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    return Container(
      height: 1000,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
    );
  }
}
