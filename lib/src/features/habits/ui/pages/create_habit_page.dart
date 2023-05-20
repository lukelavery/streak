import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/core/custom_exception.dart';
import 'package:streak/src/features/activities/models/activity_model.dart';
import 'package:streak/src/features/activities/models/icons.dart';
import 'package:streak/src/features/habits/controllers/create_habit_controller.dart';
import 'package:streak/src/features/habits/controllers/habit_controller.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';
import 'package:streak/src/features/habits/ui/widgets/custom_text_card.dart';
import 'package:streak/src/features/habits/ui/widgets/icon_card.dart';

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
    final colorScheme = Theme.of(context).colorScheme;

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

    ref.listen<AsyncValue<List<HabitModel>>>(
      habitControllerProvider,
      (prev, next) {
        if (next.value != prev?.value) {
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      },
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.done),
        onPressed: () async {
          createHabitStateNotifier.handleButtonClick(
              activity: activity, context: context);
        },
      ),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Create Habit',
          style: TextStyle(color: colorScheme.onSurface),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.close,
          ),
          color: colorScheme.onSurface,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              CustomTextCard(
                maxLength: null,
                onChanged: createHabitStateNotifier.setDescription,
                title: 'Activity',
                initialValue: name,
                activity: activity,
              ),
              const SizedBox(height: 30),
              CustomTextCard(
                maxLength: 30,
                onChanged: createHabitStateNotifier.setDescription,
                title: 'Description',
              ),
              const SizedBox(
                height: 30,
              ),
              const Text('Icon'),
              activity == null
                  ? IconSelector(
                      setIcon: createHabitStateNotifier.setIcon,
                      createHabitState: createHabitState)
                  : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  SmallButton(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class IconSelector extends StatelessWidget {
  const IconSelector(
      {super.key, required this.setIcon, required this.createHabitState});

  final void Function(int) setIcon;
  final int? createHabitState;

  @override
  Widget build(BuildContext context) {
    return 
    // Expanded(
    //   child: 
      SizedBox(
        height: 150,
        child: GridView.builder(
          itemCount: icons.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () {
                setIcon(index);
              },
              child: IconCard(
                  icon: Icon(icons[index]), selected: index == createHabitState),
            );
          }),
        ),
      );
    // );
  }
}

class SmallButton extends StatelessWidget {
  const SmallButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 100,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: colorScheme.primary.withOpacity(0.7)
      ),
      child: Center(child: Text('More icons', style: TextStyle(color: colorScheme.onInverseSurface, fontWeight: FontWeight.w500),)),
    );
  }
}
