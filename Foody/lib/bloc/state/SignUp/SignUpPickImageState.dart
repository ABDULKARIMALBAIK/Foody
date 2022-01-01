// import 'dart:io';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AbstractSignUpPickImageState extends Equatable{
  Uint8List pickedImage;
  String pathFile;
  bool isPicked;
  AbstractSignUpPickImageState(this.pickedImage,this.isPicked,this.pathFile);
}

class SignUpPickImageState extends AbstractSignUpPickImageState{

  SignUpPickImageState(Uint8List pickedImage , bool isPicked , String pathFile) : super(pickedImage , isPicked , pathFile);

  @override
  // TODO: implement props
  List<Object?> get props => [pickedImage , isPicked , pathFile];
}