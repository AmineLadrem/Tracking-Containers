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
      title: Padding(
        padding: const EdgeInsets.only(left: 815),
        child: Row(
          children: [
            Visibility(
                child: CustomText(
                    text: "Tableau de board",
                    color: dark,
                    size: 20,
                    weight: FontWeight.bold)),
            Expanded(child: Container()),
          ],
        ),
      ),
      backgroundColor: back,
    );
