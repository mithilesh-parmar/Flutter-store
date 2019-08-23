import 'package:carousel_slider/carousel_slider.dart';
import 'package:cool_store/states/detail_state.dart';
import 'package:cool_store/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DetailState state = Provider.of<DetailState>(context);

    return GestureDetector(
      onTap: () {
        _showImageGallery(context, state);
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

  _showImageGallery(context, DetailState state) {
    showDialog(
        context: context,
        builder: (context) => PageView.builder(
              itemCount: state.product.images.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 17.0, vertical: 17),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey,
                          offset: Offset(0, 10),
                          blurRadius: 10,
                        )
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              NetworkImage('${state.product.images[index]}'))),
                );
              },
            ));
  }
}
