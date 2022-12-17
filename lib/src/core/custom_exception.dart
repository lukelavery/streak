import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomException implements Exception {
  final String? message;

  const CustomException({this.message = 'Something went wrong!'});

  @override
  String toString() => 'CustomException { message: $message }';
}

final customExceptionProvider = StateProvider<CustomException?>((ref) {
  return null;
});