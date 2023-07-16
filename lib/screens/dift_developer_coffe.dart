import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class GiftDeveloperCoffe extends StatefulWidget {
  @override
  State<GiftDeveloperCoffe> createState() => _GiftDeveloperCoffeState();
}

class _GiftDeveloperCoffeState extends State<GiftDeveloperCoffe> {
  @override
  Widget build(BuildContext context) {
    Widget al = Icon(
      Icons.coffee,
      size: 45,
      color: Colors.white,
    );
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('  '),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Container(
                height: 250,
                width: 250,
                child: Image.network(
                  'https://i.giphy.com/media/g7GKcSzwQfugw/200.gif',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 30),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 74, 74, 74),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Container(
                  width: 300,
                  child: Row(
                    children: [
                      Container(
                        height: 38,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 5),
                          child: Hero(tag: 'alp', child: al),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        'Go GIFT >>',
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                onPressed: () async {
                  var upid = 'iammruniquely@okaxis';
                  var name = 'YashwanthR';
                  var note = 'Noiceee !';
                  String url =
                      'upi://pay?pa=$upid&pn=$name&am=100000&cu=INR&tn=$note';
                  // var status = await Permission.storage.request();

                  await launch(url);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
