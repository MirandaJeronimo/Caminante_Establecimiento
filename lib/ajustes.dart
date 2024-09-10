import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'eventos.dart';
import 'cupones.dart';
import 'publicidad.dart';
import 'package:caminante_establecimiento_firebase2/establecimiento.dart';
import 'package:google_fonts/google_fonts.dart';

// Perfil
import 'package:caminante_establecimiento_firebase2/Ajuste/ajusteAdministrarAlmacenamiento.dart';
import 'package:caminante_establecimiento_firebase2/Ajuste/ajusteInformacionPersonalScreen.dart';
import 'package:caminante_establecimiento_firebase2/Ajuste/ajusteFotoPerfilScreen.dart';
// General
import 'package:caminante_establecimiento_firebase2/Ajuste/ajusteSolicitarInformacion.dart';
import 'package:caminante_establecimiento_firebase2/Ajuste/ajusteEliminarCuenta.dart';
// Almacenamiento
// Ayuda
import 'package:caminante_establecimiento_firebase2/Ajuste/ajusteCentroAyuda.dart';
import 'package:caminante_establecimiento_firebase2/Ajuste/ajusteInfoApp.dart';
import 'package:caminante_establecimiento_firebase2/Ajuste/ajusteContactanos.dart';
import 'package:caminante_establecimiento_firebase2/Ajuste/ajustePoliticasCondiciones.dart';
import 'package:caminante_establecimiento_firebase2/Ajuste/ajusteSuperIC.dart';
import 'package:caminante_establecimiento_firebase2/Ajuste/ajusteReglasConsumidor.dart';
import 'package:caminante_establecimiento_firebase2/Ajuste/ajusteNormasConvivenciaCiudadana.dart';

class Ajustes extends StatelessWidget {
  const Ajustes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#FFFFFF'),
      bottomNavigationBar: Material(
        elevation: 4.0, // Elevación para la sombra en la BottomAppBar
        child: BottomAppBar(
          color: Colors.white, // Fondo blanco para la BottomAppBar
          child: Container(
            height: 50.0, // Altura reducida para la BottomAppBar
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildIconButton(context, 'assets/eventos.png', const Eventos(), isSelected: false),
                _buildIconButton(context, 'assets/cupones.png', const Cupones(), isSelected: false),
                _buildIconButton(context, 'assets/trazado.png', const Establecimiento(), isSelected: false),
                _buildIconButton(context, 'assets/publicidad.png', const Publicidad(), isSelected: false),
                _buildIconButton(context, 'assets/ajustes.png', const Ajustes(), isSelected: true),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Alinea el texto a la izquierda
        children: [
          // Título "Ajustes"
          Container(
            padding: const EdgeInsets.fromLTRB(16.0, 40.0, 100.0, 0.0), // Padding: left 16, top 30, right 0, bottom 16
            color: Colors.white,
            child: Text(
              'Ajustes',
              style: GoogleFonts.montserrat(
                color: HexColor('#707070'),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Contenido de la página
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
              child: ListView(
                children: [
                  _buildSection(context, 'Perfil', ['Foto de Perfil', 'Información Personal']),
                  _buildSection(context, 'General', ['Solicitar información', 'Eliminar cuenta']),
                  _buildSection(context, 'Almacenamiento', ['Administrar Almacenamiento']),
                  _buildSection(context, 'Ayuda', ['Centro de ayuda', 'Información sobre la App', 'Contáctanos', 'Políticas y condiciones', 'Superintendencia y comercio', 'Reglas del consumidor', 'Normas de convivencia ciudadana']),
                  const SizedBox(height: 16.0),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor('#FF0080'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      onPressed: () {
                        // Agregar lógica para cerrar sesión
                        // Por ejemplo:
                        // Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: Text(
                        'Cerrar sesión',
                        style: GoogleFonts.montserrat(
                          color: HexColor('#ffffff'),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<String> options) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0), // Ajuste de espaciado
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.montserrat(
              color: HexColor('#FF0080'),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: options.map((option) {
                return Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0), // Ajuste de espaciado
                      dense: true, // Reduce el espacio entre los elementos del ListTile
                      title: Text(
                        option,
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                        ),
                      ),
                      onTap: () {
                        // Navegación a las pantallas correspondientes
                        switch (option) {
                          case 'Foto de Perfil':
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ajusteFotoPerfilScreen()));
                            break;
                          case 'Información Personal':
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ajusteInformacionPersonalScreen()));
                            break;
                          case 'Solicitar información':
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AjustesSolicitarInformacion()));
                            break;
                          case 'Eliminar cuenta':
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ajusteEliminarCuenta()));
                            break;
                          case 'Administrar Almacenamiento':
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ajusteAdministrarAlmacenamiento()));
                            break;
                          case 'Centro de ayuda':
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ajusteCentroAyuda()));
                            break;
                          case 'Información sobre la App':
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ajusteInfoApp()));
                            break;
                          case 'Contáctanos':
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ajusteContactanos()));
                            break;
                          case 'Políticas y condiciones':
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ajustePoliticasCondiciones()));
                            break;
                          case 'Superintendencia y comercio':
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ajusteSuperIC()));
                            break;
                          case 'Reglas del consumidor':
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ajusteReglasConsumidor()));
                            break;
                          case 'Normas de convivencia ciudadana':
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ajusteNormasConvivenciaCiudadana()));
                            break;
                          default:
                          // Handle other options if needed
                          // Agrega casos adicionales aquí si es necesario
                        }
                      },
                    ),
                    if (option != options.last) // Añade Divider entre elementos, excepto el último
                      Container(
                        width: 280, // Ancho de la línea de separación
                        height: 1,
                        color: HexColor('#c2c2c2'),
                      ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(
      BuildContext context,
      String iconPath,
      Widget screen, {
        required bool isSelected,
      }) {
    return SizedBox(
      width: 50.0,
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
        icon: Image.asset(
          iconPath,
          width: 30.0,
          color: isSelected ? HexColor('#f500f5') : null,
        ),
      ),
    );
  }
}
