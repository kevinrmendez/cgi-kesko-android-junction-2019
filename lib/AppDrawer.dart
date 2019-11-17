import 'dart:async';

import 'package:cgi_kesko/expiringListActivity.dart';
import 'package:cgi_kesko/keskoRecipeList.dart';
import 'package:cgi_kesko/recipeList.dart';
import 'package:flutter/material.dart';

import 'Settings.dart';
import 'main.dart';

class AppDrawer extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .8,
      child: Drawer(
        child: Container(
          color: GreyColor,
          child: ListView(
            children: <Widget>[
              // UserAccountsDrawerHeader(
              //   // accountName: Text('Bad Jokes'),
              //   currentAccountPicture: CircleAvatar(
              //     backgroundImage: AssetImage('assets/smile.png'),
              //   ),
              // ),
              // Container(
              //   height: 110,
              //   color: Colors.yellow[600],
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[
              //       Container(
              //           height: 70, child: Image.asset('assets/smile.png')),
              //     ],
              //   ),
              // ),
              DrawerHeader(
                child: SizedBox(),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/logo.png'), fit: BoxFit.cover),
                  // color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text(
                  "Home",
                  // style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                trailing: Icon(
                  Icons.home,
                  color: Theme.of(context).accentColor,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ExpiringListActivity()));
                },
              ),
              ListTile(
                title: Text(
                  "Settings",
                  // style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                trailing: Icon(
                  Icons.settings,
                  color: Theme.of(context).accentColor,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Settings()));
                },
              ),
              ListTile(
                title: Text(
                  "All Recipes",
                  // style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                trailing: Icon(
                  Icons.settings,
                  color: Theme.of(context).accentColor,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          KeskoRecipeListActivity()));
                },
              ),
              // ListTile(
              //   title: Text(
              //     "Recipes",
              //     // style: TextStyle(color: Theme.of(context).primaryColor),
              //   ),
              //   trailing: Icon(
              //     Icons.favorite,
              //     color: Theme.of(context).accentColor,
              //   ),
              //   onTap: () {
              //     Navigator.of(context).pop();
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (BuildContext context) => RecipeListActivity()));
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
