import 'package:cached_network_image/cached_network_image.dart';
import 'package:cgi_kesko/recipe.dart';

import 'package:flutter/material.dart';

class FoodPicture extends StatefulWidget {
  final Recipe recipe;
  FoodPicture({this.recipe});
  @override
  _FoodPictureState createState() => _FoodPictureState();
}

class _FoodPictureState extends State<FoodPicture> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      fit: StackFit.loose,
      children: <Widget>[
        // Container(
        //   height: MediaQuery.of(context).size.height * .4,
        //   decoration: BoxDecoration(
        //       color: GreyColor,
        //       image: DecorationImage(
        //           image: NetworkImage(widget.recipe.image), fit: BoxFit.cover)),
        // ),
        Container(
          height: MediaQuery.of(context).size.height * .4,
          child: CachedNetworkImage(
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover)),
            ),
            imageUrl: widget.recipe.image,
            placeholder: (context, url) => Container(
              width: MediaQuery.of(context).size.height,
              // color: GreyColor,
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
                width: MediaQuery.of(context).size.width,
                // color: GreyColor,
                child: Icon(
                  Icons.error,
                  size: 40,
                  // color: PrimaryColor,
                )),
          ),
        ),
      ],
    );
  }
}
