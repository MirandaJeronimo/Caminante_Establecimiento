import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_color/flutter_color.dart'; // Importamos la librería para manejar colores HEX

class RegistroEntidad3 extends StatelessWidget {
  final Function(String) onNombreEntidadChanged;
  final Function(String) onNaturalezaEntidadChanged;

  const RegistroEntidad3({
    Key? key,
    required this.onNombreEntidadChanged,
    required this.onNaturalezaEntidadChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Fondo transparente
      body: SingleChildScrollView( // Añadimos el scroll para evitar desbordamiento
        padding: const EdgeInsets.all(16.0), // Añadir padding a los bordes
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20), // Reducimos el espacio superior
            _buildProgressBar(), // Barra de progreso
            const SizedBox(height: 20), // Reducimos el espacio después de la barra de progreso
            _buildContentContainer(context), // Container blanco con los elementos dentro
            const SizedBox(height: 60), // Aumentamos el espacio inferior
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Container(
      height: 50, // Aumentamos el tamaño de la barra (antes 30)
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
                value: 0.2, // 20% de progreso
                backgroundColor: Colors.white, // Fondo interno blanco
                valueColor: AlwaysStoppedAnimation<Color>(HexColor('#ff0080')), // Color de la barra de progreso
                minHeight: 46, // Hacemos la barra más alta (antes 26)
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerRight, // Coloca el texto a la derecha
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      '20%',
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
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30), // Aumentamos el padding inferior a 60
      decoration: BoxDecoration(
        color: Colors.white, // Fondo blanco
        borderRadius: BorderRadius.circular(20), // Bordes redondeados
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Datos de la entidad',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              color: HexColor('#ff0080'), // Color del título 'Datos de la entidad'
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildNameField(), // Campo de "Nombre de la entidad"
          const SizedBox(height: 20),
          Text(
            'Naturaleza de la entidad',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              color: HexColor('#ff0080'), // Color del título 'Naturaleza de la entidad'
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildNatureField(), // Campo de "Naturaleza de la entidad"
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return TextField(
      onChanged: onNombreEntidadChanged, // Callback para actualizar el nombre de la entidad
      style: TextStyle(
        color: Colors.grey[800], // Cambia el color del texto ingresado a gris oscuro
      ),
      decoration: InputDecoration(
        labelText: 'Nombre de la entidad',
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

  Widget _buildNatureField() {
    return TextField(
      onChanged: onNaturalezaEntidadChanged, // Callback para actualizar la naturaleza de la entidad
      maxLines: 5, // Para que sea un campo más grande
      style: TextStyle(
        color: Colors.grey[800], // Cambia el color del texto ingresado a gris oscuro
      ),
      decoration: InputDecoration(
        labelText: 'Naturaleza de la entidad',
        labelStyle: GoogleFonts.montserrat(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.pink),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.pink, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
    );
  }
}
