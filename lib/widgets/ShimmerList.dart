import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerList extends StatelessWidget {
  int time = 600;
  int offset = 50;

  final Axis direction;

  ShimmerList({this.direction = Axis.vertical});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
          scrollDirection: direction,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 4,
          shrinkWrap: true,
          itemBuilder: (context, pos) {
            offset += 50;
            time += offset;
            return Shimmer.fromColors(
              child: direction == Axis.horizontal
                  ? ShimmerHorizontalLayout()
                  : ShimmerLayout(),
              highlightColor: Colors.white,
              period: Duration(milliseconds: time),
              baseColor: Colors.grey[300],
            );
          }),
    );
  }
}

class ShimmerHorizontalLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width / 2,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.grey,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 40),
            height: 10,
            color: Colors.grey,
          ),
          Container(
            margin: EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 80),
            height: 10,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}

class ShimmerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = (MediaQuery.of(context).size.height) / 2 - 150;
    return Container(
      margin: EdgeInsets.all(4),
      height: height,
      color: Colors.grey,
    );
  }
}
