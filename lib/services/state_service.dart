import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart'as http;
import 'package:trackerapp/services/utilities/app_url.dart';
import '../models/WorldStateModel.dart';


class StateWorld{

  Future<WorldStateModel> fetchDataFromApi()async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.WorldStateApi));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return WorldStateModel.fromJson(data);
      } else {
        throw Exception('error');
      }
    } on SocketException {
      print('Error: Failed to connect to the server');
      throw Exception('Failed to connect to the server');
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load data');
    }
  }

  Future<List<dynamic>> countriesListApi()async{
    var data;
    final  response = await http.get(Uri.parse(ApiUrl.CountriesList));
    if(response.statusCode == 200){
       data = jsonDecode(response.body);
      return data;
    }else{
      throw Exception('error');
    }
  }
}