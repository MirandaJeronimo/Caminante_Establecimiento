import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_color/flutter_color.dart'; // Importamos la librería para manejar colores HEX

class RegistroEntidad5 extends StatelessWidget {
  final Function(String) onPaginaOficialChanged;
  final Function(String) onCorreoInstitucionalChanged;

  const RegistroEntidad5({
    Key? key,
    required this.onPaginaOficialChanged,
    required this.onCorreoInstitucionalChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Fondo transparente
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Añadir padding a los bordes
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20), // Espacio superior
            _buildProgressBar(), // Barra de progreso
            const SizedBox(height: 20), // Espacio después de la barra de progreso
            _buildContentContainer(context), // Contenedor blanco con los elementos dentro
            const SizedBox(height: 60), // Espacio inferior
          ],
        ),
      ),
    );
  }

  // Barra de progreso al 60%
  Widget _buildProgressBar() {
    return Container(
      height: 50, // Tamaño de la barra
      decoration: BoxDecoration(
        color: Colors.white, // Fondo blanco para la barra
        borderRadius: BorderRadius.circular(25), // Borde exterior redondeado
      ),
      child: Padding(
        padding: const EdgeInsets.all(2), // Espacio alrededor de la barra de progreso
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25), // Redondeamos la barra interna también
          child: Stack(
            children: [
              LinearProgressIndicator(
                value: 0.6, // 60% de progreso
                backgroundColor: Colors.white, // Fondo interno blanco
                valueColor: AlwaysStoppedAnimation<Color>(HexColor('#ff0080')), // Color de la barra de progreso
                minHeight: 46, // Hacemos la barra más alta
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerRight, // Coloca el texto a la derecha
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      '60%',
                      style: GoogleFonts.montserrat(
                        color: HexColor('#ff0080'), // Color del porcentaje de progreso
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
      width: double.infinity, // El contenedor toma todo el ancho disponible
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      decoration: BoxDecoration(
        color: Colors.white, // Fondo blanco
        borderRadius: BorderRadius.circular(20), // Bordes redondeados
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detalles de la entidad',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              color: HexColor('#ff0080'), // Color del título
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildTextField('Página oficial', onPaginaOficialChanged), // Campo para la página oficial
          const SizedBox(height: 20),
          _buildTextField('Correo institucional', onCorreoInstitucionalChanged), // Campo para el correo institucional
        ],
      ),
    );
  }

  // Función para generar los TextFields
  Widget _buildTextField(String label, Function(String) onChangedCallback) {
    return TextField(
      onChanged: onChangedCallback, // Callback para enviar el valor al padre
      style: TextStyle(color: Colors.grey[800]), // Cambia el color del texto ingresado a gris oscuro
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.montserrat(color: Colors.grey), // Estilo para el label
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
}
