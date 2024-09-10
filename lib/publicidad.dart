import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'ajustes.dart';
import 'eventos.dart';
import 'cupones.dart';
import 'package:caminante_establecimiento_firebase2/establecimiento.dart';


class Publicidad extends StatelessWidget {
  const Publicidad({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Material(
        elevation: 4.0, // Elevación para la sombra en la BottomAppBar
        child: BottomAppBar(
          color: Colors.white, // Fondo blanco para la BottomAppBar
          child: Container(
            height: 50.0, // Altura reducida para la BottomAppBar
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildIconButton(context, 'assets/eventos.png', const Eventos(),isSelected: false),
                _buildIconButton(context, 'assets/cupones.png', const Cupones(),isSelected: false),
                _buildIconButton(context, 'assets/trazado.png', const Establecimiento(), isSelected: false),
                _buildIconButton(context,'assets/publicidad.png', const Publicidad(), isSelected: true,),
                _buildIconButton(context, 'assets/ajustes.png', const Ajustes(),isSelected: false),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildIconButton(
      BuildContext context,
      dynamic icon, // Aceptar tanto String como IconData
      Widget screen, {
        required bool isSelected,
        String? iconColor, // Color del icono
      }) {
    return SizedBox(
      width: 50.0, // Ajustar el tamaño del botón
      child: IconButton(
        onPressed: () {
          if (isSelected) {
            return; // Evitar navegar a la misma pantalla
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
          color: isSelected ? HexColor('#f500f5') : null, // Color diferente si está seleccionado
        )
            : Icon(
          icon,
          color: isSelected ? HexColor(iconColor ?? '#f500f5') : null,
        ),
      ),
    );
  }
}
