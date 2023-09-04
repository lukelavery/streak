import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/activities/models/icons.dart';
import 'package:streak/src/features/habits/controllers/create_habit_controller.dart';
import 'package:streak/src/features/habits/ui/widgets/icon_card.dart';

class SelectIconPage extends ConsumerWidget {
  const SelectIconPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createHabitState = ref.watch(createHabitControllerProvider);
    final createHabitStateNotifier =
        ref.read(createHabitControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Icon'),
      ),
      body: GridView.builder(
        itemCount: iconListLarge.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
        itemBuilder: ((context, index) {
          return GestureDetector(
            onTap: () {
              createHabitStateNotifier.setIcon(index);
            },
            child: IconCard(
                icon: Icon(iconListLarge[index]),
                selected: index == createHabitState),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.done),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
