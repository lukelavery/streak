import 'package:flutter/material.dart';
import 'package:streak/src/features/streaks/models/grid_tile_model.dart';

class StreakGrid extends StatelessWidget {
  const StreakGrid({Key? key, required this.tiles, required this.color})
      : super(key: key);

  final List<GridTileModel> tiles;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        26,
        (parentIndex) => Column(
          children: List.generate(
            7,
            (index) => Padding(
              padding: const EdgeInsets.all(1.5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: tiles[(181 - (parentIndex * 7 + index))].future
                      ? Theme.of(context).colorScheme.surface
                      : tiles[(181 - (parentIndex * 7 + index))].streak
                          ? color
                          : color.withOpacity(0.1),
                ),
                height: 8,
                width: 8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}