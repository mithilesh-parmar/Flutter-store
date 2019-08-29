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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 6,
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
//              child: PageView.builder(
//                itemCount: widget.product.images.length,
//                controller: controller,
//                onPageChanged: (index) {
//                  setState(() {
//                    currentIndex = index;
//                  });
//                },
//                itemBuilder: (BuildContext context, int index) {
//                  return Container(
//                    margin: EdgeInsets.symmetric(horizontal: 4.0),
////                    decoration: BoxDecoration(
////                        image: DecorationImage(
////                            fit: BoxFit.contain,
////                            image: NetworkImage(widget.product.images[index]))
////                    ),
//                    child: ExtendedImage.network(
//                      widget.product.images[index],
//                      cache: true,
//                      mode: ExtendedImageMode.Gesture,
//                      initGestureConfigHandler: (state) {
//                        return GestureConfig(
//                            minScale: 0.9,
//                            animationMinScale: 0.7,
//                            maxScale: 3.0,
//                            animationMaxScale: 3.5,
//                            speed: 1.0,
//                            inertialSpeed: 100.0,
//                            initialScale: 1.0,
//                            inPageView: true);
//                      },
//                      // ignore: missing_return
//                      loadStateChanged: (ExtendedImageState imagestate) {
//                        switch (imagestate.extendedImageLoadState) {
//                          case LoadState.loading:
//                            //TODO add loading graphic
//                            return Shimmer(
//                                child:
//                                    Center(child: Icon(Icons.cloud_download)),
//                                gradient: LinearGradient(
//                                    colors: [Colors.black, Colors.white]));
//                            break;
//
//                          case LoadState.failed:
//                            return GestureDetector(
//                              child: Stack(
//                                fit: StackFit.expand,
//                                children: <Widget>[
//                                  Icon(
//                                    Icons.error_outline,
//                                    color: Colors.redAccent,
//                                  ),
//                                  Positioned(
//                                    bottom: 0.0,
//                                    left: 0.0,
//                                    right: 0.0,
//                                    child: Text(
//                                      "load image failed, click to reload",
//                                      textAlign: TextAlign.center,
//                                    ),
//                                  )
//                                ],
//                              ),
//                              onTap: () {
//                                imagestate.reLoadImage();
//                              },
//                            );
//                            break;
//                          case LoadState.completed:
//                            // TODO: Handle this case.
//                            break;
//                        }
//                      },
//                    ),
//                  );
//                },
//              ),
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
//                            image: DecorationImage(
//                                image:
//                                    NetworkImage(widget.product.images[pos])
//                            )
                        ),
                        child: ExtendedImage.network(
                          widget.product.images[pos],
                          cache: true,
                        ),
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
