import 'package:cgi_kesko/product.dart';
import 'package:cgi_kesko/recipeList.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cached_network_image/cached_network_image.dart';
import './recipe.dart';
import './data.dart';
import 'imageActivity.dart';
import './product.dart';
import './productsData.dart';
import './AppDrawer.dart';

class ExpiringListActivity extends StatefulWidget {
  ExpiringListActivity({Key key}) : super(key: key);

  @override
  _ExpiringListActivityState createState() => _ExpiringListActivityState();
}

class _ExpiringListActivityState extends State<ExpiringListActivity> {
  // List<String> litems = ["1", "2", "Third", "4"];
  List<Product> products;

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  void firebaseCloudMessagingListeners() {
    _firebaseMessaging.getToken().then((token) {
      print(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
    _firebaseMessaging.getToken().then((token) {
      print(" TOKEN : $token");
    });
  }

  @override
  void initState() {
    firebaseCloudMessagingListeners();
    super.initState();
  }

  Product _productBuilder(data) {
    return Product(
        image: data["image"],
        name: data["name"],
        expirationDate: data["expirationDate"]);
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
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text("Expiring Products"),
        ),
        body: ListView.builder(
            itemCount: productsData.length,
            itemBuilder: (BuildContext ctxt, int index) {
              Product product = _productBuilder(productsData[index]);
              // if (index == 0) {
              //   return Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Text(
              //       'Expiring products',
              //       style: TextStyle(fontSize: 30),
              //     ),
              //   );
              // }

              return ListTile(
                title: Text(product.name),
                subtitle:
                    Text('Expiration date: ${product.expirationDate} days'),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(product
                      .image), // no matter how big it is, it won't overflow
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecipeListActivity(
                              product: product.name,
                            )),
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
