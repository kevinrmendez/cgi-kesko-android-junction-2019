import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import './recipe.dart';
import './data.dart';
import 'imageActivity.dart';

class RecipeListActivity extends StatefulWidget {
  RecipeListActivity({Key key}) : super(key: key);

  @override
  _RecipeListActivityState createState() => _RecipeListActivityState();
}

class _RecipeListActivityState extends State<RecipeListActivity> {
  List<String> litems = ["1", "2", "Third", "4"];
  List<Recipe> recipes;
  @override
  void initState() {
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
    return Scaffold(
        appBar: AppBar(
          title: Text("Recipe List"),
        ),
        body: ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext ctxt, int index) {
              Recipe recipe = _recipeBuilder(data[index]);
              return Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                height: MediaQuery.of(context).size.height * .3,
                width: MediaQuery.of(context).size.width,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImageActivity(
                                recipe: recipe,
                              )),
                    );
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
                          imageUrl: recipe.image,
                          placeholder: (context, url) => Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.red,
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
                              color: Colors.red,
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
                              _cardDetailText(recipe.title),
                              _cardDetailText("${recipe.time} min")
                            ],
                          ),
                        )
                      ]),
                ),
              );
            })
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
