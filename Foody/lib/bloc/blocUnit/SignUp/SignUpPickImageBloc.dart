// import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody/bloc/state/SignUp/SignUpPickImageState.dart';

class SignUpPickImageBloc extends Cubit<SignUpPickImageState> {

  SignUpPickImageBloc() : super(SignUpPickImageState(Uint8List(500) , false , 'no path'));

  void pickImage(Uint8List pickedImage , String pathFile) => emit(SignUpPickImageState(pickedImage , true , pathFile));

}