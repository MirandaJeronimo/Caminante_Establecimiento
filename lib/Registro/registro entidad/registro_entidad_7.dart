import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_color/flutter_color.dart';

class RegistroEntidad7 extends StatefulWidget {
  final String nombreEntidad;
  final String naturalezaEntidad;
  final String categoria;
  final String subcategoria;
  final String ubicacion;
  final String paginaOficial;  // Añadir este nuevo campo
  final String correoInstitucional;  // Añadir este nuevo campo

  const RegistroEntidad7({
    Key? key,
    required this.nombreEntidad,
    required this.naturalezaEntidad,
    required this.categoria,
    required this.subcategoria,
    required this.ubicacion,
    required this.paginaOficial,
    required this.correoInstitucional,
  }) : super(key: key);

  @override
  _RegistroEntidad7State createState() => _RegistroEntidad7State();
}

class _RegistroEntidad7State extends State<RegistroEntidad7> {
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
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  // Barra de progreso al 100%
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
                value: 1.0,
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
                      '100%',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
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
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 60),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Confirmación de los datos',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              color: HexColor('#ff0080'),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildConfirmationText('Nombre de la entidad', widget.nombreEntidad),
          const SizedBox(height: 20),
          _buildConfirmationText('Naturaleza de la entidad', widget.naturalezaEntidad),
          const SizedBox(height: 20),
          _buildConfirmationText('Categoría', widget.categoria),
          const SizedBox(height: 20),
          _buildConfirmationText('Subcategoría', widget.subcategoria),
          const SizedBox(height: 20),
          _buildConfirmationText('Ubicación', widget.ubicacion),
          const SizedBox(height: 20),
          _buildConfirmationText('Página oficial', widget.paginaOficial),
          const SizedBox(height: 20),
          _buildConfirmationText('Correo institucional', widget.correoInstitucional),
        ],
      ),
    );
  }

  Widget _buildConfirmationText(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: HexColor('#ff0080'),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }
}
