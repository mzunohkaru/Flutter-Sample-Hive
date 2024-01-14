import 'package:hive/hive.dart';
import 'package:hive_sample/sample_2/person.dart';

class HiveService {
  final String _boxName = 'personBox';

  Future<Box<Person>> get _box async => await Hive.openBox<Person>(_boxName);

  Future addItem(Person person) async {
    var box = await _box;
    await box.add(person);
  }

  Future<List<Person>> getAllItems() async {
    var box = await _box;
    return box.values.toList();
  }

  Future deleteItem(int index) async {
    var box = await _box;
    await box.deleteAt(index);
  }

  Future deleteAllItems() async {
    var box = await _box;
    box.clear();
  }

  Future updateItem(int index, Person person) async {
    var box = await _box;
    person.man = !person.man;
    await box.putAt(index, person);
  }
}
