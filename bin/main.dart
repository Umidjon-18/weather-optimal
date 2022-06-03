import 'package:hive/hive.dart';

import 'weather_data.dart';
import 'weather_model.dart';

void main(List<String> arguments) {
  Hive.init("../hive_db");
  Hive.registerAdapter<WeatherModel>(WeatherModelAdapter());
  WeatherData().weatherGo();
}
