import 'package:flutter/material.dart';
import 'package:streak/src/features/streaks/models/grid_tile_model.dart';

class ActivityGrid extends StatelessWidget {
  const ActivityGrid({Key? key, required this.tiles}) : super(key: key);

  final List<GridTileModel> tiles;

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
                      ? Colors.white
                      : tiles[(181 - (parentIndex * 7 + index))].streak
                          ? Colors.pink
                          : Colors.pink.withOpacity(0.1),
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
