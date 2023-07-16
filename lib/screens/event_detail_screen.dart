import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:vcoh/models/event.dart';

class EventDetailScreen extends StatefulWidget {
  final Event loadedEvent;
  var index;

  EventDetailScreen(this.loadedEvent, this.index);

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var a = widget.index;
    var deviceWidth = MediaQuery.of(context).size.width;
    var devicelength = MediaQuery.of(context).size.height;

    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(' '),
          elevation: 0,
          actions: <Widget>[
            IconButton(
              tooltip: 'Back to main page',
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            // TopRectangleBox(deviceWidth, widget.loadedEvent.creatorName,
            //     widget.loadedEvent.date, widget.loadedEvent.piclink),

            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Hero(
                    transitionOnUserGestures: true,
                    tag: 'myheroanimation$a',
                    child: Image.network(
                      widget.loadedEvent.piclink,
                      width: 150.0,
                      height: 150,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.loadedEvent.creatorName.toString(),
                    style: TextStyle(fontSize: 23, color: Colors.white),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(widget.loadedEvent.date,
                      style: TextStyle(
                        color: Color.fromARGB(255, 140, 146, 161),
                      )),
                ],
              ),
              height: 280,
              width: deviceWidth,
              padding: EdgeInsets.all(10),
              // color: Color.fromARGB(255, 94, 98, 107), //photo background COLOR
            ),

            sbox(15),
            const Text(
              'Details : ',
              style: TextStyle(fontSize: 25),
            ),
            sbox(5),
            const Divider(
              thickness: 3,
              indent: 20,
              endIndent: 20,
            ),
            sbox(15),
            ListTile(
              title: Text(
                'Name',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(widget.loadedEvent.creatorName),
            ),
            Divider(indent: 30, endIndent: 30),
            sbox(15),
            ListTile(
              title: Text(
                'Creator Designation  ',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(widget.loadedEvent.creatorDesignation),
            ),
            Divider(indent: 30, endIndent: 30),
            sbox(15),
            ListTile(
              title: Text(
                'Place name  ',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(widget.loadedEvent.placeName),
            ),
            Divider(indent: 30, endIndent: 30),
            sbox(15),
            ListTile(
              title: Text(
                'Address   ',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(widget.loadedEvent.cord1),
            ),
            Divider(indent: 30, endIndent: 30),
            sbox(15),
            Container(
              height: 20,
              width: deviceWidth - 20,
              child: Text(
                '    Description',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            sbox(15),
            SingleChildScrollView(
              child: Container(
                width: deviceWidth - 60,
                height: devicelength - 700,
                child: Text(widget.loadedEvent.description),
              ),
            ),

            Container(
              height: 50,
              width: deviceWidth - 50,
              child: TextButton(
                onPressed: () async {
                  //
                  var abcd = widget.loadedEvent.cord1;

                  final String url = 'http://maps.google.com/?q= $abcd';

                  var umb = await launch(url);
                  // } else {
                  //   // show a message dialog box if the URL is not launchable
                  //   showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) => AlertDialog(
                  //       title: Text('Error'),
                  //       content: Text('Could not launch $url'),
                  //       actions: <Widget>[
                  //         TextButton(
                  //           child: Text('OK'),
                  //           onPressed: () => Navigator.pop(context),
                  //         ),
                  //       ],
                  //     ),
                  //   );
                  // }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                child: Text(
                  'GET directions ',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            sbox(40),
          ]),
        ),
      ),
    );
  }
}

Widget sbox(double? size) {
  return SizedBox(
    height: size,
  );
}
