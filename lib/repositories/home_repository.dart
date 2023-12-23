import 'dart:convert';
 import 'package:http/http.dart' as http;
import '../models/employee_model.dart';

class HomeRepository {


  Future<Employee> getEmployeeListData() async {

    try {
      final response = await http.get(
        Uri.parse('https://dummy.restapiexample.com/api/v1/employees'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        Employee employee = Employee.fromJson(data);
        return employee;
      } else {
        throw Exception('Failed to load employee');
      }
    } catch (exception) {
      rethrow;
    }
  }

}
