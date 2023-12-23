import 'package:flutter_bloc/flutter_bloc.dart';

import '../states/signin_state.dart';



class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  void  onLoginButtonPress() async{
    try{
        emit(SignInSuccessState());

    } catch(e){
      emit(SignInLoadingState(false));
      emit(SignInErrorState(e.toString()));
    }
  }

  void onEmailValidate(String email){
    final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    if(emailValid){
      emit(SignInEmailValidationState(true));
    }else{
      emit(SignInEmailValidationState(false));
    }
  }

  void onPasswordValidate(String password){
    if(password.trim().isNotEmpty && password.length > 5){
      emit(SignInPasswordValidState(true));
    }else{
      emit(SignInPasswordValidState(false));
    }
  }

  void onPasswordVisibility(bool isHidden){
    if(isHidden){
      emit(SignInPassVisibilityState(false));
    }else{
      emit(SignInPassVisibilityState(true));

    }
  }

}
