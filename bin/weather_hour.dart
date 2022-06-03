class WeatherByHour {
  List soat = [];
  List havoBosimi = [];
  List temperatura = [];
  List shamolTezligi = [];
  List yoginEhtimoli = [];

  void getWeatherByHour() {
    for (var i = 0; i < soat.length; i++) {
      print(
          "Soat: ${soat[i]}  |  Havo bosimi: ${havoBosimi[i]}  |  Temperatura: ${temperatura[i]}  |  Shamol tezligi: ${shamolTezligi[i]}  |  Yog'ingarchilik: ${yoginEhtimoli[i]}");
    }
  }
}
