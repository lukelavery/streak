import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:streak/grid_view.dart';
import 'package:streak/providers/providers.dart';
import 'package:streak/user_profile_page.dart';

import 'search_delegate.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final edit = ref.watch(editStateProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[50],
        actions: [
          IconButton(
              onPressed: () {
                ref.read(editStateProvider.notifier).update((state) => !state);
              },
              icon: Icon(
                Icons.edit,
                color: Colors.grey,
              )),
          IconButton(
            color: Colors.grey,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserProfilePage()));
            },
            icon: Icon(Icons.account_circle),
          )
        ],
        title: Stack(
          alignment: Alignment.centerLeft,
          clipBehavior: Clip.none,
          // alignment: Alignment.centerLeft,
          children: const [
            Positioned(
                left: 23,
                child: Text(
                  'streak',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                  ),
                )),
            FaIcon(
              FontAwesomeIcons.bolt,
              color: Colors.black,
              size: 22,
            ),
          ],
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) => MyGridView(
          counters: ref.watch(streakProvider).counters,
          habits: ref.watch(habitPovider).habits,
          crossAxisCount: ref.watch(habitPovider).getCrossAxisCount(),
          increment: ref.read(habitPovider).addStreak,
          streaks: ref.watch(streakProvider).streaks,
        ),
      ),
      // child: MyCircularProgressIndicator()),
      floatingActionButton: Consumer(
        builder: (context, ref, child) => FloatingActionButton(
          onPressed: () {
            showSearch(
              context: context,
              delegate: CustomSearchDelegate(
                  addHabit: ref.read(habitPovider).addHabit),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
        BottomNavigationBarItem(icon: Icon(Icons.timeline), label: 'streaks')
      ]),
    );
  }
}


        //   child: Consumer(
        // builder: ((context, value, child) => HabitCard(
        //       icon: Icons.computer,
        //       name: 'Code',
        //       counter: value.watch(habitPovider).count,
        //       increment: value.read(habitPovider).incrementCount,
        //     )),

// class MyCircularProgressIndicator extends StatefulWidget {
//   const MyCircularProgressIndicator({Key? key}) : super(key: key);

//   @override
//   State<MyCircularProgressIndicator> createState() =>
//       _MyCircularProgressIndicatorState();
// }

// class _MyCircularProgressIndicatorState
//     extends State<MyCircularProgressIndicator> with TickerProviderStateMixin {
//   late AnimationController controller;

//   @override
//   void initState() {
//     controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     )..addListener(() {
//         setState(() {});
//       });
//     super.initState();
//   }

//   void startAnimation() {
//     controller.forward();
//   }

//   void cancelAnimation() {
//     controller.reset();
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         GestureDetector(
//           behavior: HitTestBehavior.translucent,
//           child: Consumer<HabitProvider>(
//               builder: ((context, value, child) => HabitCard(
//                     icon: Icons.computer,
//                     name: 'Code',
//                     counter: value.count,
//                   )),
//             ),
          
//           onTapDown: (_) {
//             startAnimation();
//             print('start');
//           },
//           onTapUp: (_) => cancelAnimation(),
//           onTapCancel: () => cancelAnimation(),
//         ),
//         SizedBox(
//           height: 60,
//           width: 60,
//           child: CircularProgressIndicator(
//             value: controller.value,
//             color: Colors.pink,
//             strokeWidth: 6.0,
//           ),
//         ),
//       ],
//     );
//   }
// }
