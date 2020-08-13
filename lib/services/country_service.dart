import 'package:country_search_app/models/country.dart';
import 'package:dio/dio.dart';

class CountryService {

  final _dio = new Dio();

  Future getCountryByName( String name ) async {

    try {
      
      final url = 'https://restcountries.eu/rest/v2/name/$name';
      final resp = await _dio.get(url);

      final List<dynamic> countryList = resp.data;
      
      return countryList.map(
        (obj) => Country.fromJson(obj)
      ).toList();


    } catch (e) {
      
      print(e);
      return [];
    }

  }

}