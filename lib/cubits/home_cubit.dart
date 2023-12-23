import 'package:demo_flutte/models/employee_model.dart';
import 'package:demo_flutte/repositories/home_repository.dart';
import 'package:demo_flutte/states/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeCubit extends Cubit<HomeState> {

  HomeCubit() : super(HomeInitial()){
    loadInitialEmployeeData();
  }

  void loadInitialEmployeeData(){
    loadEmployeeData();
  }

  void loadEmployeeData() async {

    HomeRepository homeRepository = HomeRepository();
    try{
    Employee responseData = await  homeRepository.getEmployeeListData();
    if(responseData.status == 'success') {
        emit(HomeFirstLoadedState(responseData));
    } else {
      emit(HomeLoadingState(false, state));
      emit(HomeErrorState( responseData.message, state));
    }
  } catch(e){
      emit(HomeErrorState( "Please check internet connection", state));
  }}

  searchMember(String name,List<Data>? employeeData) {
    List<Data>? result = [];
      if(name.isNotEmpty) {

        final suggestion = employeeData?.where((employee) {
          final employeeName = employee.employeeName?.toLowerCase();
          final query = name.toLowerCase();
          return employeeName!.contains(query);
        }).toList();
        result = suggestion ;
      }else{
        result  = employeeData;
      }
      emit(SearchEmployeeList(result));
  }

  searchEmployeeAge(int startAge,int endAge,List<Data>? employeeData) {
    List<Data>? result = [];
    if(startAge > 19 && employeeData != null) {

      final suggestion = employeeData.where((employee) {
        final employeeAge = employee.employeeAge;
        final query = startAge;
        final query2 = endAge;
        return   query2 >= employeeAge! &&  employeeAge>= query;
      }).toList();

        result = suggestion ;
    }else{
      result  = employeeData;
    }
  emit(SearchEmployeeAgeList(result));
  }
}
