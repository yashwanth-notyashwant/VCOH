import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';

class InviteAll extends StatefulWidget {
  final List listOfEmail;

  InviteAll(this.listOfEmail);

  @override
  State<InviteAll> createState() => _InviteAllState();
}

class _InviteAllState extends State<InviteAll> {
  @override
  Widget build(BuildContext context) {
    List<List<dynamic>> rows = [widget.listOfEmail];
    String csv = const ListToCsvConverter().convert(rows);

    return MaterialApp(
      theme: ThemeData.dark(),
      home: EmailSender(csv),
    );
  }
}

class EmailSender extends StatefulWidget {
  var csv;
  EmailSender(this.csv);

  @override
  _EmailSenderState createState() => _EmailSenderState();
}

class _EmailSenderState extends State<EmailSender> {
  @override
  Widget build(BuildContext context) {
    List<String> attachments = [];
    bool isHTML = false;
    var alphamale = widget.csv;
    final _recipientController = TextEditingController(
      text: '$alphamale',
    );

    final _subjectController =
        TextEditingController(text: 'This is an event invitation from VCOH to all users ');

    final _bodyController = TextEditingController(
      text: ' Message from : VCOH team Event Organizer , ',
    );

    Future<void> send() async {
      final Email email = Email(
        body: _bodyController.text,
        subject: _subjectController.text,
        recipients: [_recipientController.text],
        attachmentPaths: attachments,
        isHTML: isHTML,
      );

      String platformResponse;

      try {
        await FlutterEmailSender.send(email);
        platformResponse = 'success';
      } catch (error) {
        platformResponse = error.toString();
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(platformResponse),
        ),
      );
    }

    void _openImagePicker() async {
      final picker = ImagePicker();
      PickedFile? pick = await picker.getImage(source: ImageSource.gallery);
      if (pick != null) {
        setState(() {
          attachments.add(pick.path);
        });
      }
    }

    void _removeAttachment(int index) {
      setState(() {
        attachments.removeAt(index);
      });
    }

    Future<void> _attachFileFromAppDocumentsDirectoy() async {
      try {
        final appDocumentDir = await getApplicationDocumentsDirectory();
        final filePath = appDocumentDir.path + '/file.txt';
        final file = File(filePath);
        await file.writeAsString('Text file in app directory');

        setState(() {
          attachments.add(filePath);
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create file in applicion directory'),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: <Widget>[
          IconButton(
            onPressed: send,
            icon: Icon(Icons.send),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _recipientController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Recipient : all_users',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _subjectController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Subject  ',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: _bodyController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                      labelText: 'Body : Describe the issue',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            CheckboxListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
              title: Text('HTML'),
              onChanged: (bool? value) {
                if (value != null) {
                  setState(() {
                    isHTML = value;
                  });
                }
              },
              value: isHTML,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  for (var i = 0; i < attachments.length; i++)
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            attachments[i],
                            softWrap: false,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.remove_circle),
                          onPressed: () => {_removeAttachment(i)},
                        )
                      ],
                    ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.attach_file),
                      onPressed: _openImagePicker,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
