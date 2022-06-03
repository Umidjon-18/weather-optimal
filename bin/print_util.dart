import 'dart:io';

class PrintUtil {
  String askCountry() {
    print("Assalomu alaykum \n\nSelect country. Example : Russia");
    String country = stdin.readLineSync()!.trim().toLowerCase();
    return country;
  }

  String askRegion() {
    print("Select region. Example: Moscow");
    String region = stdin.readLineSync()!.trim().toLowerCase();
    return region;
  }

  String askMonth() {
    print("Select month. Example : november");
    String month = stdin.readLineSync()!.trim();
    return month;
  }

  int getOption() {
    print('''
    -------------------------
      1) Oylik ma'lumot
      2) Kunlik ma'lumot
      3) Soatlik ma'lumot
    -------------------------
    ''');
    int option = int.parse(stdin.readLineSync()!.trim());
    return option;
  }

  int askDay() {
    print("Select day. Example : 1");
    int day = int.parse(stdin.readLineSync()!.trim());
    return day;
  }

  getError() {
    print("Noto'g'ri ma'lumot kiritildi !!!");
  }

  exitOrContinue() {
    print("Davom etish uchun Enter | Chiqish uchun istalgan boshqa tugmani bosing");
    var option = stdin.readLineSync()!;
    if (option.isNotEmpty) exit(0);
  }

  clear() {
    print(Process.runSync("clear", [], runInShell: true).stdout);
  }
}
