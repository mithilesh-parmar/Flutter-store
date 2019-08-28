import 'package:cool_store/screens/detail_screen.dart';
import 'package:cool_store/states/home_state.dart';
import 'package:cool_store/utils/constants.dart';
import 'package:cool_store/widgets/OffersBanner.dart';
import 'package:cool_store/widgets/ProductCard.dart';
import 'package:cool_store/widgets/ShimmerGrid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeState state = Provider.of<HomeState>(context);
    return SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: Constants.screenAwareSize(300, context),
            flexibleSpace: FlexibleSpaceBar(
                background: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18, top: 18, bottom: 20),
                    child: Text(
                      'COOL STORE',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway',
                          fontSize: 40),
                    ),
                  ),
                  Container(
                    height: Constants.screenAwareSize(200, context),
                    width: MediaQuery.of(context).size.width,
                    child: OffersBanner(),
                  )
                ],
              ),
            )),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: EdgeInsets.all(18),
              child: Row(
                children: <Widget>[
                  Text(
                    'BEST SELLERS',
                    style: TextStyle(
                        fontFamily: 'Raleway', fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  FlatButton(
                    onPressed: () {},
                    child: Text('SEE ALL',
                        style: TextStyle(fontFamily: 'Raleway', fontSize: 12)),
                  )
                ],
              ),
            ),
            state.isLoading
                ? ShimmerGrid()
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: .6,
                        crossAxisCount: 2,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1),
                    itemBuilder: (context, pos) => ProductDisplayCard(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    DetailScreen(state.products[pos]),
                                fullscreenDialog: true));
                      },
                      product: state.products[pos],
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.products.length,
                  ),
          ]))
        ],
      ),
    );
  }
}
