import 'package:epal/constants/style.dart';
import 'package:epal/helpers/responsive.dart';
import 'package:epal/widgets/custom_text.dart';
import 'package:flutter/material.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      leading: !ResponsiveWidget.isSmallScreen(context)
          ? Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 14),
                  child: Image.asset("assets/ae.png", width: 42, height: 42),
                )
              ],
            )
          : IconButton(
              icon: Icon(
                Icons.menu,
                color: dark,
              ),
              onPressed: () {
                key.currentState?.openDrawer();
              },
            ),
      elevation: 0,
      title: Row(
        children: [
          Visibility(
              child: CustomText(
                  text: "Tableau de board",
                  color: dark,
                  size: 20,
                  weight: FontWeight.bold)),
          Expanded(child: Container()),
          Stack(children: [
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: dark.withOpacity(.9),
              ),
              onPressed: () {},
            ),
            Positioned(
              top: 7,
              right: 7,
              child: Container(
                width: 12,
                height: 12,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: medium,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: light, width: 2),
                ),
              ),
            ),
          ]),
          Container(
            height: 24.0,
            width: 0.5,
            color: dark,
            margin: EdgeInsets.symmetric(horizontal: 12.0),
          ),
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'profile',
                child: Text('Profile'),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
            onSelected: (String value) async {
              if (value == 'profile') {
                // Navigate to profile screen
              } else if (value == 'logout') {
                // Handle logout
              }
            },
            child: IconButton(
              icon: Icon(Icons.menu, color: dark.withOpacity(.9)),
              onPressed: () {
                // Show menu
                showMenu<String>(
                  context: context,
                  position: RelativeRect.fromLTRB(1000, 0, 0, 0),
                  items: <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'profile',
                      child: Row(
                        children: [
                          Icon(Icons.person),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Profile')
                        ],
                      ),
                    ),
                    const PopupMenuItem<String>(
                      value: 'logout',
                      child: Row(
                        children: [
                          Icon(Icons.logout),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Se déconnecter')
                        ],
                      ),
                    ),
                  ],
                ).then((String? value) {
                  if (value != null) {
                    if (value == 'profile') {
                      // Navigate to profile screen
                    } else if (value == 'logout') {
                      // Handle logout
                    }
                  }
                });
              },
            ),
          )
        ],
      ),
      backgroundColor: back,
    );
