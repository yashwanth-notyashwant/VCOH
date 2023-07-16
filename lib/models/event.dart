import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:vcoh/models/User.dart';

class Event {
  String id;
  String creatorName;
  String creatorDesignation;
  String placeName;
  String piclink;
  String description;
  String cord1;

  String date;

  Event({
    required this.id,
    required this.creatorName,
    required this.creatorDesignation,
    required this.placeName,
    required this.description,
    required this.cord1,
    required this.date,
    required this.piclink,
  });
}

class Events with ChangeNotifier {
  //

  //

  Future<void> addMethodForUser(Event newEvent) async {
    final url = Uri.parse(
        'https://vcoh-bd2f3-default-rtdb.firebaseio.com/USER_LIST_FOR_EVENTS.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'id': newEvent.id,
          'creatorName': newEvent.creatorName,
          'creatorDesignation': newEvent.creatorDesignation,
          'placeName': newEvent.placeName,
          'description': newEvent.description,
          'cord1': newEvent.cord1,
          'date': newEvent.date,
          'piclink': newEvent.piclink,
        }),
      );

      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<List<Event>> allEventsFromServer() async {
    final url = Uri.parse(
        'https://vcoh-bd2f3-default-rtdb.firebaseio.com/USER_LIST_FOR_EVENTS.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      List<Event> listByServer = [];
      extractedData.forEach(
        (key, value) {
          if (DateTime.parse(value['date']).isAfter(DateTime.now()))
            listByServer.add(
              Event(
                id: value['id'],
                creatorName: value['creatorName'],
                creatorDesignation: value['creatorDesignation'],
                placeName: value['placeName'],
                description: value['description'],
                cord1: value['cord1'],
                date: value['date'],
                piclink: value['piclink'],
              ),
            );
        },
      );

      if (listByServer.isNotEmpty) {
        notifyListeners();
        return listByServer;
      } else {
        notifyListeners();
        return [];
      }
    } catch (error) {
      return [];
    }
  }
}
