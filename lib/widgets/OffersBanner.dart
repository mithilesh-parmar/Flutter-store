import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class OffersBanner extends StatelessWidget {
  final imageList = [
    'https://assets.myntassets.com/w_980,c_limit,fl_progressive,dpr_2.0/assets/images/banners/2019/8/2/1f55b32d-a54f-4130-8de6-142167685e941564742794212-desktop.jpg',
    'https://assets.myntassets.com/w_980,c_limit,fl_progressive,dpr_2.0/assets/images/banners/2019/8/3/8e251762-1833-4490-9612-67c11877b2d61564848407937-Gerua_Desk_Banner.jpg',
    'https://assets.myntassets.com/w_980,c_limit,fl_progressive,dpr_2.0/assets/images/banners/2019/8/3/8fe43105-e031-4271-b66a-017abefd25ba1564848407967-Highlander_Desk_Banner.jpg',
    'https://assets.myntassets.com/w_980,c_limit,fl_progressive,dpr_2.0/assets/images/banners/2019/8/3/c0232ddd-5017-4dbe-8cf8-108e4a111b0a1564848407994-Jockey_Desk_Banner.jpg',
    'https://assets.myntassets.com/w_980,c_limit,fl_progressive,dpr_2.0/assets/images/banners/2019/8/3/71cbabc8-2fdf-42b9-8179-4cd136aa5f5b1564848408043-Only_Desk_Banner.jpg',
    'https://assets.myntassets.com/w_980,c_limit,fl_progressive,dpr_2.0/assets/images/banners/2019/8/3/c27bc5ae-17dc-4326-b44c-f761da6e48fe1564848408020-Portico_Desk_Banner.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      autoPlay: true,
      pauseAutoPlayOnTouch: Duration(seconds: 1),
      viewportFraction: 0.9,
      aspectRatio: 1,
      enlargeCenterPage: true,
      items: imageList.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(url))),
            );
          },
        );
      }).toList(),
    );
  }
}
