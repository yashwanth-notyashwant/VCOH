import 'package:flutter/material.dart';
import 'package:vcoh/models/User.dart';
import 'package:vcoh/models/event.dart';

import 'package:vcoh/screens/auth_page.dart';
import 'package:provider/provider.dart';
import 'package:vcoh/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'Flutter Demo',
      // home: MyHomePage(),
      home: Splash(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Users(),
        ),
        ChangeNotifierProvider.value(
          value: Events(),
        ),
      ],
      child: MaterialApp(
        // home: HodView(),
        home: AuthPage(),
      ),
    );
  }
}
