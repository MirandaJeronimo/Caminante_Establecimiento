import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'ajustes.dart';
import 'eventos.dart';
import 'cupones.dart';
import 'publicidad.dart';

class Establecimiento extends StatefulWidget {
  const Establecimiento({super.key});

  @override
  _EstablecimientoState createState() => _EstablecimientoState();
}

class _EstablecimientoState extends State<Establecimiento> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Datos de la entidad que se mostrarán
  String _nombreEntidad = '';
  String _paginaWeb = '';
  String _correoInstitucional = '';
  String _horarioAtencion = '';
  String _ubicacion = '';
  String _descripcion = '';

  // Método para obtener los datos de la entidad
  Future<void> _obtenerDatosEntidad() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot entidadSnapshot = await _firestore
            .collection('entidades')
            .doc(user.uid)
            .get();

        if (entidadSnapshot.exists) {
          print('Datos recuperados: ${entidadSnapshot.data()}');

          setState(() {
            _nombreEntidad = entidadSnapshot['nombreEntidad'] ?? 'Sin nombre';
            _paginaWeb = entidadSnapshot['paginaOficial'] ?? 'Sin página web';
            _correoInstitucional = entidadSnapshot['correoInstitucional'] ?? 'Sin correo';
            _ubicacion = entidadSnapshot['ubicacion'] ?? 'Ubicación no disponible';
            _descripcion = entidadSnapshot['naturalezaEntidad'] ?? 'Sin descripción';

            // Logs para verificar
            print('Ubicación: $_ubicacion');
            print('Descripción: $_descripcion');
          });
        } else {
          print('Documento no existe');
        }
      } catch (e) {
        print('Error al obtener los datos de la entidad: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _obtenerDatosEntidad(); // Cargar datos al iniciar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _obtenerDatosEntidad,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Banner Superior
            Container(
              color: HexColor('#ff0080'),
              padding: const EdgeInsets.all(8),
              child: Text(
                'Debes llenar todos los campos de registro para acceder todas las herramientas de la app.',
                style: GoogleFonts.montserrat(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Imagen Principal y Botones
            Container(
              height: 150,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Image.asset(
                      'assets/fondo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _buildCircularButton(Icons.image_outlined, '#ff0080'),
                          _buildCircularButton(Icons.video_collection_outlined, '#ff0080'),
                          _buildCircularButton(Icons.camera_alt_outlined, '#ff0080'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Textos y botón de edición
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Ficha de la entidad',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: HexColor('#ff0080'),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _nombreEntidad, // Mostrar nombre de la entidad
                          style: GoogleFonts.montserrat(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#ff0080'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildCircularButton(Icons.edit_outlined, '#ff0080'),
                ],
              ),
            ),

            // Línea Divisoria
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),

            // Nueva sección con la información detallada
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildInfoRow("Página web", _paginaWeb),
                  Divider(color: Colors.grey, thickness: 1),
                  _buildInfoRow("Correo institucional", _correoInstitucional),
                  Divider(color: Colors.grey, thickness: 1),
                  _buildInfoRow("Ubicación", _ubicacion),
                  Divider(color: Colors.grey, thickness: 1),
                  _buildInfoRow("Descripción", _descripcion),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 4.0,
        child: BottomAppBar(
          color: Colors.white,
          child: Container(
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildIconButton(context, 'assets/eventos.png', const Eventos(), isSelected: false),
                _buildIconButton(context, 'assets/cupones.png', const Cupones(), isSelected: false),
                _buildIconButton(context, 'assets/trazado.png', const Establecimiento(), isSelected: true),
                _buildIconButton(context, 'assets/publicidad.png', const Publicidad(), isSelected: false),
                _buildIconButton(context, 'assets/ajustes.png', const Ajustes(), isSelected: false),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget para los botones circulares
  Widget _buildCircularButton(IconData icon, String colorHex) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(25),
      ),
      child: IconButton(
        icon: Icon(icon, color: HexColor(colorHex)),
        onPressed: () {
          // Acción al presionar el botón
        },
      ),
    );
  }

  // Widget para los iconos en la BottomAppBar
  Widget _buildIconButton(
      BuildContext context,
      dynamic icon,
      Widget screen, {
        required bool isSelected,
        String? iconColor,
      }) {
    return SizedBox(
      width: 60.0,
      child: IconButton(
        onPressed: () {
          if (isSelected) {
            return;
          }
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        icon: icon is String
            ? Image.asset(
          icon,
          width: 30.0,
          color: isSelected ? HexColor('#f500f5') : null,
        )
            : Icon(
          icon,
          color: isSelected ? HexColor(iconColor ?? '#f500f5') : null,
        ),
      ),
    );
  }

  // Método para construir una fila de información
  Widget _buildInfoRow(String title, String content, {bool showButton = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600], // Color del título (puedes cambiar si lo prefieres)
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                content,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Colors.black87, // Cambia el color a negro para que sea visible
                ),
              ),
            ],
          ),
        ),
        if (showButton)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: HexColor('#ff0080'),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Text(
              "Abierto",
              style: GoogleFonts.montserrat(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }
}
