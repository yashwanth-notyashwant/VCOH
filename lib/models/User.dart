import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  String id;
  String phone;
  String name;
  String password;
  String piclink;
  String availableIn;
  String description;
  String age;
  String mail;

  User({
    required this.id,
    required this.phone,
    required this.password,
    required this.piclink,
    required this.availableIn,
    required this.description,
    required this.name,
    required this.age,
    required this.mail,
  });
}

class Users with ChangeNotifier {
  Future<void> addMethodForUser(User newUser) async {
    final url = Uri.parse(
        'https://vcoh-bd2f3-default-rtdb.firebaseio.com/USER_LIST_FOR_AUTH.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'phone': newUser.phone,
          'id': newUser.id,
          'password': newUser.password,
          'availableIn': newUser.availableIn,
          'description': newUser.description,
          'piclink': newUser.piclink,
          'name': newUser.name,
          'age': newUser.age,
          'mail': newUser.mail,
        }),
      );

      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  // Future<void> allUserMail() async {
  //   final url1 = Uri.parse(
  //       'https://vcoh-bd2f3-default-rtdb.firebaseio.com/USER_LIST_FOR_AUTH.json?orderBy="mail"');
  //   final response1 = await http.get(url1);
  //   print(response1.body);

  // }

  Future<List> allUserLoaderFromServer(
    String id,
    String password,
  ) async {
    final url = Uri.parse(
        'https://vcoh-bd2f3-default-rtdb.firebaseio.com/USER_LIST_FOR_AUTH.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      List forEmail = [];
      extractedData.forEach(
        (key, value) {
          forEmail.add(value['mail']);
        },
      );

      var listByServer = [];
      extractedData.forEach(
        (key, value) {
          listByServer.add(
            User(
              password: value['password'],
              id: value['id'],
              phone: value['phone'],
              availableIn: value['availableIn'],
              description: value['description'],
              piclink: value['piclink'],
              name: value['name'],
              age: value['age'],
              mail: value['mail'],
            ),
          );
        },
      );

      bool userFound = listByServer.any(
        (user) => user.id == id && user.password == password,
      );

      if (!userFound) {
        notifyListeners();
        return [listByServer.firstWhere((prod) => prod.id == id), forEmail];
      } else {
        notifyListeners();
        return [
          User(
              phone: '',
              id: '',
              password: '',
              availableIn: '',
              description: '',
              piclink: '',
              mail: '',
              age: '',
              name: ''),
          []
        ];
      }
    } catch (error) {
      return [
        User(
            phone: '',
            id: '',
            password: '',
            availableIn: '',
            description: '',
            piclink: '',
            mail: '',
            age: '',
            name: ''),
        []
      ];
    }
  }
}
