import 'package:cool_store/states/detail_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chooser extends StatefulWidget {
  final String title;
  final List options;

  Chooser({this.title, this.options});

  @override
  _ChooserState createState() => _ChooserState(options[0]);
}

class _ChooserState extends State<Chooser> {
  int index = 0;
  String value;

  _ChooserState(this.value);

  @override
  Widget build(BuildContext context) {
    final DetailState state = Provider.of<DetailState>(context);
    return GestureDetector(
      onTap: () async {
        var result = await _showOptions(widget.options);
        if (result != null) {
          value = result;
          state.changeAttributesTo(widget.title, value);
          setState(() {});
        }
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Text(widget.title),
            SizedBox(
              width: 10,
            ),
            Text(value)
          ],
        ),
      ),
    );
  }

  _showOptions(List options) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: options
                  .map((value) => ListTile(
                        onTap: () {
                          Navigator.of(context).pop(value);
                        },
                        title: Text(value),
                      ))
                  .toList(),
            ),
          );
        });
  }
}
