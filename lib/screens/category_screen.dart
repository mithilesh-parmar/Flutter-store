import 'package:cool_store/screens/product_list_screen.dart';
import 'package:cool_store/screens/search_screen.dart';
import 'package:cool_store/states/product_list_state.dart';
import 'package:cool_store/states/category_state.dart';
import 'package:cool_store/states/search_state.dart';
import 'package:cool_store/utils/constants.dart';
import 'package:cool_store/widgets/GalleryView.dart';
import 'package:cool_store/widgets/ShimmerList.dart';
import 'package:cool_store/widgets/category_banner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CategoryState state = Provider.of<CategoryState>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            snap: true,
            centerTitle: false,
            bottom: PreferredSize(
              preferredSize: Size(100, 100),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (_) => ChangeNotifierProvider(
                            child: SearchScreen(),
                            builder: (_) => SearchState(),
                          )));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Search',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway',
                            fontSize: 40),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 17, vertical: 8),
                    ),
                    Container(
                      height: Constants.screenAwareSize(40, context),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: <Widget>[
                          Align(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'SEARCH FOR BRAND, PRODUCTS, CATEGORY',
                                style: TextStyle(
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w200,
                                    fontSize: 12),
                              ),
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          Spacer(),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(Icons.search),
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(left: 18, right: 18),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            state.isLoading
                ? ShimmerList()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.categories.length,
                    itemBuilder: (context, pos) {
                      return CategoryBanner(state.categories[pos], () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return ProductListScreen(
                              state.categories[pos].id,
                              state.categories[pos].image,
                              state.categories[pos].name);
                        }));
                      });
                    })
          ]))
        ],
      ),
    );
  }
}
