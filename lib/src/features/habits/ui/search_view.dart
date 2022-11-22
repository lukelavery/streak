import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/habits/controllers/habit_search_contoller.dart';

class SearchView extends ConsumerWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitSearchState = ref.watch(habitSearchControllerProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: TextField(onChanged: (value) {
          print(value);
          ref.read(habitSearchControllerProvider.notifier).query(value);
        }),
        backgroundColor: Colors.grey[50],
      ),
      body: habitSearchState.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: ((context, index) {
              // if (index == data.length && query != '') {
              //   return ListTile(
              //     title: Text('Create custom habit:' +
              //         query),
              //   );
              // }
              return ListTile(
                leading: Icon(IconData(data[index].iconCodePoint,
                  fontFamily: data[index].iconFontFamily,
                  fontPackage: data[index].iconFontPackage)),
                title: Text(data[index].name),
              );
            }),
          );
        },
        error: (error, st) {
          return Text(error.toString());
        },
        loading: () {
          return Text('loading');
        },
      ),
    );

    // habitSearchState.when(
    //   data: ((data) => ListView.builder(
    //     itemBuilder: (context, index) {
    //       return ListTile(
    //         title: Text(data[index].name),
    //       );
    //     },
    //   );
    //   error: Text('error'),
    //   loading: Text('loading'),
    // );
  }
}
