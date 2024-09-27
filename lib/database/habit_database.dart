import 'package:flutter/cupertino.dart';
import 'package:habit_tracking/model/app_settings.dart';
import 'package:habit_tracking/model/habit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar isar;

  // Initialize the database
  static Future<void> initialize() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open([HabitSchema, AppSettingsSchema],
          directory: dir.path);
    } catch (e) {
      rethrow;
    }
  }

  // Save first launch date
  Future<void> saveFirstLaunchDate() async {
    final existingSettings = await isar.appSettings.where().findFirst();
    if (existingSettings == null) {
      final settings = AppSettings()..firstLunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
      notifyListeners(); // Notify listeners if this affects the UI
    }
  }

  // Get first launch date
  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstLunchDate;
  }
  // crud

  final List<Habit> currentHabits = [];

  Future<void> addHabit(String habitName) async {
    final newHabit = Habit()..name = habitName;

    await isar.writeTxn(() => isar.habits.put(newHabit));

    readHabits();
  }

  Future<void> readHabits() async {
    List<Habit> res = await isar.habits.where().findAll();

    currentHabits.clear();
    currentHabits.addAll(res);

    notifyListeners();
  }

  //update with id and date and

  Future<void> updateHabitDate(int id, bool isCompleted) async {
    final habit = await isar.habits.get(id);
    if (habit != null) {
      await isar.writeTxn(() async {
        final today = DateTime.now();

        // Check if the habit was completed today
        if (isCompleted) {
          // If it's completed today and not already recorded, add today's date
          if (!habit.completedDays.any((date) =>
              date.year == today.year &&
              date.month == today.month &&
              date.day == today.day)) {
            habit.completedDays.add(
              DateTime(today.year, today.month, today.day),
            );
          }
        } else {
          // If it's not completed today, remove today's date if it exists
          habit.completedDays.removeWhere((date) =>
              date.year == today.year &&
              date.month == today.month &&
              date.day == today.day);
        }

        await isar.habits.put(habit); // Save changes to the database
      });

      await readHabits(); // Refresh the habits list
    }
  }

  //update the name
  Future<void> updateHabitName(int id, String newName) async {
    final habit = await isar.habits.get(id);
    if (habit != null) {
      await isar.writeTxn(() async {
        habit.name = newName;
        await isar.habits.put(habit);
      });
    }
    readHabits();
  }

  //delete habit
  Future<void> deleteHabit(int id) async {
    final habit = await isar.habits.get(id);
    if (habit != null) {
      await isar.writeTxn(() async {
        await isar.habits.delete(id);
      });
    }
    readHabits();
  }
}
