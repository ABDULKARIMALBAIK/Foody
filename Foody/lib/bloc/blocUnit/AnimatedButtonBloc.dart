import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody/bloc/state/AnimatedButtonState.dart';

class AnimatedButtonBloc extends Cubit<AnimatedButtonState>{

  AnimatedButtonBloc() : super(AnimatedButtonState(false));

  void update(newState) => emit(AnimatedButtonState(newState));
}