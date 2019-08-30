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
  String value = 'SELECT';

  _ChooserState();

  @override
  Widget build(BuildContext context) {
    final DetailState state = Provider.of<DetailState>(context);
    return GestureDetector(
      onTap: () async {
        if (state.isVariantsLoading) return;
        var result = await _showOptions(widget.options, state);
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
            Container(
              width: Constants.screenAwareSize(50, context),
              height: Constants.screenAwareSize(25, context),
              child: Center(
                child: Text(
                  widget.title,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.end,
                  style: TextStyle(fontFamily: 'Raleway', fontSize: 16),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              height: Constants.screenAwareSize(25, context),
              width: Constants.screenAwareSize(50, context),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.grey[600])),
              child: Center(
                  child: Text(value,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          decorationColor:
                              Theme.of(context).textTheme.title.color,
                          decoration: state.isVariantsLoading
                              ? TextDecoration.lineThrough
                              : TextDecoration.none))),
            )
          ],
        ),
      ),
    );
  }

  _showOptions(List options, DetailState state) {
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
                        title: Center(
                            child: Text(
                          value,
                          style: TextStyle(fontFamily: 'Raleway'),
                        )),
                      ))
                  .toList(),
            ),
          );
        });
  }
}


