class module {
  int? modNum;
  String? modStatus;
  int? modBatterie;
  int? positionX;
  int? positionY;
  int? positionH;

  module({
    this.modNum,
    this.modStatus,
    this.modBatterie,
    this.positionX,
    this.positionY,
    this.positionH,
  });

  module.fromJson(Map<String, dynamic> json) {
    modNum = json['ModNum'];
    modStatus = json['ModStatus'];
    modBatterie = json['ModBatterie'];
    positionX = json['PositionX'];
    positionY = json['PositionY'];
    positionH = json['PositionH'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ModNum'] = this.modNum;
    data['ModStatus'] = this.modStatus;
    data['ModBatterie'] = this.modBatterie;
    data['PositionX'] = this.positionX;
    data['PositionY'] = this.positionY;
    data['PositionH'] = this.positionH;

    return data;
  }
}
