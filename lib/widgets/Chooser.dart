import 'package:cool_store/states/detail_state.dart';
import 'package:cool_store/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chooser extends StatefulWidget {
  final String title;
  final List options;

  Chooser({this.title, this.options});

  @override
  _ChooserState createState() => _ChooserState();
}

class _ChooserState extends State<Chooser> {
  int index = 0;
  String value = 'select';

  _ChooserState();

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
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              widget.title,
              softWrap: true,
              overflow: TextOverflow.fade,
              style: TextStyle(fontFamily: 'Raleway', fontSize: 16),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              height: Constants.screenAwareSize(25, context),
              width: Constants.screenAwareSize(50, context),
              decoration: BoxDecoration(border: Border.all()),
              child: Center(
                  child: Text(value,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      style: TextStyle(fontWeight: FontWeight.w600))),
            )
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
