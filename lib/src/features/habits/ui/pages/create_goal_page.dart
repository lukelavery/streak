import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/core/constants.dart';
import 'package:streak/src/core/custom_exception.dart';
import 'package:streak/src/features/activities/models/habit_model.dart';
import 'package:streak/src/features/habits/controllers/create_habit_controller.dart';

class CreateGoalPage extends ConsumerWidget {
  const CreateGoalPage({Key? key, required this.habit}) : super(key: key);

  final ActivityModel habit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColor = ref.watch(createHabitControllerProvider);
    final createHabitStateNotifier =
        ref.read(createHabitControllerProvider.notifier);

    ref.listen<CustomException?>(
      customExceptionProvider,
      (prev, next) {
        if (next != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 2),
              backgroundColor: Colors.red[800],
              content: Text(
                next.message!,
              ),
            ),
          );
        }
      },
    );

    return Scaffold(
      backgroundColor: backgroundColour,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createHabitStateNotifier.handleButtonClick(habit, context);
        },
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColour,
        title: const Text(
          'Create Habit',
          style: TextStyle(color: Colors.black),
        ),
        leading: const Icon(
          Icons.close,
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(habit.name),
            const Text('Description'),
            TextField(
              onChanged: (value) =>
                  createHabitStateNotifier.setDescription(value),
            ),
            const Text('Color'),
            Expanded(
              child: GridView.builder(
                itemCount: colors.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5),
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      createHabitStateNotifier.setColor(index);
                    },
                    child: ColorCard(
                      color: colors[index],
                      selected: index == selectedColor ? true : false,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorCard extends StatelessWidget {
  const ColorCard({Key? key, required this.color, required this.selected})
      : super(key: key);

  final MaterialColor color;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0.5,
      child: Container(
        // margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: selected ? Border.all(color: color) : null,
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: color),
        ),
      ),
    );
  }
}
