import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<Polygon> mylist = [
  Polygon(
    polygonId: PolygonId('square1'),
    points: [
      LatLng(36.759586, 3.066584),
      LatLng(36.757379, 3.066652),
      LatLng(36.757393, 3.069241),
      LatLng(36.759575, 3.069203),
    ],
    strokeColor: Colors.blue,
    strokeWidth: 2,
    fillColor: Colors.blue.withOpacity(0.2),
  ),
  Polygon(
    polygonId: PolygonId('square2'),
    points: [
      LatLng(36.761924, 3.066640),
      LatLng(36.759702, 3.066584),
      LatLng(36.759630, 3.069592),
      LatLng(36.761906, 3.069567),
    ],
    strokeColor: Colors.red,
    strokeWidth: 2,
    fillColor: Colors.red.withOpacity(0.2),
  ),
  Polygon(
    polygonId: PolygonId('square3'),
    points: [
      LatLng(36.758038, 3.069252),
      LatLng(36.756448, 3.069220),
      LatLng(36.756430, 3.071805),
      LatLng(36.757070, 3.071787),
      LatLng(36.757681, 3.069996),
      LatLng(36.757988, 3.069973),
    ],
    strokeColor: Colors.green,
    strokeWidth: 2,
    fillColor: Colors.green.withOpacity(0.2),
  ),
  Polygon(
    polygonId: PolygonId('square4'),
    points: [
      LatLng(36.761362, 3.072027),
      LatLng(36.757449, 3.072114),
      LatLng(36.757463, 3.072588),
      LatLng(36.761360, 3.072684),
    ],
    strokeColor: Colors.yellow,
    strokeWidth: 2,
    fillColor: Colors.yellow.withOpacity(0.2),
  ),
];

List<Point> psquare1 = [
  Point(36.759586, 3.066584),
  Point(36.757379, 3.066652),
  Point(36.757393, 3.069241),
  Point(36.759575, 3.069203),
];

List<Point> psquare2 = [
  Point(36.761924, 3.066640),
  Point(36.759702, 3.066584),
  Point(36.759630, 3.069592),
  Point(36.761906, 3.069567),
];

List<Point> psquare3 = [
  Point(36.758038, 3.069252),
  Point(36.756448, 3.069220),
  Point(36.756430, 3.071805),
  Point(36.757070, 3.071787),
  Point(36.757681, 3.069996),
  Point(36.757988, 3.069973),
];

List<Point> psquare4 = [
  Point(36.761362, 3.072027),
  Point(36.757449, 3.072114),
  Point(36.757463, 3.072588),
  Point(36.761360, 3.072684),
];
