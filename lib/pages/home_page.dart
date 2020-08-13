import 'package:country_search_app/models/country.dart';
import 'package:country_search_app/search/country_search.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Country paisSeleccionado;
  List<Country> historial = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            if( paisSeleccionado != null )
              Text( paisSeleccionado.name ),

            MaterialButton(
              child: Text('Buscar', style: TextStyle( color: Colors.white) ),
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              color: Colors.blue,
              onPressed: () async {
                final pais = await showSearch(
                  context: context, 
                  delegate: CountrySearchDelegate('Buscar...', historial )
                );

                setState(() {
                  this.paisSeleccionado = pais;
                  this.historial.insert(0, pais);
                });
              }
            )

            

          ],
        )
     ),
   );
  }
}

