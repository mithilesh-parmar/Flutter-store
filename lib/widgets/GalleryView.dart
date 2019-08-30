import 'package:carousel_slider/carousel_slider.dart';
import 'package:cool_store/app.dart';
import 'package:cool_store/models/product.dart';
import 'package:cool_store/states/detail_state.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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
          children: <Widget>[
            Expanded(
              child: ExtendedImageGesturePageView.builder(
                itemBuilder: (BuildContext context, int index) {
                  var item = widget.product.images[index];
                  Widget image = ExtendedImage.network(item,
                      fit: BoxFit.contain, mode: ExtendedImageMode.Gesture,
                      initGestureConfigHandler: (state) {
                    return GestureConfig(
                        minScale: 0.9,
                        animationMinScale: 0.7,
                        maxScale: 3.0,
                        animationMaxScale: 3.5,
                        speed: 1.0,
                        inertialSpeed: 100.0,
                        initialScale: 1.0,
                        inPageView: true);
                  });
                  image = Container(
                    child: image,
                    padding: EdgeInsets.all(5.0),
                  );
                  if (index == currentIndex) {
                    return Hero(
                      tag: item + index.toString(),
                      child: image,
                    );
                  } else {
                    return image;
                  }
                },
                itemCount: widget.product.images.length,
                onPageChanged: (int index) {
                  currentIndex = index;
                  setState(() {});
                },
                controller: controller,
                scrollDirection: Axis.horizontal,
              ),
            ),
            Container(
              height: 10,
              margin: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              child: ListView.builder(
                  itemCount: widget.product.images.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, pos) {
                    return Container(
                      width: 20,
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: currentIndex == pos
                                  ? Theme.of(context).accentColor
                                  : Colors.grey[600])),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
