import 'package:bloc/bloc.dart';
import 'package:foody/bloc/state/SignIn/SignInCheckboxPrivcyState.dart';

class SignInCheckboxPrivcyBloc extends Cubit<SignInCheckboxPrivcyState>{

  SignInCheckboxPrivcyBloc() : super(SignInCheckboxPrivcyState(false));

  void update(newState) => emit(SignInCheckboxPrivcyState(newState));

}