import 'dart:math';

import 'package:google_maps_utils/google_maps_utils.dart';
import 'package:google_maps_utils/utils/poly_utils.dart';

//parc visite
List<Point> visite = [
  Point(36.759493, 3.069634),
  Point(36.758370, 3.069650),
  Point(36.758312, 3.068649),
  Point(36.757390, 3.068647),
  Point(36.757397, 3.066648),
  Point(36.759541, 3.066643),
];
List<Point> vparc1 = [
  Point(36.759492, 3.067233),
  Point(36.757389, 3.067229),
  Point(36.757391, 3.066671),
  Point(36.759481, 3.066662),
];
List<Point> vparc2 = [
  Point(36.759502, 3.067983),
  Point(36.757392, 3.068011),
  Point(36.757402, 3.067413),
  Point(36.759481, 3.067420),
];
List<Point> vparc3 = [
  Point(36.759483, 3.068479),
  Point(36.757404, 3.068480),
  Point(36.757397, 3.068203),
  Point(36.759475, 3.068199),
];
List<Point> vparc4 = [
  Point(36.759467, 3.068824),
  Point(36.758347, 3.068821),
  Point(36.758332, 3.068677),
  Point(36.759483, 3.068669),
];
List<Point> vparc5 = [
  Point(36.759458, 3.069130),
  Point(36.758400, 3.069129),
  Point(36.758389, 3.068974),
  Point(36.759452, 3.068980),
];
List<Point> vparc6 = [
  Point(36.759481, 3.069417),
  Point(36.758398, 3.069416),
  Point(36.758378, 3.069274),
  Point(36.759465, 3.069274),
];

//parc embarquement
List<Point> embarquement = [
  Point(36.765031, 3.065203),
  Point(36.764498, 3.065068),
  Point(36.764749, 3.063818),
  Point(36.765278, 3.064016),
];
List<Point> eparc1 = [
  Point(36.765216, 3.064111),
  Point(36.765227, 3.064048),
  Point(36.764757, 3.063859),
  Point(36.764742, 3.063944),
];

List<Point> eparc2 = [
  Point(36.765206, 3.064230),
  Point(36.765193, 3.064311),
  Point(36.764714, 3.064155),
  Point(36.764726, 3.064047),
];

List<Point> eparc3 = [
  Point(36.765122, 3.064526),
  Point(36.765170, 3.064422),
  Point(36.764698, 3.064253),
  Point(36.764680, 3.064352),
];

List<Point> eparc4 = [
  Point(36.765102, 3.064732),
  Point(36.764614, 3.064583),
  Point(36.764635, 3.064479),
  Point(36.765116, 3.064633),
];

List<Point> eparc5 = [
  Point(36.765049, 3.064968),
  Point(36.764573, 3.064824),
  Point(36.764591, 3.064727),
  Point(36.765063, 3.064879),
];
List<Point> eparc6 = [
  Point(36.765006, 3.065174),
  Point(36.764542, 3.065027),
  Point(36.764552, 3.064928),
  Point(36.765024, 3.065101),
];

//parcs livraison
List<Point> livraison = [
  Point(36.761924, 3.066640),
  Point(36.759702, 3.066584),
  Point(36.759630, 3.069592),
  Point(36.761906, 3.069567),
];

List<Point> lparc1 = [
  Point(36.761853, 3.067301),
  Point(36.759725, 3.067290),
  Point(36.759706, 3.066662),
  Point(36.761883, 3.066660),
];
List<Point> lparc2 = [
  Point(36.761883, 3.068004),
  Point(36.759713, 3.068014),
  Point(36.759700, 3.067438),
  Point(36.761888, 3.067471),
];
List<Point> lparc3 = [
  Point(36.761861, 3.068497),
  Point(36.759715, 3.068521),
  Point(36.759707, 3.068203),
  Point(36.761851, 3.068206),
];
List<Point> lparc4 = [
  Point(36.761878, 3.068836),
  Point(36.759718, 3.068828),
  Point(36.759707, 3.068670),
  Point(36.761866, 3.068697),
];
List<Point> lparc5 = [
  Point(36.761858, 3.069136),
  Point(36.759721, 3.069133),
  Point(36.759723, 3.068991),
  Point(36.761852, 3.068986),
];
List<Point> lparc6 = [
  Point(36.761853, 3.069436),
  Point(36.759707, 3.069424),
  Point(36.759707, 3.069271),
  Point(36.761841, 3.069266),
];

