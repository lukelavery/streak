import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/core/custom_exception.dart';
import 'package:streak/src/features/activities/models/activity_model.dart';
import 'package:streak/src/features/activities/models/icons.dart';
import 'package:streak/src/features/habits/controllers/create_habit_controller.dart';
import 'package:streak/src/features/habits/controllers/habit_controller.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';

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
            children: [
              // activity == null
              //     ? Text(name)
              //     : Row(
              //         children: [
              //           Icon(
              //             IconData(
              //               activity!.iconCodePoint,
              //               fontFamily: activity?.iconFontFamily,
              //               fontPackage: activity?.iconFontPackage,
              //             ),
              //             size: 40,
              //           ),
              //           SizedBox(width: 8,),
              //           Text(
              //             name,
              //             style: TextStyle(
              //               fontSize: 20
              //             ),
              //           )
              //         ],
              //       ),
              // Container(
              //   decoration: BoxDecoration(
              //       color: colorScheme.surface,
              //       borderRadius: BorderRadius.circular(10)),
              //   child: Padding(
              //     padding:
              //         const EdgeInsets.only(left: 10.0, right: 10, bottom: 0),
              //     child: TextField(
              //       maxLength: 30,
              //       decoration: InputDecoration(border: InputBorder.none),
              //       onChanged: (value) =>
              //           createHabitStateNotifier.setDescription(value),
              //     ),
              //   ),
              // ),
              CustomTextCard(
                maxLength: null,
                onChanged: createHabitStateNotifier.setDescription,
                title: 'Activity',
                initialValue: name,
              ),
              CustomTextCard(
                maxLength: 30,
                onChanged: createHabitStateNotifier.setDescription,
                title: 'Description',
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

class CustomTextCard extends StatelessWidget {
  const CustomTextCard({
      super.key,
      required this.maxLength,
      required this.onChanged,
      required this.title,
      this.initialValue
    });

  final int? maxLength;
  final void Function(String) onChanged;
  final String title;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Container(
          decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 0),
            child: initialValue == null ? CustomTextField(maxLength: maxLength, onChanged: onChanged) : CustomTextFormField(maxLength: maxLength, onChanged: onChanged, initialValue: initialValue!)
          ),
        ),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.maxLength,
    required this.onChanged,
  });

  final int? maxLength;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: maxLength,
      decoration: const InputDecoration(border: InputBorder.none),
      onChanged: (value) => onChanged(value),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.maxLength,
    required this.onChanged,
    required this.initialValue
  });

  final int? maxLength;
  final void Function(String) onChanged;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      enabled: false,
      maxLength: maxLength,
      decoration: const InputDecoration(border: InputBorder.none),
      onChanged: (value) => onChanged(value),
    );
  }
}