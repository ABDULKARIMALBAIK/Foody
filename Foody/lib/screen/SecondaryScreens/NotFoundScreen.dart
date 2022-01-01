import 'package:flutter/material.dart';
import 'package:foody/widget/DataTemplate/DataTamplete.dart';

class NotFoundScreen extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: DataTemplate.notFoundPage(context),
        ),
      ),
    );
  }

}