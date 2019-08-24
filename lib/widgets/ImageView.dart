import 'package:carousel_slider/carousel_slider.dart';
import 'package:cool_store/states/detail_state.dart';
import 'package:cool_store/utils/constants.dart';
import 'package:cool_store/widgets/GalleryView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DetailState state = Provider.of<DetailState>(context);

    return GestureDetector(
      onTap: () {
        if (!state.isLoading)
          Navigator.push(
              context,
              MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => GalleryView(product: state.product)));
      },
      child: state.isLoading
          ? Container(
              color: Colors.grey[300],
            )
          : CarouselSlider(
              viewportFraction: .9,
              aspectRatio: 1,
              enlargeCenterPage: true,
              height: Constants.screenAwareSize(250, context),
              items: state.product.images.map((url) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueGrey,
                              offset: Offset(0, 10),
                              blurRadius: 10,
                            )
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          image: DecorationImage(
                              fit: BoxFit.cover, image: NetworkImage(url))),
                    );
                  },
                );
              }).toList(),
            ),
    );
  }
}
