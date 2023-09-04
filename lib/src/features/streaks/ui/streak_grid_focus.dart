import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';
import 'package:streak/src/features/streaks/controllers/grid_map_controller.dart';
import 'package:streak/src/features/streaks/models/grid_tile_model.dart';

class NewStreakGridFocus extends ConsumerWidget {
  const NewStreakGridFocus({super.key, required this.habit});

  final HabitModel habit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gridMapControllerProvider);
    return state.when(
      data: (data) {
        return Center(
            child: GridView(gridModel: data.gridMap[habit.activity.id]!));
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const Text('loading'),
    );
  }
}

class GridTile extends StatelessWidget {
  const GridTile(
      {super.key,
      required this.gridTileModel,
      required this.padding,
      required this.tileLength});

  final GridTileModel gridTileModel;
  final double padding;
  final double tileLength;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Tooltip(
      verticalOffset: tileLength / 2 + 5,
      preferBelow: false,
      triggerMode: TooltipTriggerMode.tap,
      message: gridTileModel.formattedDate,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: padding),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: gridTileModel.future
                ? Theme.of(context).colorScheme.surface
                : gridTileModel.streak
                    ? color
                    : color.withOpacity(0.1),
          ),
          height: tileLength,
          width: tileLength,
        ),
      ),
    );
  }
}

class GridWeek extends StatelessWidget {
  const GridWeek(
      {super.key,
      required this.gridWeek,
      required this.tilePadding,
      required this.tileLength});

  final GridWeekModel gridWeek;
  final double tilePadding;
  final double tileLength;

  @override
  Widget build(BuildContext context) {
    final List<GridTileModel> days = gridWeek.days;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: tilePadding),
      child: Column(
        children: List.generate(
          days.length,
          (index) => GridTile(
            gridTileModel: days[index],
            padding: tilePadding,
            tileLength: tileLength,
          ),
        ),
      ),
    );
  }
}

class GridMonth extends StatelessWidget {
  const GridMonth({
    super.key,
    required this.gridMonth,
    required this.topPadding,
    required this.tilePading,
    required this.tileLength,
  });

  final GridMonthModel gridMonth;
  final double topPadding;
  final double tilePading;
  final double tileLength;

  @override
  Widget build(BuildContext context) {
    final weeks = gridMonth.weeks;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: topPadding,
          child: Text(
            monthStringList[gridMonth.dateTime.month - 1],
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 15),
          ),
        ),
        Row(
          children: List.generate(
            weeks.length,
            (index) => GridWeek(
              gridWeek: weeks[index],
              tilePadding: tilePading,
              tileLength: tileLength,
            ),
          ),
        )
      ],
    );
  }
}

class GridView extends StatelessWidget {
  const GridView({super.key, required this.gridModel});

  final NewerGridModel gridModel;
  final double topPadding = 20;
  final double tileLength = 20;
  final double tilePadding = 5;

  @override
  Widget build(BuildContext context) {
    final gridMonths = gridModel.gridMonths;

    return Card(
      elevation: 0,
      // surfaceTintColor: surfaceColor,
      child: SizedBox(
        height: 250,
        child: ListView.builder(
            reverse: true,
            scrollDirection: Axis.horizontal,
            itemCount: gridMonths.length + 1,
            itemBuilder: (context, index) {
              if (index < 1) {
                return Padding(
                  padding: EdgeInsets.only(top: topPadding),
                  child: Column(
                    children: List.generate(
                      7,
                      (index) => Padding(
                        padding: EdgeInsets.all(tilePadding),
                        child: SizedBox(
                          height: tileLength,
                          child: Text(weekDays[index]),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return GridMonth(
                  gridMonth: gridMonths[index - 1],
                  topPadding: topPadding,
                  tilePading: tilePadding,
                  tileLength: tileLength,
                );
              }
            }),
      ),
    );
  }
}
