import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/user/controllers/select_color_controller.dart';
import 'package:streak/src/features/user/controllers/theme_controller.dart';

class SelectColorView extends ConsumerWidget {
  const SelectColorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColor = ref.watch(selectColorController);
    final selectedColorNotifier = ref.read(selectColorController.notifier);
    final themeStateNotifier = ref.read(themeController.notifier);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: selectedColor != null ? selectedColorNotifier.colorList[selectedColor] : null,
        child: const Icon(Icons.done),
        onPressed: () {
          if (selectedColor != null) {
            themeStateNotifier.setColor(selectedColorNotifier.colorList[selectedColor]);
            Navigator.pop(context);
          }
        },
      ),
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Select Color',
        ),
        leading: const Icon(Icons.close),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: selectedColorNotifier.colorList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5),
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      selectedColorNotifier.setColor(index);
                    },
                    child: ColorCard(
                      color: selectedColorNotifier.colorList[index],
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
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          // color: Colors.white,
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
