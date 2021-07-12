import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:techquadra_asssignment/service/prefrence.dart';

class ListOFInput extends StatelessWidget {
  final String text;

  ListOFInput({this.text});

  final Prefrences prefrences = Prefrences();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: FutureBuilder(
          future: prefrences.getDataFromLocal(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              Map<String, dynamic> mapOfData = snapshot.data;
              return ListView(
                  children: mapOfData.values.toList().map<Widget>((e) {
                return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showAlertDialog(context);
                          },
                          child: RichText(
                            text: TextSpan(
                              children:
                                  highlightOccurrences(e['text'], 'Location'),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showAlertDialog(context);
                          },
                          child: RichText(
                            text: TextSpan(
                              children: highlightOccurrences(e['text'], 'Date'),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showAlertDialog(context);
                          },
                          child: RichText(
                            text: TextSpan(
                              children: highlightOccurrences(e['text'], 'Time'),
                            ),
                          ),
                        ),
                      ],
                    )

                    // e['text'] ?? "",
                    // style: TextStyle(
                    //   fontSize: 20,
                    //   fontWeight: FontWeight.w500,
                    // ),
                    // ),
                    );
              }).toList());
            }
          },
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("This is your message"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  List<TextSpan> highlightOccurrences(String source, String query) {
    if (query == null ||
        query.isEmpty ||
        !source.toLowerCase().contains(query.toLowerCase())) {
      return [TextSpan(text: source)];
    }
    final matches = query.toLowerCase().allMatches(source.toLowerCase());

    int lastMatchEnd = 0;

    final List<TextSpan> children = [];
    for (var i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);

      if (match.start != lastMatchEnd) {
        children.add(TextSpan(
          text: source.substring(lastMatchEnd, match.start),
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ));
      }

      children.add(
        TextSpan(
          text: source.substring(match.start, match.end),
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
        ),
      );

      if (i == matches.length - 1 && match.end != source.length) {
        children.add(
          TextSpan(
            text: source.substring(match.end, source.length),
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        );
      }

      lastMatchEnd = match.end;
    }
    return children;
  }
}
