import 'package:flutter/material.dart';

class DrawerModel{
  Color colorHover;
  Color colorTitleIcon;
  String title;
  IconData icon;
  VoidCallback press;

  DrawerModel(this.colorHover,this.colorTitleIcon, this.title, this.icon, this.press);
}