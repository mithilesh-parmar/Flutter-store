import 'package:cool_store/states/detail_state.dart';
import 'package:cool_store/utils/color.dart';
import 'package:cool_store/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ColorChooser extends StatefulWidget {
  final String title;
  final List options;

  ColorChooser({this.title, this.options});

  @override
  _ColorChooserState createState() => _ColorChooserState();
}

class _ColorChooserState extends State<ColorChooser> {
  int selectedIndex = -1;
  int time = 1000;
  int offset = 50;
  bool isSafe = true;

  Color baseColor, highlightColor, borderColor, accentColor;

  @override
  Widget build(BuildContext context) {
    widget.options.forEach((value) {
      value = value.replaceAll(' ', '').toLowerCase();
      if (colors.containsKey(value) == false) {
        setState(() {
          isSafe = false;
        });
      }
    });
    final state = Provider.of<DetailState>(context);
    final theme = Theme.of(context);
    baseColor = theme.iconTheme.color;
    highlightColor = theme.primaryColor;
    accentColor = theme.accentColor.withOpacity(.85);
    borderColor = theme.textTheme.title.color.withOpacity(.7);

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
                      ? buildLoadingContainers(pos, time)
                      : buildVariantContainer(state, pos);
                }),
          )
        ],
      ),
    );
  }

  Widget buildLoadingContainers(pos, time) {
    return Shimmer.fromColors(
      child: Container(
        padding: EdgeInsets.all(8),
        constraints: BoxConstraints(
            minWidth: Constants.screenAwareSize(30, context),
            minHeight: Constants.screenAwareSize(35, context)),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(2)),
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
        constraints: BoxConstraints(
            minWidth: Constants.screenAwareSize(30, context),
            minHeight: Constants.screenAwareSize(35, context)),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: isSafe
                ? HexColor(colors[widget.options[pos].toLowerCase()])
                    .withOpacity(.6)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(2),
            border: Border.all(
                color: selectedIndex == pos ? accentColor : borderColor)),
        child: Center(
            child: Text(
          '${isSafe ? '' : widget.options[pos]}',
        )),
      ),
    );
  }
}

class SemiClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    //path.lineTo(size.width, 0.0);
   // path.lineTo(size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
