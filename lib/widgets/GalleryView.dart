import 'package:carousel_slider/carousel_slider.dart';
import 'package:cool_store/app.dart';
import 'package:cool_store/models/product.dart';
import 'package:cool_store/states/detail_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GalleryView extends StatefulWidget {
  final Product product;

  GalleryView({this.product});

  @override
  _GalleryViewState createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  int currentIndex = 0;

  PageController controller = PageController();

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 6,
              child: PageView.builder(
                itemCount: widget.product.images.length,
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: NetworkImage(widget.product.images[index]))),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: widget.product.images.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, pos) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          currentIndex = pos;
                          controller.animateToPage(
                            pos,
                            duration: Duration(seconds: 1),
                            curve: Curves.decelerate,
                          );
                        });
                      },
                      child: Container(
                        width: 80,
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: currentIndex == pos
                                    ? Theme.of(context).accentColor
                                    : Colors.grey[400]),
                            image: DecorationImage(
                                image:
                                    NetworkImage(widget.product.images[pos]))),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
