import 'package:flutter/material.dart';

import 'package:country_search_app/models/country.dart';
import 'package:country_search_app/services/country_service.dart';
import 'package:flutter_svg/svg.dart';

class CountrySearchDelegate extends SearchDelegate<Country> {

  @override
  final String searchFieldLabel;
  final List<Country> historial;

  CountrySearchDelegate(this.searchFieldLabel, this.historial);
  

  @override
  List<Widget> buildActions(BuildContext context) {
      return [
        IconButton(
          icon: Icon( Icons.clear ), 
          onPressed: () => this.query = ''
        )
      ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon( Icons.arrow_back_ios ),
      onPressed: () => this.close(context, null )
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    if ( query.trim().length == 0 ) {
      return Text('no hay valor en el query');
    }


    final countryService = new CountryService();
    // query!
    return FutureBuilder(
      future: countryService.getCountryByName( query ),
      builder: ( _ , AsyncSnapshot snapshot) {
        
        if ( snapshot.hasError ) {
          return ListTile( title: Text('No hay nada con ese término') );
        }

        if ( snapshot.hasData ) {
          // crear la lista
          return _showCountries( snapshot.data );
        } else {
          // Loading
          return Center(child: CircularProgressIndicator( strokeWidth: 4 ));
        }
      },
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _showCountries( this.historial );
  }

  Widget _showCountries( List<Country> countries ) {

    return ListView.builder(
      itemCount: countries.length,
      itemBuilder: ( context , i) {

        final pais = countries[i];

        return ListTile(
          leading: (pais.flag != null ) ? SvgPicture.network( pais.flag, width: 45 ) : '',
          title: Text( pais.name ),
          subtitle: Text( pais.capital ),
          trailing: Text( pais.alpha3Code ),
          onTap: () {
            // print( pais );
            this.close(context, pais);
          },
        );

      },
    );

  }

}

