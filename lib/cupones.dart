import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'ajustes.dart';
import 'eventos.dart';
import 'publicidad.dart';
import 'package:caminante_establecimiento_firebase2/establecimiento.dart';


class Cupones extends StatelessWidget {
  const Cupones({super.key});

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
                _buildIconButton(context, 'assets/cupones.png', const Cupones(),isSelected: true),
                _buildIconButton(context, 'assets/trazado.png', const Establecimiento(), isSelected: false),
                _buildIconButton(context,'assets/publicidad.png', const Publicidad(), isSelected: false,),
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
