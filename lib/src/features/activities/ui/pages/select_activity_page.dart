// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:streak/src/features/activities/controllers/activity_type_controller.dart';
// import 'package:streak/src/features/activities/ui/pages/search_view.dart';

// const TextStyle h1 = TextStyle(
//     fontSize: 30, fontFamily: 'Montserrat', fontWeight: FontWeight.w500);
// const TextStyle sh1 = TextStyle(
//     fontSize: 15, fontFamily: 'Montserrat', fontWeight: FontWeight.w400);
// const TextStyle cardTitle = TextStyle(
//     color: Colors.white,
//     fontSize: 22,
//     fontFamily: 'Montserrat',
//     fontWeight: FontWeight.w400);
// const TextStyle cardSubtitle = TextStyle(
//     color: Color(0xFFE0E0E0),
//     fontFamily: 'Montserrat',
//     fontWeight: FontWeight.w400);

// class SelectActivityPage extends ConsumerWidget {
//   const SelectActivityPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       body: SafeArea(
//         child: ListView(
//           children: [
//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: const Icon(Icons.close)),
//                 ),
//               ],
//             ),
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Text(
//                     'Choose a goal',
//                     style: h1,
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     'Calendar will choose the best times to schedule sessions for your goal.',
//                     style: sh1,
//                   )
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Padding(
//                     padding: EdgeInsets.only(bottom: 8.0),
//                     child: GoalCard(
//                       title: 'Exercise',
//                       subtitle: 'Run, do yoga, get your body moving',
//                       habitType: 'exercise',
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(bottom: 8.0),
//                     child: GoalCard(
//                       title: 'Build a skill',
//                       subtitle: 'Learn a language, practise an instrument',
//                       habitType: 'skill',
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(bottom: 8.0),
//                     child: GoalCard(
//                       title: 'Organise my life',
//                       subtitle: 'Stay on tope of things',
//                       habitType: 'organise',
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(bottom: 8.0),
//                     child: GoalCard(
//                       title: 'Me time',
//                       subtitle: 'Read, meditate, take care of yourself',
//                       habitType: 'me',
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(bottom: 8.0),
//                     child: GoalCard(
//                       title: 'Family & friends',
//                       subtitle: 'Make time for the people who matter most',
//                       habitType: 'friends',
//                     ),
//                   ),
//                   SizedBox(
//                     height: 100,
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// // class GoalCard extends StatelessWidget {
// //   const GoalCard(
// //       {Key? key,
// //       required this.title,
// //       required this.subtitle,
// //       required this.searchDelegate})
// //       : super(key: key);

// //   final String title;
// //   final String subtitle;
// //   final SearchDelegate searchDelegate;

// //   @override
// //   Widget build(BuildContext context) {
// //     double width = MediaQuery.of(context).size.width;
// //     return GestureDetector(
// //       onTap: () => showSearch(context: context, delegate: searchDelegate),
// //       child: Stack(
// //         alignment: AlignmentDirectional.bottomStart,
// //         children: [
// //           Container(
// //             width: width,
// //             height: 175,
// //             color: Colors.grey,
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   title,
// //                   style: cardTitle,
// //                 ),
// //                 Text(
// //                   subtitle,
// //                   style: cardSubtitle,
// //                 ),
// //               ],
// //             ),
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }

// class GoalCard extends ConsumerWidget {
//   const GoalCard({
//     Key? key,
//     required this.title,
//     required this.subtitle,
//     required this.habitType,
//   }) : super(key: key);

//   final String title;
//   final String subtitle;
//   final String habitType;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     double width = MediaQuery.of(context).size.width;
//     return GestureDetector(
//       onTap: () {
//         ref.read(activityTypeController.notifier).update((state) => 0);
//         Navigator.push(context, MaterialPageRoute(builder: (context) {
//           return const SearchView();
//         }));
//       },
//       child: Stack(
//         alignment: AlignmentDirectional.bottomStart,
//         children: [
//           Container(
//             width: width,
//             height: 175,
//             color: Colors.grey,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: cardTitle,
//                 ),
//                 Text(
//                   subtitle,
//                   style: cardSubtitle,
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
