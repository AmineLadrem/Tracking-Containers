class module {
  int? ModNum;
  String? ModStatus;
  int? ModBattrie;

  module(this.ModNum, this.ModStatus, this.ModBattrie);

  static List<module> modules = [
    module(1, "ON", 100),
    module(24, "ON", 30),
    module(55, "OFF", 5),
    module(200, "ON", 50),
  ];
}
