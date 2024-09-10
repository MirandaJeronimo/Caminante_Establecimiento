import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaSeleccion extends StatefulWidget {
  const MapaSeleccion({Key? key}) : super(key: key);

  @override
  _MapaSeleccionState createState() => _MapaSeleccionState();
}

class _MapaSeleccionState extends State<MapaSeleccion> {
  LatLng? _selectedLocation;
  late GoogleMapController _mapController;

  // Método para inicializar el mapa
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  // Método para seleccionar una ubicación en el mapa
  void _onMapTapped(LatLng location) {
    setState(() {
      _selectedLocation = location;
    });
  }

  // Mostrar el marcador de la ubicación seleccionada
  Set<Marker> _createMarkers() {
    if (_selectedLocation == null) {
      return {};
    }
    return {
      Marker(
        markerId: MarkerId('selectedLocation'),
        position: _selectedLocation!,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecciona la ubicación'),
        backgroundColor: Colors.pink,
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(10.3910, -75.4794), // Coordenadas de Cartagena
              zoom: 12.0,
            ),
            myLocationEnabled: true,
            onTap: _onMapTapped,
            markers: _createMarkers(),
          ),
          Align(
            alignment: Alignment.bottomCenter, // Alineamos al centro en la parte inferior
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20), // Añadimos un poco de espacio inferior
              child: FloatingActionButton(
                backgroundColor: Colors.pink,
                onPressed: () {
                  if (_selectedLocation != null) {
                    Navigator.pop(context, _selectedLocation);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Por favor selecciona una ubicación')),
                    );
                  }
                },
                child: const Icon(Icons.check),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
