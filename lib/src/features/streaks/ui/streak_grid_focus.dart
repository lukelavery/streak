import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/streaks/controllers/grid_controller.dart';
import 'package:streak/src/features/streaks/models/grid_tile_model.dart';

// class StreakGridFocus extends StatelessWidget {
//   const StreakGridFocus({Key? key, required this.tiles}) : super(key: key);

//   final List<GridTileModel> tiles;

//   @override
//   Widget build(BuildContext context) {
//     final Color color = Theme.of(context).colorScheme.primary;

//     return Card(
//       elevation: 0,
//       child: SizedBox(
//         height: 240,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ListView.builder(
//             reverse: true,
//             scrollDirection: Axis.horizontal,
//             itemCount: 27,
//             itemBuilder: (context, parentIndex) {
//               if (parentIndex < 1) {
//                 return Padding(
//                   padding: const EdgeInsets.only(top: 20),
//                   child: Column(
//                     children: List.generate(
//                       7,
//                       (index) => Padding(
//                         padding: const EdgeInsets.all(5),
//                         child: SizedBox(
//                           height: 18,
//                           width: 18,
//                           child: Center(
//                             child: Text(
//                               weekDays[index],
//                               style: const TextStyle(
//                                   // fontFamily: 'Montserrat',
//                                   ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               } else {
//                 return Stack(
//                   alignment: AlignmentDirectional.topStart,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 3),
//                       child: Text(
//                         parentIndex > 0
//                             ? parentIndex < 26
//                                 ? tiles[(181 -
//                                                 ((25 - parentIndex + 1) * 7 +
//                                                     0))]
//                                             .dateTime
//                                             .month !=
//                                         tiles[(181 -
//                                                 ((25 - parentIndex) * 7 + 0))]
//                                             .dateTime
//                                             .month
//                                     ? months[tiles[(181 -
//                                                     ((25 - parentIndex) * 7 +
//                                                         0)) -
//                                                 7]
//                                             .dateTime
//                                             .month -
//                                         1]
//                                     : ''
//                                 : ''
//                             : '',
//                         style: TextStyle(
//                           color: Theme.of(context).colorScheme.onSurface,
//                           // fontFamily: 'Montserrat',
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 20),
//                       child: Column(
//                         children: List.generate(
//                           7,
//                           (index) {
//                             final tile = tiles[
//                                 (181 - ((25 - parentIndex) * 7 + index)) - 7];
//                             return Padding(
//                               padding: const EdgeInsets.all(5),
//                               child: Stack(
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () {
//                                       showDialog(
//                                         barrierColor: null,
//                                         context: context,
//                                         builder: (_) => SimpleDialog(
//                                           title: Text(tile.dateTime.toString()),
//                                         ),
//                                       );
//                                     },
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(4),
//                                         color: tile.future
//                                             ? Theme.of(context)
//                                                 .colorScheme
//                                                 .surface
//                                             : tile.streak
//                                                 ? color
//                                                 : color.withOpacity(0.15),
//                                       ),
//                                       height: 18,
//                                       width: 18,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class NewStreakGridFocus extends ConsumerWidget {
//   const NewStreakGridFocus({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(newGridControllerProvider);
//     return state.when(
//       data: (data) {
//         var cols = data.gridModels.values.toList()[0].gridTiles;
//         return Column(
//           children: [
//             SizedBox(
//               height: 250,
//               width: double.infinity,
//               child: ListView.builder(
//                 reverse: true,
//                 scrollDirection: Axis.horizontal,
//                 itemCount: cols.length,
//                 itemBuilder: (context, parentIndex) {
//                   var rows = cols[parentIndex];

//                   return Column(
//                     children: List.generate(rows.length, (index) {
//                       var gridTileModel = rows[index];
//                       return Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: GridTile(gridTileModel: gridTileModel),
//                       );
//                     }),
//                   );
//                 },
//               ),
//             ),
//           ],
//         );
//       },
//       error: (error, stackTrace) => Text(error.toString()),
//       loading: () => const Text('loading'),
//     );
//   }
// }

// class NewStreakGridFocus extends ConsumerWidget {
//   const NewStreakGridFocus({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(newGridControllerProvider);
//     return state.when(
//       data: (data) {
//         var cols = data.gridModels.values.toList()[0].gridTiles;
//         return SizedBox(
//           height: 250,
//           width: double.infinity,
//           child: ListView.builder(
//             reverse: true,
//             scrollDirection: Axis.horizontal,
//             itemCount: cols.length,
//             itemBuilder: (context, parentIndex) {
//               var rows = cols[parentIndex];

//               return Column(
//                 children: List.generate(rows.length, (index) {
//                   var gridTileModel = rows[index];
//                   return Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: GridTile(gridTileModel: gridTileModel),
//                   );
//                 }),
//               );
//             },
//           ),
//         );
//       },
//       error: (error, stackTrace) => Text(error.toString()),
//       loading: () => const Text('loading'),
//     );
//   }
// }

class NewStreakGridFocus extends ConsumerWidget {
  const NewStreakGridFocus({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(newerGridControllerProvider);
    return state.when(
      data: (data) {
        // var cols = data.gridModels.values.toList()[0].gridTiles;
        return Center(child: GridView(gridModel: data));
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
