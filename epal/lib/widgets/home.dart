import 'package:epal/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class home extends StatefulWidget {
  const home({Key? key});

  @override
  State<home> createState() => _homeState();
}

class ContainerData {
  String status;
  int count;

  ContainerData(this.status, this.count);
}

class ModuleData {
  String status;
  int count;

  ModuleData(this.status, this.count);
}

class _homeState extends State<home> {
  List<dynamic> containers = [];
  List<dynamic> modules = [];
  Future<List<dynamic>> fetchData() async {
    final response =
        await http.get(Uri.parse("http://127.0.0.1:8000/api/conteneur"));
    containers = json.decode(response.body);
    List<dynamic> statusCount = [];
    for (var container in containers) {
      String status = container['Cont_Status'];
      int count = statusCount.where((item) => item['status'] == status).length;
      if (count > 0) {
        for (var item in statusCount) {
          if (item['status'] == status) {
            item['count'] += 1;
            break;
          }
        }
      } else {
        statusCount.add({'status': status, 'count': 1});
      }
    }
    List<ContainerData> containerDataList = statusCount
        .map((statusCount) => ContainerData(
              statusCount['status'],
              statusCount['count'],
            ))
        .toList();
    return containerDataList;
  }

  Future<List<dynamic>> fetchModules() async {
    final response =
        await http.get(Uri.parse("http://127.0.0.1:8000/api/modulesuivis"));
    modules = json.decode(response.body);
    List<dynamic> statusCount = [];
    for (var module in modules) {
      String status = module['ModStatus'];
      int count = statusCount.where((item) => item['status'] == status).length;
      if (count > 0) {
        for (var item in statusCount) {
          if (item['status'] == status) {
            item['count'] += 1;
            break;
          }
        }
      } else {
        // Add a new status with count 1
        statusCount.add({'status': status, 'count': 1});
      }
    }
    List<ContainerData> moduleDataList = statusCount
        .map((statusCount) => ContainerData(
              statusCount['status'],
              statusCount['count'],
            ))
        .toList();
    return moduleDataList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Text(
          'Traffic Conteneurs',
          style: TextStyle(
              fontSize: 30,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.bold,
              color: dark),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            SizedBox(width: 260),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0xFF80CFCC),
                  width: 1.0,
                ),
              ),
              child: Row(
                children: [
                  Transform.rotate(
                    angle: 3.14, // 180 degrees in radians
                    child: Icon(
                      Icons.arrow_outward_outlined,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(children: [
                    Text(
                      'Débarquement',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Urbanist',
                          color: dark,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Réalisation 2020:',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Urbanist',
                                color: dark,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' 170445',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Urbanist',
                                color: dark,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Text(
                              'Réalisation 2021:',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Urbanist',
                                color: dark,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' 138398',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Urbanist',
                                color: dark,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Text(
                              'Réalisation 2022:',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Urbanist',
                                color: dark,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' 120112',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Urbanist',
                                color: dark,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    )
                  ]),
                  TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Fermer'),
                                ),
                              ],
                              title: Center(
                                  child: Text(
                                'Details',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Urbanist',
                                  color: dark,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                              content: Container(
                                height: 280,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Color(0xFF80CFCC),
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 150,
                                            height: 10,
                                          ),
                                          Text(
                                            'Réalisation 2020',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Urbanist',
                                              color: dark,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'Pleins 20p: 47893',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Urbanist',
                                              color: dark,
                                            ),
                                          ),
                                          Text(
                                            'Pleins 40p: 61276',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Urbanist',
                                              color: dark,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 150,
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: 150,
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Color(0xFF80CFCC),
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 150,
                                            height: 10,
                                          ),
                                          Text(
                                            'Réalisation 2021',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Urbanist',
                                              color: dark,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'Pleins 20p: 36972',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Urbanist',
                                              color: dark,
                                            ),
                                          ),
                                          Text(
                                            'Pleins 40p: 50713',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Urbanist',
                                              color: dark,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 150,
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Color(0xFF80CFCC),
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 150,
                                            height: 10,
                                          ),
                                          Text(
                                            'Réalisation 2022',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Urbanist',
                                              color: dark,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'Pleins 20p: 30488',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Urbanist',
                                              color: dark,
                                            ),
                                          ),
                                          Text(
                                            'Pleins 40p: 44812',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Urbanist',
                                              color: dark,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 150,
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Row(
                      children: [Icon(Icons.menu, color: Colors.black)],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 360),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0xFF80CFCC),
                  width: 1.0,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_outward_outlined,
                    color: Colors.green,
                    size: 40,
                  ),
                  SizedBox(width: 10),
                  Column(children: [
                    Text(
                      'Embarquement',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Urbanist',
                          color: dark,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Réalisation 2020:',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Urbanist',
                                color: dark,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' 173026',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Urbanist',
                                color: dark,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Réalisation 2021:',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Urbanist',
                                color: dark,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' 145559',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Urbanist',
                                color: dark,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Réalisation 2022:',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Urbanist',
                                color: dark,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' 126390',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Urbanist',
                                color: dark,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                      ],
                    )
                  ]),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 30),
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Fermer'),
                                  ),
                                ],
                                title: Center(
                                  child: Text(
                                    'Details',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Urbanist',
                                      color: dark,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                content: Container(
                                  height: 230,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Color(0xFF80CFCC),
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 150,
                                              height: 10,
                                            ),
                                            Text(
                                              'Réalisation 2020',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'Urbanist',
                                                color: dark,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: dark,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Catégorie 20p',
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontFamily: 'Urbanist',
                                                        color: dark,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text(
                                                              'Pleins:',
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    'Urbanist',
                                                                color: dark,
                                                              ),
                                                            ),
                                                            Text(
                                                              '1886',
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    'Urbanist',
                                                                color: dark,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                              'Vides:',
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    'Urbanist',
                                                                color: dark,
                                                              ),
                                                            ),
                                                            Text(
                                                              '47000',
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    'Urbanist',
                                                                color: dark,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: dark,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Catégorie 40p',
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontFamily: 'Urbanist',
                                                        color: dark,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text(
                                                              'Pleins:',
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    'Urbanist',
                                                                color: dark,
                                                              ),
                                                            ),
                                                            Text(
                                                              '3515',
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    'Urbanist',
                                                                color: dark,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                              'Vides:',
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    'Urbanist',
                                                                color: dark,
                                                              ),
                                                            ),
                                                            Text(
                                                              '58555',
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    'Urbanist',
                                                                color: dark,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 150,
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),

                                      // Rest of your sections
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Row(
                          children: [
                            Icon(Icons.menu, color: Colors.black),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(Icons.menu, color: Colors.black),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(Icons.menu, color: Colors.black),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FutureBuilder<List<dynamic>>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  List<ContainerData> containerData =
                      snapshot.data!.cast<ContainerData>();

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color(0xFF80CFCC),
                        width: 1.0,
                      ),
                    ),
                    height: 500,
                    width: 500,
                    child: SfCircularChart(
                      legend: Legend(
                        isVisible: true,
                        overflowMode: LegendItemOverflowMode.scroll,
                      ),
                      title: ChartTitle(
                        text: 'Répartition des conteneurs par status',
                        textStyle: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Urbanist',
                            color: dark,
                            fontWeight: FontWeight.bold),
                      ),
                      series: <CircularSeries>[
                        RadialBarSeries<ContainerData, String>(
                          dataSource: containerData,
                          xValueMapper: (ContainerData container, _) =>
                              container.status,
                          yValueMapper: (ContainerData container, _) =>
                              container.count,
                          dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                            labelPosition: ChartDataLabelPosition.outside,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            FutureBuilder<List<dynamic>>(
              future: fetchModules(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  List<ContainerData> moduleData =
                      snapshot.data!.cast<ContainerData>();

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color(0xFF80CFCC),
                        width: 1.0,
                      ),
                    ),
                    height: 500,
                    width: 500,
                    child: SfCircularChart(
                      legend: Legend(
                        isVisible: true,
                        overflowMode: LegendItemOverflowMode.wrap,
                      ),
                      title: ChartTitle(
                        text: 'Répartition des modules par status',
                        textStyle: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Urbanist',
                            color: dark,
                            fontWeight: FontWeight.bold),
                      ),
                      series: <CircularSeries>[
                        PieSeries<ContainerData, String>(
                          dataSource: moduleData,
                          xValueMapper: (ContainerData container, _) =>
                              container.status,
                          yValueMapper: (ContainerData container, _) =>
                              container.count,
                          dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                            labelPosition: ChartDataLabelPosition.inside,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
