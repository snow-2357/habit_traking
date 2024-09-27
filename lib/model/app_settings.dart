import 'package:isar/isar.dart';

part 'app_settings.g.dart';
//dart run build_runner build

@Collection()
class AppSettings {
  Id id = Isar.autoIncrement;
  DateTime? firstLunchDate;
}
