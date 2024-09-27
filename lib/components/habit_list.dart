import 'package:flutter/material.dart';
import 'package:habit_tracking/database/habit_database.dart';
import 'package:habit_tracking/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class HabitList extends StatelessWidget {
  const HabitList({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final habitDatabase = Provider.of<HabitDatabase>(context);

    return ListView.builder(
      itemCount: habitDatabase.currentHabits.length,
      itemBuilder: (context, index) {
        final habit = habitDatabase.currentHabits[index];
        final today = DateTime.now();
        bool isDoneToday = habit.completedDays.any((date) =>
            date.year == today.year &&
            date.month == today.month &&
            date.day == today.day);

        return GestureDetector(
          onTap: () {
            // bool currentlyDone = isDoneToday;
            habitDatabase.updateHabitDate(habit.id, !isDoneToday);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: isDoneToday
                  ? Colors.green
                  : themeProvider.isDarkMode
                      ? Colors.black
                      : Colors.white,
            ),
            child: ListTile(
              title: Text(habit.name),
              leading: Checkbox(
                value: isDoneToday,
                activeColor: Colors.green,
                onChanged: (bool? value) {
                  habitDatabase.updateHabitDate(habit.id, value ?? false);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
