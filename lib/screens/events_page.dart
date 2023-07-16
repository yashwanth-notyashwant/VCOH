import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vcoh/models/event.dart';
import 'package:vcoh/screens/add_event_screen.dart';
import 'package:vcoh/screens/dift_developer_coffe.dart';
import 'package:vcoh/screens/event_detail_screen.dart';
import 'package:vcoh/screens/invite_all.dart';
import 'package:vcoh/screens/profile.dart';

import '../models/User.dart';
import 'report_bug.dart';
import 'auth_page.dart';

class EventsPage extends StatefulWidget {
  final User obtainedUser;
  final List listForEmail;

  EventsPage(this.obtainedUser, this.listForEmail);
  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  Widget sbox(double? size) {
    return SizedBox(
      height: size,
    );
  }

  Widget ContentsOfDrawer(context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 94, 98, 107),
            ),
            child: Text(''),
          ),
          const Divider(indent: 30, endIndent: 30),
          ListTile(
            leading: Icon(Icons.person),
            title: const Text(
              'Profile ',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        UserDetailScreen(widget.obtainedUser)),
              );
            },
          ),
          const Divider(indent: 30, endIndent: 30),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: const Text(
              'Logout ! ',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AuthPage()),
              );
            },
          ),
          const Divider(indent: 30, endIndent: 30),
          ListTile(
            leading: Icon(Icons.adb),
            title: const Text(
              'Report a bug XD !',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactDevloper()),
              );
            },
          ),
          const Divider(indent: 30, endIndent: 30),
          ListTile(
            leading: Icon(Icons.campaign),
            title: const Text(
              'Invite All !',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InviteAll(widget.listForEmail)),
              );
            },
          ),
          const Divider(indent: 30, endIndent: 30),
          ListTile(
            leading: Hero(tag: 'alp', child: Icon(Icons.coffee)),
            title: const Text(
              'Gift Developer a Coffee ',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GiftDeveloperCoffe()),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 2.0;
    var deviceWidth = MediaQuery.of(context).size.width;
    var devicelength = MediaQuery.of(context).size.height;

    return FutureBuilder<List<Event>>(
      future: Provider.of<Events>(context, listen: false).allEventsFromServer(),
      builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            theme: ThemeData.dark(),
            home: Scaffold(
                appBar: AppBar(
                  //  color: Color.fromARGB(255, 94, 98, 107),
                  backgroundColor: Color.fromARGB(255, 94, 98, 107),
                  centerTitle: true,
                  title: Text('--- VCOH ---'),
                  // backgroundColor: Color.fromARGB(255, 94, 98, 107), //appbar COLOR
                  elevation: 0,
                ),
                drawer: ContentsOfDrawer(context),
                body: SingleChildScrollView(
                  child: Column(children: [
                    sbox(30),
                    Padding(
                      padding: EdgeInsets.only(left: 2),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          color: Color.fromARGB(255, 94, 98, 107),
                          height: 30,
                          width: MediaQuery.of(context).size.width,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              'All Events after : ' +
                                  DateFormat.MMMMd().format(DateTime.now()),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    sbox(30),
                    Container(
                      height: devicelength - 280,
                      width: deviceWidth - 20,
                      child: ListView.separated(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: ListTile(
                              // onTap: () {
                              //   // Navigator.push(
                              //   //   context,
                              //   //   MaterialPageRoute(
                              //   //       builder: (context) => EventDetailScreen(
                              //   //           snapshot.data![index])),
                              //   // );
                              // },
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration:
                                        Duration(milliseconds: 400),
                                    pageBuilder: (_, __, ___) =>
                                        EventDetailScreen(
                                            snapshot.data![index], index),
                                  ),
                                );
                              },

                              leading: Hero(
                                transitionOnUserGestures: true,
                                tag: 'myheroanimation$index',
                                child: Image(
                                  image: NetworkImage(
                                    snapshot.data![index].piclink,
                                  ),
                                  height: 36,
                                  width: 64,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                snapshot.data![index].creatorName,
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 18),
                              ),
                              subtitle: Text(
                                snapshot.data![index].creatorDesignation,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(indent: 30, endIndent: 30);
                        },
                      ),
                    ),
                    sbox(20),
                    Container(
                      height: 50,
                      width: deviceWidth - 50,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddEventScreen(
                                    widget.obtainedUser, widget.listForEmail)),
                          ); //   go to the forms page for adding a new user .
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        child: Text(
                          'ADD NEW EVENT',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ]),
                )),
          );
        } else {
          return Text("Something went wrong!");
        }
      },
    );
  }
}
