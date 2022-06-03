import 'package:hive/hive.dart';

mixin HiveUtil {
  Future addAllToBox<T>(String boxname, Iterable<T> list) async {
    Box<T> box = await checkingBox<T>(boxname);
    await box.addAll(list);
  }

  Future<Box<T>> getAllBox<T>(String boxname) async {
    Box<T> box = await checkingBox<T>(boxname);
    return Future<Box<T>>.value(box);
  }

  Future<Box<T>> checkingBox<T>(String boxname) async {
    if (Hive.isBoxOpen(boxname)) {
      return Hive.box<T>(boxname);
    } else {
      return Future<Box<T>>.value(Hive.openBox<T>(boxname));
    }
  }

  Future<bool> isEmptyBox<T>(String boxname) async {
    Box<T> box = await checkingBox<T>(boxname);
    return Future<bool>.value(box.isEmpty);
  }
}
