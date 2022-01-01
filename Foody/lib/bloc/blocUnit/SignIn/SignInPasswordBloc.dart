import 'package:bloc/bloc.dart';
import 'package:foody/bloc/state/SignIn/SignInPasswordState.dart';

class SignInPasswordBloc extends Cubit<SignInPasswordState>{

  SignInPasswordBloc() : super(SignInPasswordState(false));

  void update(newState) => emit(SignInPasswordState(newState));

}