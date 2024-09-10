import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Asegúrate de importar esta línea
import 'package:caminante_establecimiento_firebase2/mapa_seleccion.dart';

class RegistroEntidad6 extends StatefulWidget {
  final Function(String) onMunicipioChanged;
  final Function(String) onDireccionChanged;
  final Function(LatLng?) onUbicacionChanged;

  const RegistroEntidad6({
    Key? key,
    required this.onMunicipioChanged,
    required this.onDireccionChanged,
    required this.onUbicacionChanged,
  }) : super(key: key);

  @override
  _RegistroEntidad6State createState() => _RegistroEntidad6State();
}

class _RegistroEntidad6State extends State<RegistroEntidad6> {
  LatLng? _ubicacionSeleccionada;
  String? _direccionSeleccionada; // Nueva variable para la dirección

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            _buildProgressBar(),
            const SizedBox(height: 20),
            _buildContentContainer(context),
            const SizedBox(height: 20),
            _buildLocationInfo(), // Mostrar la ubicación seleccionada
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Stack(
            children: [
              LinearProgressIndicator(
                value: 0.8,
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(HexColor('#ff0080')),
                minHeight: 46,
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      '80%',
                      style: GoogleFonts.montserrat(
                        color: HexColor('#ff0080'),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ubicación',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              color: HexColor('#ff0080'),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildTextField('Municipio', widget.onMunicipioChanged),
          const SizedBox(height: 20),
          _buildTextField('Dirección de la entidad', widget.onDireccionChanged),
          const SizedBox(height: 20),
          _buildMapButton(context),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, Function(String) onChangedCallback) {
    return TextField(
      onChanged: onChangedCallback,
      style: TextStyle(color: Colors.grey[800]),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.montserrat(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.pink),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.pink, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }

  Widget _buildMapButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          LatLng? result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MapaSeleccion()),
          );
          if (result != null) {
            setState(() {
              _ubicacionSeleccionada = result;
              _direccionSeleccionada = "Lat: ${result.latitude}, Long: ${result.longitude}";
            });
            widget.onUbicacionChanged(result); // Callback para pasar la ubicación seleccionada
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Ubicación seleccionada: $_direccionSeleccionada')),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: HexColor('#ff0080'),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          'Ubícate en el mapa',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  // Widget para mostrar la ubicación seleccionada
  Widget _buildLocationInfo() {
    if (_ubicacionSeleccionada != null) {
      return Text(
        'Coordenadas seleccionadas: $_direccionSeleccionada',
        style: GoogleFonts.montserrat(
          fontSize: 16,
          color: HexColor('#ff0080'),
          fontWeight: FontWeight.w600,
        ),
      );
    }
    return const SizedBox.shrink(); // Devolvemos un widget vacío si no hay ubicación seleccionada
  }
}
