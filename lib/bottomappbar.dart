import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'ajustes.dart';
import 'eventos.dart';
import 'cupones.dart';
import 'publicidad.dart';
import 'package:caminante_establecimiento_firebase2/establecimiento.dart';


class Bottomappbar extends StatelessWidget {
  const Bottomappbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60.0,
          color: HexColor('#FFFFFF'),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildIconButton(context, 'assets/perfil.png', const Eventos(),isSelected: false),
              _buildIconButton(context, 'assets/calendario.png', const Cupones(),isSelected: false),
              _buildIconButton(context, 'assets/trazado.png', const Establecimiento(), isSelected: true),
              _buildIconButton(context,'assets/publicidad.png', const Publicidad(), isSelected: false,),
              _buildIconButton(context, 'assets/ajustes.png', const Ajustes(),isSelected: false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(
      BuildContext context,
      String imagePath,
      Widget screen, {
        required bool isSelected,
      }) {
    return SizedBox(
      width: 60.0,
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
        icon: Image.asset(
          imagePath,
          width: 35.0,
          color: isSelected ? HexColor('f500f5') : null, // Color diferente si está seleccionado
        ),
      ),
    );
  }
}
