import 'package:epal/icons.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar(
      {Key? key,
      required this.selectedIndex,
      required this.onItemTapped,
      this.visible = const []})
      : super(key: key);

  final int selectedIndex;
  final void Function(int) onItemTapped;
  final List<bool> visible;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: BottomNavigationBar(
        items: [
          if (visible[0])
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Acceuil',
            ),
          if (visible[1])
            BottomNavigationBarItem(
              icon: Icon(Icons.transform_outlined),
              label: 'Mes Demandes',
            ),
          if (visible[2])
            BottomNavigationBarItem(
              icon: Icon(Icons.compare_arrows),
              label: 'Deplacer',
            ),
          if (visible[3])
            BottomNavigationBarItem(
              icon: Icon(MyFlutterApp.container),
              label: 'Conteneurs',
            ),
          if (visible[4])
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        onTap: onItemTapped,
      ),
    );
  }
}
