import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:caminante_establecimiento_firebase2/Registro/registro entidad/registro_entiedad_1.dart'; // pantalla selector de registro
import 'package:caminante_establecimiento_firebase2/Registro/registro establecimiento/registro_establecimiento_1.dart'; // pantalla selector de registro


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/fondoregistrohd.png',
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Text(
              'Seleccione el tipo de registro',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 40, // Ancho del botón menos 20px de margen a cada lado
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegistroEntidad1()),
                      ); // Navega a la pantalla de registro de entidad
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      backgroundColor: Colors.white, // Fondo blanco para resaltar el texto de color
                    ),
                    child: Text(
                      'Registro Entidad',
                      style: GoogleFonts.montserrat(
                        fontSize: 16.0,
                        color: HexColor('#ff0080'), // Texto de color #ff0080
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Espacio entre botones
                SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegistroEstablecimiento1()),
                      ); // Navega a la pantalla de registro de establecimiento
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      backgroundColor: Colors.white, // Fondo blanco para resaltar el texto de color
                    ),
                    child: Text(
                      'Registro Establecimiento',
                      style: GoogleFonts.montserrat(
                        fontSize: 16.0,
                        color: HexColor('#ff0080'), // Texto de color #ff0080
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Cierra la pantalla y regresa a la anterior
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      backgroundColor: Colors.red, // Fondo rojo para el botón de cancelar
                    ),
                    child: Text(
                      'Cancelar',
                      style: GoogleFonts.montserrat(
                        fontSize: 16.0,
                        color: Colors.white, // Texto blanco
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}