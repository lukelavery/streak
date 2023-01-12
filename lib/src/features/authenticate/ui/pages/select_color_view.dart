// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class SelectColorView extends ConsumerWidget {
//   const SelectColorView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {

//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
          
//         },
//       ),
//       appBar: AppBar(
//         elevation: 0,
//         title: const Text(
//           'Select Color',
//         ),
//         leading: const Icon(
//           Icons.close
//         ),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: GridView.builder(
//                 itemCount: colors.length,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 5),
//                 itemBuilder: ((context, index) {
//                   return GestureDetector(
//                     onTap: () {

//                     },
//                     child: ColorCard(
//                       color: colors[index],
//                       // selected: index == selectedColor ? true : false,
//                       selected: false,
//                     ),
//                   );
//                 }),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ColorCard extends StatelessWidget {
//   const ColorCard({Key? key, required this.color, required this.selected})
//       : super(key: key);

//   final MaterialColor color;
//   final bool selected;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       elevation: 0.5,
//       child: Container(
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           border: selected ? Border.all(color: color) : null,
//         ),
//         child: Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20), color: color),
//         ),
//       ),
//     );
//   }
// }
