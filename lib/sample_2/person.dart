import 'package:hive_flutter/hive_flutter.dart';
part 'person.g.dart';

@HiveType(typeId: 1)
class Person {
  Person({required this.name, required this.age, required this.man});
  
  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  @HiveField(2, defaultValue: true)
  bool man;

  // @HiveField(3)
  // List<Person> friends;
}
