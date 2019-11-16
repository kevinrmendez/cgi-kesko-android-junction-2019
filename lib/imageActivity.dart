import 'package:cgi_kesko/IngredientCheckbox.dart';
import 'package:cgi_kesko/recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
// import 'package:swipedetector/swipedetector.dart';

import 'FoodPicture.dart';
import 'SubtitleWidget.dart';

class ImageActivity extends StatefulWidget {
  final Recipe recipe;
  ImageActivity({this.recipe});
  @override
  ImageActivityState createState() => ImageActivityState();
}

class ImageActivityState extends State<ImageActivity> {
  int index;

  List<Widget> steps(List steps) {
    List<Widget> list = List();
    var stepNumber = 1;
    steps.forEach((step) {
      var row = Step(
        stepNumber: stepNumber,
        step: step,
      );
      list.add(row);
      stepNumber++;
    });
    return list;
  }

  @override
  void initState() {
    // index = data.indexOf(widget.recipe);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildLayout() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: <Widget>[
                  Container(
                    // A fixed-height child.
                    color: const Color(0xff808000), // Yellow
                    height: 120.0,
                  ),
                  Expanded(
                    // A flexible child that will grow to fit the viewport but
                    // still be at least as big as necessary to fit its contents.
                    child: Container(
                      color: const Color(0xff800000), // Red
                      height: 120.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _contentMargin({List<Widget> children}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(20),
      child: Column(children: children),
    );
  }

  List<Widget> _buildNutritionInfo(List data) {
    List<Widget> nutritionList = List();
    data.forEach((item) {
      var row = Row(
        children: <Widget>[
          Text(
            item["name"],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Text(item["amount"].toString()),
        ],
      );
      nutritionList.add(row);
    });
    return nutritionList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
              future: http.get(widget.recipe.image),
              builder: (BuildContext context,
                  AsyncSnapshot<http.Response> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Text('no connection founded, please try again');
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  case ConnectionState.done:
                    return Container(
                        height: MediaQuery.of(context).size.height,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Card(
                                child: Column(
                                  children: <Widget>[
                                    FoodPicture(recipe: widget.recipe),

                                    // Image.network(
                                    //   widget.recipe["image"],
                                    //   // fit: BoxFit.fitHeight,
                                    // ),

                                    Container(
                                      margin:
                                          EdgeInsetsDirectional.only(top: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Container(
                                              child: Text(
                                                widget.recipe.title,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              _recipeDetail(
                                                  'Cooks in:',
                                                  ' ${widget.recipe.time} minutes',
                                                  Icons.access_time),
                                              _recipeDetail(
                                                  'Serves:',
                                                  '${widget.recipe.serves}',
                                                  Icons.fastfood),
                                              _recipeDetail(
                                                  'Difficulty: ',
                                                  '${widget.recipe.difficulty}',
                                                  Icons.filter_vintage),
                                              // _smallText(
                                              //     'Difficulty ${widget.recipe.difficulty}'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IngredientList(
                                ingredientData: widget.recipe.ingredients,
                              ),
                              Card(
                                child: Column(
                                  children: <Widget>[
                                    SubtitleWidget("Instructions"),
                                    Column(
                                      children: steps(widget.recipe.steps),
                                    ),
                                  ],
                                ),
                              ),
                              widget.recipe.nutrition != null
                                  ? Card(
                                      child: Container(
                                        margin: EdgeInsets.all(20),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          children: [
                                            SubtitleWidget('Nutritional value'),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: _buildNutritionInfo(
                                                  widget.recipe.nutrition),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _smallText(String title, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Text(detail)
        ],
      ),
    );
  }

  Widget _recipeDetail(String title, String text, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 11,
          ),
          _smallText(title, text),
        ],
      ),
    );
  }

  Widget IngredientList({List ingredientData}) {
    List<Widget> list = [];
    ingredientData.forEach((item) {
      var row = Container(
          height: 30,
          child: Row(
            children: <Widget>[
              IngredientCheckbox(),
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  child: Text(
                    item,
                    overflow: TextOverflow.visible,
                  ),
                ),
              )
            ],
          ));
      list.add(row);
    });

    return Column(
      children: list,
    );
  }
}

class Step extends StatefulWidget {
  final String step;
  final int stepNumber;
  const Step({
    this.step,
    this.stepNumber,
    Key key,
  }) : super(key: key);

  @override
  _StepState createState() => _StepState();
}

class _StepState extends State<Step> {
  bool isChecked;
  @override
  void initState() {
    isChecked = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
          child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
            child: Text(
              "${widget.stepNumber}",
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 30),
            ),
          ),
          Flexible(
            child: Container(
              child: Text(
                "${widget.step}",
              ),
            ),
          ),
          Opacity(
              opacity: isChecked ? 1.0 : 0.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.check,
                  // color: AccentColor,
                ),
              ))
        ],
      )),
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
    );
  }
}
