import 'package:equatable/equatable.dart';
import '../models/employee_model.dart';

abstract class HomeState extends Equatable {
  bool isLoading;
  Employee? employee;
  HomeState({required this.isLoading, this.employee});
  @override
  List<Object?> get props => [isLoading, employee, ];
}

class HomeInitial extends HomeState {
  HomeInitial() : super(isLoading:true,employee:null);
}

class HomeLoadingState extends HomeState {
  bool isLoading;
  HomeState oldState;
  HomeLoadingState(this.isLoading, this.oldState):super(isLoading:isLoading,employee:oldState.employee);
  @override
  List<Object?> get props => [];

}


class HomeFirstLoadedState extends HomeState {
  final Employee Home;
  HomeFirstLoadedState(this.Home):super(isLoading:false, employee: Home);
  @override
  List<Object?> get props => [Home];
}

class SearchEmployeeList extends HomeState {
  List<Data>? data;
  SearchEmployeeList(this.data):super(isLoading:false,);
  @override
  List<Object?> get props => [ data];
}
class SearchEmployeeAgeList extends HomeState {
  List<Data>? data;
  SearchEmployeeAgeList(this.data):super(isLoading:false,);
  @override
  List<Object?> get props => [ data];
}



class HomeErrorState extends HomeState {
  final String? msg;
  final HomeState oldState;
  HomeErrorState(this.msg, this.oldState):super(isLoading:false, employee:oldState.employee);
  @override
  List<Object?> get props => [msg];
}


