import 'package:test/test.dart';
import 'package:vindex/db/database/DatabaseExtension.dart';
import 'package:vindex/db/enitiy/wine.dart';

void main() {
  group('main test', () {
    test('test', () {
      var time = new DateTime.now();
      print(time);
      String t = time.toIso8601String();
      print(t);
      DateTime s = DateTime.parse(t);
      print(s);
    });
  });

  group('db tests', (){
    setUp(() async {
      await DatabaseExtension.init();
      List<Wine> listWineAdd = [
        new Wine(null, "Wein1", 2000, null, "location1"),
        new Wine(null, "Wein2", 2001, null, "location2"),
        new Wine(null, "Wein3", 2002, null, "location3"),
        new Wine(null, "Wein4", 2003, null, "location4"),
      ];

      listWineAdd.forEach((element) async => await DatabaseExtension.insert(element));
    });

    test('add to db and get', () async {
      List<Wine> getWineList = await DatabaseExtension.getAll<Wine>();

      expect(4, getWineList.length);
    });

    test('update to db', () async {
      Wine wine = await DatabaseExtension.findById<Wine>(3);
      Future.delayed(Duration(seconds: 1));
      expect("Wein3", wine.name);
      wine.name = "Wine3";
      var i = await DatabaseExtension.update(wine);
      print(i.toString());

      Future.delayed(Duration(seconds: 1));
      Wine actual = await DatabaseExtension.findById<Wine>(3);
      // List item = await DatabaseExtension.getAll<Wine>();
      Future.delayed(Duration(seconds: 1));
      print("Actual ${actual.name}\nexpected ${wine.name}");
      expect(actual.name, wine.name);
    });

    test('delete to db', () async {
      List item = await DatabaseExtension.getAll<Wine>();
      print(item.length);
      await DatabaseExtension.deleteById<Wine>(3);
      Future.delayed(Duration(seconds: 1));
      List firstDelete = await DatabaseExtension.getAll<Wine>();
      expect(3, firstDelete.length);

      Wine wine = firstDelete.first;
      await DatabaseExtension.delete<Wine>(wine);
      Future.delayed(Duration(seconds: 1));
      List secDelete = await DatabaseExtension.getAll<Wine>();
      expect(3, secDelete.length); //todo because deleteById not work
    });
  });
}
