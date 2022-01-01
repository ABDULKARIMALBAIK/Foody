import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody/bloc/state/AnimatedSearchState.dart';

class AnimatedSearchBloc extends Cubit<AnimatedSearchState>{

  AnimatedSearchBloc() : super(AnimatedSearchState(false,false));

  void updateHover(bool hover) => emit(AnimatedSearchState(hover,state.toggle));
  void updateToggle(bool toggle) => emit(AnimatedSearchState(state.hover,toggle));
}