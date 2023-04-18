import 'package:epal/constants/style.dart';
import 'package:epal/helpers/responsive.dart';
import 'package:epal/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateTime now = DateTime.now();
String formattedTime = DateFormat('HH:mm:ss').format(now);

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
            Row(
              children: [
                StreamBuilder(
                  stream: Stream.periodic(Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    DateTime now = DateTime.now();
                    String formattedTime = DateFormat('HH:mm:ss').format(now);
                    return Text(
                      formattedTime,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Urbanist',
                          color: dark,
                          fontWeight: FontWeight.bold),
                    );
                  },
                ),
                Text(' | ', style: TextStyle(color: dark, fontSize: 20)),
                StreamBuilder(
                  stream: Stream.periodic(Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    DateTime now = DateTime.now();
                    String formattedDate = DateFormat('dd-MMM-yy').format(now);
                    return Text(
                      formattedDate,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.bold,
                        color: dark,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: back,
    );
