import 'package:cgi_kesko/product.dart';
import 'package:cgi_kesko/recipeList.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import './recipe.dart';
import './data.dart';
import 'imageActivity.dart';
import './product.dart';
import './productsData.dart';

class ExpiringListActivity extends StatefulWidget {
  ExpiringListActivity({Key key}) : super(key: key);

  @override
  _ExpiringListActivityState createState() => _ExpiringListActivityState();
}

class _ExpiringListActivityState extends State<ExpiringListActivity> {
  // List<String> litems = ["1", "2", "Third", "4"];
  List<Product> products;
  @override
  void initState() {
    super.initState();
  }

  Product _productBuilder(data) {
    return Product(
        image: data["image"],
        name: data["name"],
        expirationDate: data["category"]);
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
          title: Text("Expiring List"),
        ),
        body: ListView.builder(
            itemCount: productsData.length,
            itemBuilder: (BuildContext ctxt, int index) {
              Product product = _productBuilder(productsData[index]);

              return ListTile(
                title: Text(product.name),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(product
                      .image), // no matter how big it is, it won't overflow
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecipeListActivity()),
                  );
                },
              );

              // return Container(
              //   margin: EdgeInsets.symmetric(vertical: 5),
              //   height: MediaQuery.of(context).size.height * .3,
              //   width: MediaQuery.of(context).size.width,
              //   child: GestureDetector(
              //     onTap: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => RecipeListActivity()),
              //       );
              //     },
              //     child: Stack(
              //         alignment: AlignmentDirectional.bottomEnd,
              //         fit: StackFit.loose,
              //         children: [
              //           CachedNetworkImage(
              //             imageBuilder: (context, imageProvider) => Container(
              //               decoration: BoxDecoration(
              //                   image: DecorationImage(
              //                       image: imageProvider, fit: BoxFit.cover)),
              //             ),
              //             imageUrl: product.image,
              //             placeholder: (context, url) => Container(
              //               width: MediaQuery.of(context).size.width,
              //               color: Colors.red,
              //               // constraints: BoxConstraints(maxHeight: 30, maxWidth: 30),
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: <Widget>[
              //                   SizedBox(
              //                       height: 40,
              //                       width: 40,
              //                       child: new CircularProgressIndicator()),
              //                 ],
              //               ),
              //             ),
              //             errorWidget: (context, url, error) => Container(
              //                 height: MediaQuery.of(context).size.height,
              //                 width: MediaQuery.of(context).size.width,
              //                 color: Colors.red,
              //                 child: Icon(
              //                   Icons.error,
              //                   size: 40,
              //                   // color: PrimaryColor,
              //                 )),
              //           ),
              //           Container(
              //             margin: EdgeInsets.all(10),
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.end,
              //               crossAxisAlignment: CrossAxisAlignment.end,
              //               children: <Widget>[
              //                 _cardDetailText(recipe.title),
              //                 _cardDetailText("${recipe.time} min")
              //               ],
              //             ),
              //           )
              //         ]),
              //   ),
              // );
            })
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
