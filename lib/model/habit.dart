import 'package:isar/isar.dart';

part "habit.g.dart";

@collection
class Habit {
  Id id = Isar.autoIncrement;
  late String habitName;
  List<DateTime> complatedDays = [
    //DateTime(year,month,day)
  ];

  String get name => null;
}
