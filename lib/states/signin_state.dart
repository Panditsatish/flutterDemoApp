import 'package:equatable/equatable.dart';


abstract class SignInState extends Equatable {
  final bool isLoading;
  SignInState({required this.isLoading, });
  @override
  List<Object?> get props => [isLoading];
}


class SignInInitial extends SignInState {
  SignInInitial() : super(isLoading: false);
}


class SignInLoadingState extends SignInState {
  bool isLoading;
  SignInLoadingState(this.isLoading) : super( isLoading: isLoading);
}

class SignInPassVisibilityState extends SignInState {
  bool isPassVisible;
  SignInPassVisibilityState(this.isPassVisible) : super( isLoading: false,);
  @override
  List<Object?> get props => [isPassVisible];
}
class SignInEmailValidationState extends SignInState {
  bool isEmailValid;
  SignInEmailValidationState(this.isEmailValid) : super( isLoading: false,);
  @override
  List<Object?> get props => [isEmailValid];
}

class SignInPasswordValidState extends SignInState {
  bool isPassValid;
  SignInPasswordValidState(this.isPassValid) : super( isLoading: false,);
  @override
  List<Object?> get props => [isPassValid];
}

class SignInSuccessState extends SignInState{

  SignInSuccessState() : super(isLoading: false);
  @override
  List<Object?> get props => [];
}

class SignInErrorState extends SignInState{
  final String errorMessage;
  SignInErrorState(this.errorMessage) : super(isLoading: false);
  @override
  List<Object?> get props => [errorMessage];
}
