import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/core/custom_exception.dart';
import 'package:streak/src/features/activities/models/activity_model.dart';
import 'package:streak/src/features/activities/models/icons.dart';
import 'package:streak/src/features/habits/controllers/create_habit_controller.dart';

class CreateHabitPage extends ConsumerWidget {
  const CreateHabitPage({Key? key, this.activity, required this.name})
      : super(key: key);

  final ActivityModel? activity;
  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createHabitStateNotifier =
        ref.read(createHabitControllerProvider.notifier);
    final createHabitState = ref.watch(createHabitControllerProvider);

    createHabitStateNotifier.setName(name);

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createHabitStateNotifier.handleButtonClick(
              activity: activity, context: context);
        },
      ),
      appBar: AppBar(
        elevation: 0,
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
            activity == null
                ? Text(name)
                : Row(
                    children: [
                      Icon(IconData(activity!.iconCodePoint,
                          fontFamily: activity?.iconFontFamily,
                          fontPackage: activity?.iconFontPackage)),
                      Text(name)
                    ],
                  ),
            const Text('Description'),
            TextField(
              onChanged: (value) =>
                  createHabitStateNotifier.setDescription(value),
            ),
            activity == null
                ? Expanded(
                    child: GridView.builder(
                      itemCount: icons.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5),
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {
                            createHabitStateNotifier.setIcon(index);
                          },
                          child: IconCard(
                              icon: Icon(icons[index]),
                              selected: index == createHabitState),
                        );
                      }),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class IconCard extends StatelessWidget {
  const IconCard({Key? key, required this.icon, required this.selected})
      : super(key: key);

  final Icon icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0.5,
      child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: selected
                ? Border.all(color: Theme.of(context).colorScheme.primary)
                : null,
          ),
          child: icon),
    );
  }
}
