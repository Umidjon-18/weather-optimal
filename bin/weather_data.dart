import 'dart:async';
import 'dart:io';
import 'hive_util.dart';
import 'input_data.dart';
import 'print_util.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'weather_hour.dart';
import 'weather_model.dart';

class WeatherData with HiveUtil {
  PrintUtil util = PrintUtil();
  InputData data = InputData();
  final List<WeatherModel> _myList = [];

  weatherGo() async {
    data.country = util.askCountry();

    data.region = util.askRegion();

    data.month = util.askMonth();

    await connectAPI(data.query);

    var result = await getAllBox<WeatherModel>(data.getBoxName);

    var option = util.getOption();

    if (option == 1) {
      for (var item in result.values) {
        print(
            "Kun - ${item.day} . Kunduzi: ${item.tempDay}. ${item.tempNight}");
      }
    } else if (option == 2) {

      var day = util.askDay();
      var dayData = result.values.elementAt(day - 1);
      print("Kun - ${dayData.day} . Kunduzi: ${dayData.tempDay}. Kechasi: ${dayData.tempNight}");

    } else if (option == 3) {

      WeatherByHour resultByHour = await connectByHour(data.country!, data.region!);

      resultByHour.getWeatherByHour();

    } else {
      util.getError();
    }

    util.exitOrContinue();
    weatherGo();
  }

  connectAPI(String query) async {
    try {
      var response = await http
          .get(Uri.parse("https://world-weather.ru/pogoda/$query-2022"));
      if (response.statusCode == 200) {
        var document = parse(response.body);
        var weatherTemDay = document
            .getElementsByClassName("ww-month")[0]
            .getElementsByTagName("span")
            .map((e) => e.text)
            .toList();
        var weatherTemNight = document
            .getElementsByClassName("ww-month")[0]
            .getElementsByTagName("p")
            .map((e) => e.text)
            .toList();

        for (var i = 0; i < weatherTemDay.length; i++) {
          WeatherModel weather = WeatherModel();
          weather.day = (i + 1).toString();
          weather.tempDay = weatherTemDay[i];
          weather.tempNight = weatherTemNight[i];
          _myList.add(weather);
        }

        await addAllToBox<WeatherModel>(data.getBoxName, _myList);
      } else {
        print(
            "Bog'lanishda xatolik yuz berdi ❌\n  Status code : ${response.statusCode}");
        exit(0);
      }
    } catch (e) {
      print("Something error: $e");
    }
  }

  Future connectByHour<WeatherModel>(String country, String region) async {
    try {
      WeatherByHour weatherByHour = WeatherByHour();

      var response = await http.get(Uri.parse(
          'https://world-weather.ru/pogoda/$country/$region/24hours/'));

      if (response.statusCode == 200) {
        var document = parse(response.body);

        document.getElementsByClassName("weather-day").forEach((element) {
          weatherByHour.soat.add(element.text);
        });

        document.getElementsByClassName("weather-feeling").forEach((element) {
          weatherByHour.temperatura.add(element.text);
        });

        document
            .getElementsByClassName("weather-probability")
            .forEach((element) {
          weatherByHour.yoginEhtimoli.add(element.text);
        });

        document.getElementsByClassName("weather-pressure").forEach((element) {
          weatherByHour.havoBosimi.add(element.text);
        });

        document.getElementsByClassName("weather-wind").forEach((element) {
          weatherByHour.shamolTezligi
              .add(element.getElementsByTagName("span")[1].attributes["title"]);
        });

        return weatherByHour;
      } else {
        return {"status": response.statusCode};
      }
    } catch (e) {
      print("Xatolik bo'ldi: $e");
    }
  }
}
