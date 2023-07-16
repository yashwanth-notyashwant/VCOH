import 'package:flutter/material.dart';

import 'package:vcoh/models/User.dart';

class UserDetailScreen extends StatefulWidget {
  final User loadedUser;

  UserDetailScreen(this.loadedUser);

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();

  static const routeName = '/user-detail-screen';
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  void initState() {
    setState(() {
      //
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var devicelength = MediaQuery.of(context).size.height;

    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(' Profile '),
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
            TopRectangleBox(deviceWidth, widget.loadedUser.name,
                widget.loadedUser.phone, widget.loadedUser.piclink),
            sbox(15),
            const Text(
              'BIO DATA  ',
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
              subtitle: Text(widget.loadedUser.name),
            ),
            Divider(indent: 30, endIndent: 30),
            sbox(15),
            ListTile(
              title: Text(
                'Available in duration ',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(widget.loadedUser.availableIn),
            ),
            Divider(indent: 30, endIndent: 30),
            sbox(15),
            ListTile(
              title: Text(
                'Contact number  ',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(widget.loadedUser.phone),
            ),
            Divider(indent: 30, endIndent: 30),
            sbox(15),
            ListTile(
              title: Text(
                'Age  ',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(widget.loadedUser.age),
            ),
            Divider(indent: 30, endIndent: 30),
            sbox(15),
            ListTile(
              title: Text(
                'Mail address  ',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(widget.loadedUser.mail),
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
            Container(
              width: deviceWidth - 60,
              height: devicelength - 680,
              child: Text(widget.loadedUser.description),
            ),
            sbox(30),
            sbox(30),
          ]),
        ),
      ),
    );
  }
}

Widget ImageShowerWidget(link) {
  return CircleAvatar(
    radius: 75,
    // backgroundColor: Color.fromARGB(255, 94, 98, 107),
    child: CircleAvatar(
      radius: 75,
      backgroundImage: NetworkImage(
        link,
      ),
    ),
  );
}

Widget sbox(double? size) {
  return SizedBox(
    height: size,
  );
}

Widget TopRectangleBox(deviceWidth, name, mail, link) {
  return Container(
    child: Column(
      children: [
        SizedBox(
          height: 30,
        ),
        ImageShowerWidget(link),
        SizedBox(
          height: 20,
        ),
        Text(
          name.toString(),
          style: TextStyle(fontSize: 23, color: Colors.white),
        ),
        SizedBox(
          height: 8,
        ),
        Text(mail,
            style: TextStyle(
              color: Color.fromARGB(255, 140, 146, 161),
            )),
      ],
    ),
    height: 280,
    width: deviceWidth,
    padding: EdgeInsets.all(10),
    // color: Color.fromARGB(255, 94, 98, 107), //photo background COLOR
  );
}
