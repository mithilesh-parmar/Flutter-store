import 'package:cool_store/states/detail_state.dart';
import 'package:cool_store/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class VariantChooser extends StatefulWidget {
  final String title;
  final List options;

  VariantChooser({this.title, this.options});

  @override
  _VariantChooserState createState() => _VariantChooserState();
}

class _VariantChooserState extends State<VariantChooser> {
  int selectedIndex = -1;
  int time = 1000;
  int offset = 50;

  Color baseColor, highlightColor;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<DetailState>(context);
    final theme = Theme.of(context);
    baseColor = theme.iconTheme.color;
    highlightColor = theme.primaryColor;
    return Container(
      height: Constants.screenAwareSize(40, context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.title),
              )),
          Expanded(
            flex: 4,
            child: ListView.builder(
                itemCount: widget.options.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, pos) {
                  offset += 80;
                  time += offset;
                  return state.isVariantsLoading
                      ? buildLoadingContainers(
                          pos, time, baseColor, highlightColor)
                      : buildVariantContainer(state, pos);
                }),
          )
        ],
      ),
    );
  }

  Widget buildLoadingContainers(pos, time, baseColor, highlightColor) {
    return Shimmer.fromColors(
      child: Container(
        padding: EdgeInsets.all(8),
        constraints:
            BoxConstraints(minWidth: Constants.screenAwareSize(20, context)),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(2)
        ),
        child: Center(
            child: Text(
          '${widget.options[pos]}',
        )),
      ),
      period: Duration(milliseconds: time),
      highlightColor: highlightColor,
      baseColor: baseColor,
    );
  }

  Widget buildVariantContainer(state, pos) {
    return GestureDetector(
      onTap: () {
        state.changeAttributesTo(widget.title, widget.options[pos]);
        selectedIndex = pos;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(8),
        constraints:
            BoxConstraints(minWidth: Constants.screenAwareSize(20, context)),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(
                color: selectedIndex == pos ? Colors.redAccent : Colors.black)),
        child: Center(
            child: Text(
          '${widget.options[pos]}',
        )),
      ),
    );
  }
}
