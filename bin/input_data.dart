class InputData {
  String? country;
  String? region;
  String? month;

  String get getBoxName => "$country-$region-$month";

  String get query => "/$country/$region/$month";
}
