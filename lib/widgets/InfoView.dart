import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InfoView extends StatelessWidget {
  final String primaryText, secondaryText, path;
  final Color iconColor;

  InfoView(
      {this.primaryText,
      this.secondaryText,
      this.iconColor,
      this.path = 'assets/no_result.svg'});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: SvgPicture.asset(
            path,
            height: MediaQuery.of(context).size.height / 4,
            color: iconColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            primaryText,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 35,
                fontWeight: FontWeight.w200),
          ),
        ),
        if (secondaryText != null)
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              secondaryText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 16,
                  fontWeight: FontWeight.w200),
            ),
          ),
      ],
    );
  }
}
