import 'package:cool_store/screens/detail_screen.dart';
import 'package:cool_store/states/search_state.dart';
import 'package:cool_store/utils/constants.dart';
import 'package:cool_store/widgets/ProductCard.dart';
import 'package:cool_store/widgets/ShimmerGrid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<SearchState>(context);
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                  delegate: SliverChildListDelegate([
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[600])),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          state.clearResult();
                        },
                        onSubmitted: (value) {
                          state.setKeyword(value);
                        },
                        decoration: InputDecoration(
                            focusedErrorBorder: InputBorder.none,
                            hintText: 'Search for products',
                            errorBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none),
                      )),
                      IconButton(
                          icon: Icon(Icons.clear_all),
                          onPressed: () {
                            state.clearResult();
                            _searchController.clear();
                          })
                    ],
                  ),
                ),
                state.showKeywords
                    ? ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.keyWords.length,
                        itemBuilder: (context, pos) {
                          return ListTile(
                            title: Text('${state.keyWords[pos]}'),
                            leading: Icon(Icons.search),
                            trailing: Icon(Icons.chevron_right),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(),
                      )
                    : state.isResultLoading
                        ? ShimmerGrid()
                        : GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 2,
                                    crossAxisSpacing: 2,
                                    childAspectRatio: .6),
                            itemCount: state.searchResult.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, pos) {
                              return ProductDisplayCard(
                                onPressed: () {},
                                product: state.searchResult[pos],
                              );
                            })
              ]))
            ],
          ),
        ));
  }
}