//parcs stockage
List<Point> stockage = [
  Point(36.758038, 3.069252),
  Point(36.756448, 3.069220),
  Point(36.756430, 3.071805),
  Point(36.757070, 3.071787),
  Point(36.757681, 3.069996),
  Point(36.757988, 3.069973),
];
List<Point> sparc1 = [
  Point(36.756874, 3.070098),
  Point(36.756620, 3.070098),
  Point(36.756629, 3.071524),
  Point(36.756883, 3.071518),
];
List<Point> sparc2 = [
  Point(36.756954, 3.071429),
  Point(36.757134, 3.071423),
  Point(36.757134, 3.070096),
  Point(36.756957, 3.070096),
];
List<Point> sparc3 = [
  Point(36.757044, 3.069822),
  Point(36.757041, 3.069285),
  Point(36.756824, 3.069289),
  Point(36.756812, 3.069824),
];
List<Point> sparc4 = [
  Point(36.757943, 3.069979),
  Point(36.757706, 3.069993),
  Point(36.757709, 3.069297),
  Point(36.757948, 3.069295),
];
List<Point> sparc5 = [
  Point(36.757643, 3.069971),
  Point(36.757243, 3.069998),
  Point(36.757243, 3.069300),
  Point(36.757637, 3.069297),
];

//parcs debarquement

List<Point> debarquement = [
  Point(36.761362, 3.072027),
  Point(36.757449, 3.072114),
  Point(36.757463, 3.072588),
  Point(36.761360, 3.072684),
];
List<Point> dparc1 = [
  Point(36.761095, 3.072462),
  Point(36.759714, 3.072461),
  Point(36.759714, 3.072153),
  Point(36.761098, 3.072160),
];

List<Point> dparc2 = [
  Point(36.759515, 3.072458),
  Point(36.757468, 3.072452),
  Point(36.757468, 3.072144),
  Point(36.759514, 3.072133),
];
void getPosition(Point point, String zone, String parc) {
  if (PolyUtils.containsLocationPoly(point, debarquement)) {
    zone = 'Debarquement';
    if (PolyUtils.containsLocationPoly(point, dparc1)) {
      parc = 'Parc 1';
    }
    if (PolyUtils.containsLocationPoly(point, dparc2)) {
      parc = 'Parc 2';
    }
  }
  if (PolyUtils.containsLocationPoly(point, embarquement)) {
    zone = 'Embarquement';
    if (PolyUtils.containsLocationPoly(point, eparc1)) {
      parc = 'Parc 1';
    }
    if (PolyUtils.containsLocationPoly(point, eparc2)) {
      parc = 'Parc 2';
    }
    if (PolyUtils.containsLocationPoly(point, eparc3)) {
      parc = 'Parc 3';
    }
    if (PolyUtils.containsLocationPoly(point, eparc4)) {
      parc = 'Parc 4';
    }
    if (PolyUtils.containsLocationPoly(point, eparc5)) {
      parc = 'Parc 5';
    }
    if (PolyUtils.containsLocationPoly(point, eparc6)) {
      parc = 'Parc 6';
    }
  }
  if (PolyUtils.containsLocationPoly(point, livraison)) {
    zone = 'Livraison';
    if (PolyUtils.containsLocationPoly(point, lparc1)) {
      parc = 'Parc 1';
    }
    if (PolyUtils.containsLocationPoly(point, lparc2)) {
      parc = 'Parc 2';
    }
    if (PolyUtils.containsLocationPoly(point, lparc3)) {
      parc = 'Parc 3';
    }
    if (PolyUtils.containsLocationPoly(point, lparc4)) {
      parc = 'Parc 4';
    }
    if (PolyUtils.containsLocationPoly(point, lparc5)) {
      parc = 'Parc 5';
    }
    if (PolyUtils.containsLocationPoly(point, lparc6)) {
      parc = 'Parc 6';
    }
  }
  if (PolyUtils.containsLocationPoly(point, stockage)) {
    zone = 'Stockage';
    if (PolyUtils.containsLocationPoly(point, sparc1)) {
      parc = 'Parc 1';
    }
    if (PolyUtils.containsLocationPoly(point, sparc2)) {
      parc = 'Parc 2';
    }
    if (PolyUtils.containsLocationPoly(point, sparc3)) {
      parc = 'Parc 3';
    }
    if (PolyUtils.containsLocationPoly(point, sparc4)) {
      parc = 'Parc 4';
    }
    if (PolyUtils.containsLocationPoly(point, sparc5)) {
      parc = 'Parc 5';
    }
  }
  if (PolyUtils.containsLocationPoly(point, visite)) {
    zone = 'Visite';
    if (PolyUtils.containsLocationPoly(point, vparc1)) {
      parc = 'Parc 1';
    }
    if (PolyUtils.containsLocationPoly(point, vparc2)) {
      parc = 'Parc 2';
    }
    if (PolyUtils.containsLocationPoly(point, vparc3)) {
      parc = 'Parc 3';
    }
    if (PolyUtils.containsLocationPoly(point, vparc4)) {
      parc = 'Parc 4';
    }
    if (PolyUtils.containsLocationPoly(point, vparc5)) {
      parc = 'Parc 5';
    }
    if (PolyUtils.containsLocationPoly(point, vparc6)) {
      parc = 'Parc 6';
    }
  }
}
