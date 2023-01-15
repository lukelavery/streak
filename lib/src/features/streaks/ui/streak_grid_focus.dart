import 'package:flutter/material.dart';
import 'package:streak/src/features/streaks/models/grid_tile_model.dart';

// TODO: move list generation to model. you are generating the same list twice !!!!

class StreakGridFocus extends StatelessWidget {
  const StreakGridFocus({Key? key, required this.tiles}) : super(key: key);

  final List<GridTileModel> tiles;

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).colorScheme.primary;
    
    return Card(
      elevation: 0,
      child: SizedBox(
        height: 250,
        child:
        ListView.builder(
          reverse: true,
          scrollDirection: Axis.horizontal,
          itemCount: 27,
          itemBuilder: (context, parentIndex) {
            if (parentIndex < 1) {
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: List.generate(
                    7,
                    (index) => Padding(
                      padding: const EdgeInsets.all(5),
                      child: SizedBox(
                        height: 18,
                        width: 18,
                        child: Center(
                          child: Text(
                            weekDays[index],
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Stack(
                alignment: AlignmentDirectional.topStart,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      parentIndex > 0 ? parentIndex < 26 ?  tiles[(181 - ((25 - parentIndex + 1) * 7 + 0))].dateTime.month !=  tiles[(181 - ((25 - parentIndex) * 7 + 0))].dateTime.month ? months[tiles[(181 - ((25 - parentIndex) * 7 + 0)) - 7].dateTime.month - 1] : '' : '' : '',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontFamily: 'Montserrat'
                        ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: List.generate(7, (index) {
                        final tile = tiles[
                            (181 - ((25 - parentIndex) * 7 + index)) - 7];
                        return Padding(
                            padding: const EdgeInsets.all(5),
                            child: Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      barrierColor: null,
                                      context: context,
                                      builder: (_) => SimpleDialog(
                                        title: Text(tile.dateTime.toString()),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: tile
                                              .future
                                          ? Theme.of(context)
                                              .colorScheme
                                              .surface
                                          : tile.streak
                                              ? color
                                              : color.withOpacity(0.1),
                                    ),
                                    height: 18,
                                    width: 18,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

List<String> weekDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
List<String> months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];
