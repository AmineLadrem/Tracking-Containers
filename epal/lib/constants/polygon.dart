import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<Polygon> mylist = [
  Polygon(
    polygonId: PolygonId('Visite'),
    points: [
      LatLng(36.759493, 3.069634),
      LatLng(36.758370, 3.069650),
      LatLng(36.758312, 3.068649),
      LatLng(36.757390, 3.068647),
      LatLng(36.757397, 3.066648),
      LatLng(36.759541, 3.066643),
    ],
    strokeColor: Colors.blue,
    strokeWidth: 2,
    fillColor: Colors.blue.withOpacity(0.2),
  ),
  Polygon(
    polygonId: PolygonId('V/Parc1'),
    points: [
      LatLng(36.759492, 3.067233),
      LatLng(36.757389, 3.067229),
      LatLng(36.757391, 3.066671),
      LatLng(36.759481, 3.066662),
    ],
    strokeColor: Colors.yellow,
    strokeWidth: 2,
    fillColor: Colors.yellow.withOpacity(0.2),
  ),
  Polygon(
    polygonId: PolygonId('V/Parc2'),
    points: [
      LatLng(36.759502, 3.067983),
      LatLng(36.757392, 3.068011),
      LatLng(36.757402, 3.067413),
      LatLng(36.759481, 3.067420),
    ],
    strokeColor: Colors.yellow,
    strokeWidth: 2,
    fillColor: Colors.yellow.withOpacity(0.2),
  ),
  Polygon(
    polygonId: PolygonId('V/Parc3'),
    points: [
      LatLng(36.759483, 3.068479),
      LatLng(36.757404, 3.068480),
      LatLng(36.757397, 3.068203),
      LatLng(36.759475, 3.068199),
    ],
    strokeColor: Colors.yellow,
    strokeWidth: 2,
    fillColor: Colors.yellow.withOpacity(0.2),
  ),
  Polygon(
    polygonId: PolygonId('V/Parc4'),
    points: [
      LatLng(36.759467, 3.068824),
      LatLng(36.758347, 3.068821),
      LatLng(36.758332, 3.068677),
      LatLng(36.759483, 3.068669),
    ],
    strokeColor: Colors.yellow,
    strokeWidth: 2,
    fillColor: Colors.yellow.withOpacity(0.2),
  ),
  Polygon(
    polygonId: PolygonId('V/Parc5'),
    points: [
      LatLng(36.759458, 3.069130),
      LatLng(36.758400, 3.069129),
      LatLng(36.758389, 3.068974),
      LatLng(36.759452, 3.068980),
    ],
    strokeColor: Colors.yellow,
    strokeWidth: 2,
    fillColor: Colors.yellow.withOpacity(0.2),
  ),
  Polygon(
    polygonId: PolygonId('V/Parc6'),
    points: [
      LatLng(36.759481, 3.069417),
      LatLng(36.758398, 3.069416),
      LatLng(36.758378, 3.069274),
      LatLng(36.759465, 3.069274),
    ],
    strokeColor: Colors.yellow,
    strokeWidth: 2,
    fillColor: Colors.yellow.withOpacity(0.2),
  ),
  Polygon(
    polygonId: PolygonId('Embarquement'),
    points: [
      LatLng(36.765031, 3.065203),
      LatLng(36.764498, 3.065068),
      LatLng(36.764749, 3.063818),
      LatLng(36.765278, 3.064016),
    ],
    strokeColor: Colors.yellow,
    strokeWidth: 2,
    fillColor: Colors.yellow.withOpacity(0.2),
  ),
  Polygon(
    polygonId: PolygonId('E/Parc1'),
    points: [
      LatLng(36.765216, 3.064111),
      LatLng(36.765227, 3.064048),
      LatLng(36.764757, 3.063859),
      LatLng(36.764742, 3.063944),
    ],
    strokeColor: Colors.blue,
    strokeWidth: 2,
    fillColor: Colors.blue.withOpacity(0.2),
  ),
  Polygon(
    polygonId: PolygonId('E/Parc2'),
    points: [
      LatLng(36.765206, 3.064230),
      LatLng(36.765193, 3.064311),
      LatLng(36.764714, 3.064155),
      LatLng(36.764726, 3.064047),
    ],
    strokeColor: Colors.blue,
    strokeWidth: 2,
    fillColor: Colors.blue.withOpacity(0.2),
  ),
  Polygon(
    polygonId: PolygonId('E/Parc3'),
    points: [
      LatLng(36.765122, 3.064526),
      LatLng(36.765170, 3.064422),
      LatLng(36.764698, 3.064253),
      LatLng(36.764680, 3.064352),
    ],
    strokeColor: Colors.blue,
    strokeWidth: 2,
    fillColor: Colors.blue.withOpacity(0.2),
  ),
  Polygon(
    polygonId: PolygonId('E/Parc4'),
    points: [
      LatLng(36.765102, 3.064732),
      LatLng(36.764614, 3.064583),
      LatLng(36.764635, 3.064479),
      LatLng(36.765116, 3.064633),
    ],
    strokeColor: Colors.blue,
    strokeWidth: 2,
    fillColor: Colors.blue.withOpacity(0.2),
  ),
  Polygon(
    polygonId: PolygonId('E/Parc5'),
    points: [
      LatLng(36.765049, 3.064968),
      LatLng(36.764573, 3.064824),
      LatLng(36.764591, 3.064727),
      LatLng(36.765063, 3.064879),
    ],
    strokeColor: Colors.blue,
    strokeWidth: 2,
    fillColor: Colors.blue.withOpacity(0.2),
  ),
  Polygon(
    polygonId: PolygonId('E/Parc6'),
    points: [
      LatLng(36.765006, 3.065174),
      LatLng(36.764542, 3.065027),
      LatLng(36.764552, 3.064928),
      LatLng(36.765024, 3.065101),
    ],
    strokeColor: Colors.blue,
    strokeWidth: 2,
    fillColor: Colors.blue.withOpacity(0.2),
  ),
  Polygon(
    polygonId: PolygonId('Livraison'),
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
    polygonId: PolygonId('L/Parc1'),
    points: [
      LatLng(36.761853, 3.067301),
      LatLng(36.759725, 3.067290),
      LatLng(36.759706, 3.066662),
      LatLng(36.761883, 3.066660),
    ],
    strokeColor: Colors.green,
    strokeWidth: 2,
    fillColor: Colors.green.withOpacity(0.2),
  ),
  Polygon(
    polygonId: PolygonId('L/Parc2'),
    points: [
      LatLng(36.761883, 3.068004),
      LatLng(36.759713, 3.068014),
      LatLng(36.759700, 3.067438),
      LatLng(36.761888, 3.067471),
    ],
    strokeColor: Colors.green,
    strokeWidth: 2,
    fillColor: Colors.green.withOpacity(0.2),
  ),
  Polygon(
    polygonId: PolygonId('L/Parc3'),
    points: [
      LatLng(36.761861, 3.068497),
      LatLng(36.759715, 3.068521),
      LatLng(36.759707, 3.068203),
      LatLng(36.761851, 3.068206),
    ],
    strokeColor: Colors.green,
    strokeWidth: 2,
    fillColor: Colors.green.withOpacity(0.2),
  ),
  Polygon(
    polygonId: PolygonId('L/Parc4'),
    points: [
      LatLng(36.761878, 3.068836),
      LatLng(36.759718, 3.068828),
      LatLng(36.759707, 3.068670),
      LatLng(36.761866, 3.068697),
    ],
    strokeColor: Colors.green,
    strokeWidth: 2,
    fillColor: Colors.green.withOpacity(0.2),
  ),
  Polygon(
    polygonId: PolygonId('L/Parc5'),
    points: [
      LatLng(36.761858, 3.069136),
      LatLng(36.759721, 3.069133),
      LatLng(36.759723, 3.068991),
      LatLng(36.761852, 3.068986),
    ],
    strokeColor: Colors.green,
    strokeWidth: 2,
    fillColor: Colors.green.withOpacity(0.2),
  ),
  Polygon(
    polygonId: PolygonId('L/Parc6'),
    points: [
      LatLng(36.761853, 3.069436),
      LatLng(36.759707, 3.069424),
      LatLng(36.759707, 3.069271),
      LatLng(36.761841, 3.069266),
    ],
    strokeColor: Colors.green,
    strokeWidth: 2,
    fillColor: Colors.green.withOpacity(0.2),
  ),
  Polygon(
    polygonId: PolygonId('Stockage'),
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
    polygonId: PolygonId('S/Parc1'),
    points: [
      LatLng(36.756874, 3.070098),
      LatLng(36.756620, 3.070098),
      LatLng(36.756629, 3.071524),
      LatLng(36.756883, 3.071518),
    ],
    strokeColor: Colors.red,
    strokeWidth: 2,
    fillColor: Colors.red.withOpacity(0.2),
  ),
  Polygon(
    polygonId: PolygonId('S/Parc2'),
    points: [
      LatLng(36.756954, 3.071429),
      LatLng(36.757134, 3.071423),
      LatLng(36.757134, 3.070096),
      LatLng(36.756957, 3.070096),
    ],
    strokeColor: Colors.red,
    strokeWidth: 2,
    fillColor: Colors.red.withOpacity(0.2),
  ),
  Polygon(
    polygonId: PolygonId('S/Parc3'),
    points: [
      LatLng(36.757044, 3.069822),
      LatLng(36.757041, 3.069285),
      LatLng(36.756824, 3.069289),
      LatLng(36.756812, 3.069824),
    ],
    strokeColor: Colors.red,
    strokeWidth: 2,
    fillColor: Colors.red.withOpacity(0.2),
  ),
  Polygon(
    polygonId: PolygonId('S/Parc4'),
    points: [
      LatLng(36.757943, 3.069979),
      LatLng(36.757706, 3.069993),
      LatLng(36.757709, 3.069297),
      LatLng(36.757948, 3.069295),
    ],
    strokeColor: Colors.red,
    strokeWidth: 2,
    fillColor: Colors.red.withOpacity(0.2),
  ),
  Polygon(
    polygonId: PolygonId('S/Parc5'),
    points: [
      LatLng(36.757643, 3.069971),
      LatLng(36.757243, 3.069998),
      LatLng(36.757243, 3.069300),
      LatLng(36.757637, 3.069297),
    ],
    strokeColor: Colors.red,
    strokeWidth: 2,
    fillColor: Colors.red.withOpacity(0.2),
  ),
  Polygon(
    polygonId: PolygonId('Debarquement'),
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
  Polygon(
    polygonId: PolygonId('D/Parc1'),
    points: [
      LatLng(36.761095, 3.072462),
      LatLng(36.759714, 3.072461),
      LatLng(36.759714, 3.072153),
      LatLng(36.761098, 3.072160),
    ],
    strokeColor: Colors.blue,
    strokeWidth: 2,
    fillColor: Colors.blue.withOpacity(0.2),
  ),
  Polygon(
    polygonId: PolygonId('D/Parc2'),
    points: [
      LatLng(36.759515, 3.072458),
      LatLng(36.757468, 3.072452),
      LatLng(36.757468, 3.072144),
      LatLng(36.759514, 3.072133),
    ],
    strokeColor: Colors.blue,
    strokeWidth: 2,
    fillColor: Colors.blue.withOpacity(0.2),
  ),
];
