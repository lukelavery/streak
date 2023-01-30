import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class GraphQLView extends StatelessWidget {
  GraphQLView({super.key});

  final GitHubService service = GitHubService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
              onPressed: () {
                service.fetchData();
              },
              child: const Text('request'))),
    );
  }
}

// void fetchData() async {
//   AuthLink authLink = AuthLink(
//     getToken: () => 'bearer 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',
//   );
//   HttpLink httpLink = HttpLink("https://api.github.com/graphql");
//   Link link = authLink.concat(httpLink);
//   GraphQLClient qlClient = GraphQLClient(
//     link: link,
//     cache: GraphQLCache(
//       store: HiveStore(),
//     ),
//   );
//   QueryResult queryResult = await qlClient.query(
//     QueryOptions(
//       document: gql(queryString),
//     ),
//   );
//   print(queryResult);
// }

const String queryString = r"""
query {
  user(login: "lukelavery") {
    email
    createdAt
    contributionsCollection {
      contributionCalendar {
        totalContributions
        weeks {
          contributionDays {
            weekday
            date
            contributionCount
            color
          }
        }
        months  {
          name
            year
            firstDay
          totalWeeks

        }
      }
    }
  }
}
""";

class GitHubService {
  final String activityId = 'ComsAFbAvnG2d3SUU8S5';

  Future<void> fetchData() async {
    Client client = Client();
    Uri url = Uri.parse('https://api.github.com/graphql');
    Response response =
        await client.post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      var body = response.body;
      var data = jsonDecode(body);

      List weeks = data['data']['user']['contributionsCollection']
          ['contributionCalendar']['weeks'];
      for (var week in weeks) {
        var contributionDays = week['contributionDays'];
        addWeek(
            dateTime: dateFormat.parse(contributionDays[0]['date']),
            days: contributionDays);
      }
    }
  }

  Future<void> addWeek({required DateTime dateTime, required List days}) async {
    Map<String, dynamic> data = {};

    // data['uid'] = uid;
    data['activityId'] = activityId;
    data['timestamp'] = Timestamp.fromDate(dateTime);
    data['days'] = days;

    await streaksRef.add(data);
  }

  CollectionReference streaksRef = FirebaseFirestore.instance
      .collection('habits_new')
      .doc('ComsAFbAvnG2d3SUU8S5')
      .collection('weeks');
}

const headers = {
  'Authorization': 'bearer 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',
};

const body = {
  'query': queryString,
};

DateFormat dateFormat = DateFormat('yyyy-MM-dd');
