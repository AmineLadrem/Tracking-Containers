class conteneur {
  int? ContID;
  String? Cont_Type;
  double? Cont_Poids;
  String? Cont_Status;
  double? Cont_PositionX;
  double? Cont_PositionY;
  double? Cont_PositionH;

  conteneur(this.ContID, this.Cont_Type, this.Cont_Poids, this.Cont_Status,
      this.Cont_PositionX, this.Cont_PositionY, this.Cont_PositionH);

  static List<conteneur> conteneurs = [
    conteneur(1, "Plastique", 10, "Delivered", 10, 10, 10),
    conteneur(2, "Plastique", 10, "Stocked", 10, 10, 10),
    conteneur(3, "Plastique", 10, "Delivered", 10, 10, 10),
    conteneur(4, "Plastique", 10, "Stocked", 10, 10, 10),
    conteneur(5, "Plastique", 10, "Delivered", 10, 10, 10),
  ];
}
