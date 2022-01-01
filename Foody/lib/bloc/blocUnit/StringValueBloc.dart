import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody/bloc/state/StringValueState.dart';


class StringValueBloc extends Cubit<StringValueState>{

  StringValueBloc() : super(StringValueState('no'));

  void changeValue(String value) => emit(StringValueState(value));

}