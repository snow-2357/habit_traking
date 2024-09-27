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

        // Define the function to check if the habit is done today
        bool isDoneToday() {
          final today = DateTime.now();
          return habit.completedDays.any((date) =>
              date.year == today.year &&
              date.month == today.month &&
              date.day == today.day);
        }

        return ListTile(
          title: Text(
            habit.name,
            style: TextStyle(
              color: isDoneToday()
                  ? Colors.green
                  : themeProvider.isDarkMode
                      ? Colors.white
                      : Colors.black,
            ),
          ),
        );
      },
    );
  }
}
