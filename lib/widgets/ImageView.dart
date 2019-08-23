import 'package:carousel_slider/carousel_slider.dart';
import 'package:cool_store/models/product.dart';
import 'package:cool_store/states/detail_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DetailState state = Provider.of<DetailState>(context);

    return GestureDetector(
      onTap: () {
        _showImageGallery(context);
      },
      child: state.isLoading
          ? Container(
              color: Colors.grey[300],
            )
          : CarouselSlider(
              viewportFraction: .9,
              aspectRatio: 1,
              enlargeCenterPage: true,
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

  _showImageGallery(context) {
    showDialog(
        context: context,
        builder: (context) => Container(
              height: 200,
              color: Colors.red,
            ));
  }
}
