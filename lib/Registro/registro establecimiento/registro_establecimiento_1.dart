import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_color/flutter_color.dart';

class RegistroEstablecimiento1 extends StatelessWidget {
  const RegistroEstablecimiento1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/fondoregistrohd.png', // Fondo de pantalla
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 40, // Ajusta la posición del botón hacia abajo si es necesario
            left: 16, // Margen izquierdo para el botón
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white, // Color blanco para el ícono de regresar
              iconSize: 30,
              onPressed: () {
                Navigator.of(context).pop(); // Regresa a la pantalla anterior
              },
            ),
          ),
          Center(
            child: Text(
              'Pantalla de Registro Establecimiento',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
