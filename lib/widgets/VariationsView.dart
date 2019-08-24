import 'package:cool_store/states/detail_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// TODO build it generic
class VariationsView extends StatefulWidget {
  @override
  _VariationsViewState createState() => _VariationsViewState();
}

class _VariationsViewState extends State<VariationsView> {
  @override
  Widget build(BuildContext context) {
    final DetailState state = Provider.of<DetailState>(context);
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: state.product.attributes.map((value) {
          return Chooser(
            title: value.name,
            options: value.options,
          );
        }).toList());
  }
}

class Chooser extends StatefulWidget {
  final String title;
  final List options;
  String value;

  Chooser({this.title, this.options}) {
    value = options[0];
  }

  @override
  _ChooserState createState() => _ChooserState();
}

class _ChooserState extends State<Chooser> {
  @override
  Widget build(BuildContext context) {
    final DetailState state = Provider.of<DetailState>(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          'CHOOSE ${widget.title}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        height: 1,
                        decoration: BoxDecoration(color: Colors.grey[200]),
                      ),
                      for (final option in widget.options)
                        ListTile(
                            onTap: () {
//                              state.changeAttributesTo(widget.title, option);
                              //TODO the value does not update when state is used
                              widget.value = option;
                              setState(() {});
                              Navigator.pop(context);
                            },
                            title: Text(
                              option.toString(),
                              textAlign: TextAlign.center,
                            )),
                    ],
                  ),
                );
              });
        });
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Text(widget.title),
            SizedBox(
              width: 10,
            ),
            Text(widget.value)
          ],
        ),
      ),
    );
  }
}
