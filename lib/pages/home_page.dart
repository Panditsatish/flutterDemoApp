import 'package:demo_flutte/cubits/home_cubit.dart';
import 'package:demo_flutte/models/employee_model.dart';
import 'package:demo_flutte/states/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common_widgets/search_field.dart';
import '../utils/color_const.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String pageTitle = 'Home';
  String msg = '';
  HomeCubit homeCubit = HomeCubit();
  Employee? employee;
  Employee employee1 = Employee();
  List<Data>? _searchResult;
  List<Data>? employeeData = [];
  List<String> ageCategory = [
    "0",
    "21 - 30",
    "31 - 40",
    "41 - 50",
    "51 - 60",
    "61 - 70",
    "71 - 80",
    "81 - 90"
  ];
  String selectedAgeCategory = '0';
  @override
  void initState() {
    _searchResult?.clear();
    employeeData?.clear();
    employeeData?.sort((a, b) => (a.employeeName ?? '').compareTo(b.employeeName ??''));
    _searchResult?.sort((a, b) => (a.employeeName ?? '') .compareTo(b.employeeName ?? ''));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    employeeData?.sort((a, b) => (a.employeeName ?? '').compareTo(b.employeeName ?? ''));
    _searchResult?.sort((a, b) => (a.employeeName ?? '').compareTo(b.employeeName ?? ''));
    return SafeArea(
      child: BlocProvider(
        create: (context) => homeCubit,
        lazy: false,
        child: BlocConsumer<HomeCubit, HomeState>(
            listener: (BuildContext context, HomeState state) {
              if(state is HomeFirstLoadedState) {
                employee = state.employee;
                employeeData = state.employee?.data;
                employeeData?.sort((a, b) => (a.employeeName ?? '').compareTo(b.employeeName ?? ''));
                _searchResult?.sort((a, b) => (a.employeeName ?? '').compareTo(b.employeeName ?? ''));
              }else if(state is SearchEmployeeList){

                  _searchResult = state.data;

              }if(state is SearchEmployeeAgeList){
                _searchResult = state.data;

              }
              },
            builder: (BuildContext context, HomeState state) {

              employee = state.employee;

              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(pageTitle),
                ),
                body: GestureDetector(
                  onTap: (){
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: SizedBox(
                    height: size.height,
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20,),
                          SearchField(
                            onSubmit: (String value)async{
                              BlocProvider.of<HomeCubit>(context).searchMember(value, employeeData);
                            },
                            widget: ageFilterWidget(),
                          ),
                          SizedBox(
                        height: size.height * 0.01,
                      ),

                         Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                  children:
                                  [
                                    if((employeeData != null && employeeData?.length != 0 ) &&
                                        (_searchResult?.length != 0 &&_searchResult ==null) )
                                      ...employeeData!.map((e) {
                                        return  Card(
                                        color: Colors.white60,
                                        elevation: 2,child: ListTile(shape: RoundedRectangleBorder(
                                         borderRadius: BorderRadius.circular(5.0)),
                                         leading:const Icon(Icons.person),
                                         title: Text('${e.employeeName}'),
                                         subtitle: Text('${e.employeeAge}')),
                                        );
                                        },),

                                    if(employeeData == null || employeeData?.length == 0 )
                                      SizedBox(
                                        child: Padding(
                                          padding:  EdgeInsets.only(top: size.height/4),
                                          child: const CircularProgressIndicator(),
                                        ),
                                      ),

                                    if(_searchResult !=null)
                                      ..._searchResult!.map((e) =>  Card(
                                        color: Colors.white60,
                                        elevation: 2,child: ListTile(shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0)),
                                          leading:const Icon(Icons.person),
                                          title: Text('${e.employeeName}'),
                                          subtitle: Text('${e.employeeAge}')),
                                      ))
                                  ]
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              );
            }
            ),
      )
    );
  }

  Widget ageFilterWidget(){
    return   GestureDetector(

      child: PopupMenuButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
          color: ColorConstants.blueAccentColor,
          position: PopupMenuPosition.under,
          icon: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                selectedAgeCategory,
                style: const TextStyle(
                    color: Colors.white, fontSize: 10),
              ),
              const Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              ),
            ],
          ),
          itemBuilder: (context) {
            return ageCategory
                .map((e) => PopupMenuItem(
              value: e,
              onTap: (() {
                  selectedAgeCategory = e;
                  BlocProvider.of<HomeCubit>(context).searchEmployeeAge(
                      int.parse(e.split(' - ').first),
                      int.parse(e.split(' - ').last),
                      employeeData
                  );
              }),
              child: SizedBox(

                child: Text(
                  e,
                  maxLines: 1,
                  style:
                  const TextStyle(color: Colors.white),
                ),
              ),
            )
            ).toList();
          }),
    );
  }
}
