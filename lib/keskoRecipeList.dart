import 'package:cgi_kesko/main.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import './recipe.dart';
import './data.dart';
import 'imageActivity.dart';
import 'dart:convert';
import './keskoRecipeList.dart' as jsonData;

class KeskoRecipeListActivity extends StatefulWidget {
  final String product;
  KeskoRecipeListActivity({Key key, this.product}) : super(key: key);

  @override
  _KeskoRecipeListActivityState createState() =>
      _KeskoRecipeListActivityState();
}

class _KeskoRecipeListActivityState extends State<KeskoRecipeListActivity> {
  List<Recipe> recipes;
  List parsedJson;

  Future loadData() async {
    parsedJson = json.decode(
        await DefaultAssetBundle.of(context).loadString("assets/recipes.json"));
    print(parsedJson);
    return parsedJson;
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  Recipe _recipeBuilder(data) {
    return Recipe(
        image: data["image"],
        title: data["title"],
        category: data["category"],
        difficulty: data["difficulty"],
        suggestions: data["suggestions"],
        time: data["time"],
        serves: data["serves"],
        ingredients: data["ingredients"],
        steps: data["steps"],
        labels: data["labels"],
        nutrition: data["nutrition"],
        isFavorite: false);
  }

  Widget _cardDetailText(text) {
    return Flexible(
      child: Container(
        width: MediaQuery.of(context).size.width * .6,
        child: Text(
          text,
          textAlign: TextAlign.right,
          style: TextStyle(
              color: Colors.white,
              // fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List filterList = [];

    data.forEach((item) {
      if (item["category"] == widget.product) {
        filterList.add(item);
      }
    });

    return Scaffold(
        appBar: AppBar(
          title: Text("Check these recipes with ${widget.product}"),
        ),
        body: FutureBuilder(
          builder: (context, projectSnap) {
            if (projectSnap.connectionState == ConnectionState.none &&
                projectSnap.hasData == null) {
              //print('project snapshot data is: ${projectSnap.data}');
              return Container();
            }
            if (projectSnap.connectionState == ConnectionState.waiting) {
              //print('project snapshot data is: ${projectSnap.data}');
              return Container();
            }
            return ListView.builder(
              itemCount: projectSnap.data.length,
              itemBuilder: (context, index) {
                // ProjectModel project = projectSnap.data[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  height: MediaQuery.of(context).size.height * .3,
                  width: MediaQuery.of(context).size.width,
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => ImageActivity(
                      //             recipe: recipe,
                      //           )),
                      // );
                    },
                    child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        fit: StackFit.loose,
                        children: [
                          CachedNetworkImage(
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover)),
                            ),
                            imageUrl: projectSnap.data[index]["PictureUrl"],
                            placeholder: (context, url) => Container(
                              width: MediaQuery.of(context).size.width,
                              color: GreyColor,
                              // constraints: BoxConstraints(maxHeight: 30, maxWidth: 30),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: new CircularProgressIndicator()),
                                ],
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                color: GreyColor,
                                child: Icon(
                                  Icons.error,
                                  size: 40,
                                  // color: PrimaryColor,
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                _cardDetailText(
                                    projectSnap.data[index]["Name"]),
                                // _cardDetailText("${recipe.time} min")
                              ],
                            ),
                          )
                        ]),
                  ),
                );
              },
            );
          },
          future: loadData(),
        )
        // body: ListView.builder(
        //     itemCount: filterList.length,
        //     itemBuilder: (BuildContext ctxt, int index) {
        //       Recipe recipe = _recipeBuilder(filterList[index]);
        //       return Container(
        //         margin: EdgeInsets.symmetric(vertical: 5),
        //         height: MediaQuery.of(context).size.height * .3,
        //         width: MediaQuery.of(context).size.width,
        //         child: GestureDetector(
        //           onTap: () {
        //             Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (context) => ImageActivity(
        //                         recipe: recipe,
        //                       )),
        //             );
        //           },
        //           child: Stack(
        //               alignment: AlignmentDirectional.bottomEnd,
        //               fit: StackFit.loose,
        //               children: [
        //                 CachedNetworkImage(
        //                   imageBuilder: (context, imageProvider) => Container(
        //                     decoration: BoxDecoration(
        //                         image: DecorationImage(
        //                             image: imageProvider, fit: BoxFit.cover)),
        //                   ),
        //                   imageUrl: recipe.image,
        //                   placeholder: (context, url) => Container(
        //                     width: MediaQuery.of(context).size.width,
        //                     color: GreyColor,
        //                     // constraints: BoxConstraints(maxHeight: 30, maxWidth: 30),
        //                     child: Column(
        //                       mainAxisAlignment: MainAxisAlignment.center,
        //                       children: <Widget>[
        //                         SizedBox(
        //                             height: 40,
        //                             width: 40,
        //                             child: new CircularProgressIndicator()),
        //                       ],
        //                     ),
        //                   ),
        //                   errorWidget: (context, url, error) => Container(
        //                       height: MediaQuery.of(context).size.height,
        //                       width: MediaQuery.of(context).size.width,
        //                       color: GreyColor,
        //                       child: Icon(
        //                         Icons.error,
        //                         size: 40,
        //                         // color: PrimaryColor,
        //                       )),
        //                 ),
        //                 Container(
        //                   margin: EdgeInsets.all(10),
        //                   child: Column(
        //                     mainAxisAlignment: MainAxisAlignment.end,
        //                     crossAxisAlignment: CrossAxisAlignment.end,
        //                     children: <Widget>[
        //                       _cardDetailText(recipe.title),
        //                       _cardDetailText("${recipe.time} min")
        //                     ],
        //                   ),
        //                 )
        //               ]),
        //         ),
        //       );
        // })
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
