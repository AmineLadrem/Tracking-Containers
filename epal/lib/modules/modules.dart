class module {
  late int ModNum;
  late String ModStatus;
  late double ModBatterie;
  late double PositionX;
  late double PositionY;
  late double PositionH;

  module(this.ModNum, this.ModStatus, this.ModBatterie, this.PositionX,
      this.PositionY, this.PositionH);

  module.fromJson(Map<String, dynamic> json) {
    ModNum = json['ModNum'];
    ModStatus = json['ModStatus'];
    ModBatterie = json['ModBatterie'];
    PositionX = json['PositionX'];
    PositionY = json['PositionY'];
    PositionH = json['PositionH'];
  }
}
