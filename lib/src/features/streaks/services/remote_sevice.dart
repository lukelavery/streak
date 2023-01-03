import 'dart:convert';

import 'package:http/http.dart';
import 'package:streak/src/features/streaks/models/streak_model.dart';

abstract class RemoteService {
  Future<List<StreakModel>> getStreaks();
}

class GitHubService implements RemoteService {
  @override
  Future<List<StreakModel>> getStreaks() async {
    List<StreakModel> streaks = [];
    Client client = Client();
    Uri url = Uri.parse('https://api.github.com/users/lukelavery/events');
    Response response = await client.get(url);

    if (response.statusCode == 200) {
      var body = response.body;
      var data = jsonDecode(body);

      for (var json in data) {
        StreakModel streak = StreakModel.fromJSON(json, 'test');
        streaks.add(streak);
      }
    }

    return streaks;
  }
}
