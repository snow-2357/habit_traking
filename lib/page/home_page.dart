import 'package:flutter/material.dart';
import 'package:habit_tracking/components/drawer.dart';
import 'package:habit_tracking/components/habit_list.dart';
import 'package:habit_tracking/database/habit_database.dart';
import 'package:habit_tracking/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<HabitDatabase>(context, listen: false).readHabits();
  }

  void createHabit(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
          decoration: InputDecoration(
            hintText: 'Enter habit name',
            hintStyle:
                TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
          MaterialButton(
            onPressed: () {
              // Save the new habit
              String newHabit = textController.text;
              context.read<HabitDatabase>().addHabit(newHabit);

              Navigator.of(context).pop();
              textController.clear();
            },
            child: Text(
              'Save',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      drawer: const CustomDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createHabit(context),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: const Icon(Icons.add),
      ),
      body: Consumer<HabitDatabase>(
        builder: (context, habitDatabase, child) {
          return const HabitList();
        },
      ),
    );
  }
}
