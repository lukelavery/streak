import 'package:streak/src/features/activities/models/activity_model.dart';

class SearchModel {
  final List<ActivityModel> activities;
  final int category;

  const SearchModel({required this.activities, required this.category});
}
