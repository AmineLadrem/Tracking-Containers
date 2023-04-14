import 'package:flutter/material.dart';

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.yellow,
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 1000.0),
          child: Container(
            height: 170,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Image.asset("assets/employee.png", width: 100, height: 100),
                SizedBox(width: 20),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(7.0),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: 'Employee ID: ',
                              style: TextStyle(
                                color: Color(0xFF02558F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              style: TextStyle(
                                color: Color(0xFF02558F),
                              ),
                              text: '2002',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(7.0),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: 'Prenom: ',
                              style: TextStyle(
                                color: Color(0xFF02558F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              style: TextStyle(
                                color: Color(0xFF02558F),
                              ),
                              text: 'Amine',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(7.0),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: 'Nom: ',
                              style: TextStyle(
                                color: Color(0xFF02558F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              style: TextStyle(
                                color: Color(0xFF02558F),
                              ),
                              text: 'Ladrem',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(7.0),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: 'Role: ',
                              style: TextStyle(
                                color: Color(0xFF02558F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              style: TextStyle(
                                color: Color(0xFF02558F),
                              ),
                              text: 'Chef de parc',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(7.0),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: 'Shift: ',
                              style: TextStyle(
                                color: Color(0xFF02558F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              style: TextStyle(
                                color: Color(0xFF02558F),
                              ),
                              text: 'Matin',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
