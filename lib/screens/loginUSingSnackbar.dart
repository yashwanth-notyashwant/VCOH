import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vcoh/models/User.dart';
import 'package:vcoh/screens/events_page.dart';

class LoginUsingSnackBar extends StatefulWidget {
  var myController1;
  var myController2;
  var formkey;

  LoginUsingSnackBar(this.myController1, this.myController2, this.formkey);

  @override
  State<LoginUsingSnackBar> createState() => _LoginUsingSnackBarState();
}

class _LoginUsingSnackBarState extends State<LoginUsingSnackBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
              ),
              // ignore: sized_box_for_whitespace
              child: Container(
                height: 38,
                child: const Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 5),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
              onPressed: () async {
                final isValid = widget.formkey.currentState.validate();
                if (!isValid) {
                  return;
                }
                var thisIsId = widget.myController1.text.toString().trim();

                var userObtainded =
                    await Provider.of<Users>(context, listen: false)
                        .allUserLoaderFromServer(
                            thisIsId, widget.myController2.toString().trim());

                // var abc = await Provider.of<Users>(context, listen: false)
                //     .allUserMail();
                if (userObtainded[0].id == '') {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        '         Enter mobile number',
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else if (userObtainded[0].id != thisIsId) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        '         USER NOT FOUND',
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else if (userObtainded[0].password !=
                    widget.myController2.text.trim()) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        '        Wrong password',
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else if (userObtainded[0].id == thisIsId &&
                    userObtainded[0].password ==
                        widget.myController2.text.trim()) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EventsPage(userObtainded[0], userObtainded[1]),
                    ),
                  );
                } else
                  return;
              },
            ),
          ),
        ],
      ),
    );
  }
}
