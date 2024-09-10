import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_color/flutter_color.dart'; // Importamos la librería para manejar colores HEX

class RegistroEntidad4 extends StatefulWidget {
  final Function(String) onCategoriaChanged;
  final Function(String) onSubcategoria1Changed;
  final Function(String?) onSubcategoria2Changed;

  const RegistroEntidad4({
    Key? key,
    required this.onCategoriaChanged,
    required this.onSubcategoria1Changed,
    required this.onSubcategoria2Changed,
  }) : super(key: key);

  @override
  _RegistroEntidad4State createState() => _RegistroEntidad4State();
}

class _RegistroEntidad4State extends State<RegistroEntidad4> {
  String? _selectedCategory;
  String? _selectedSubcategory1;
  String? _selectedSubcategory2;

  // Mapa de categorías con sus subcategorías 1
  final Map<String, List<String>> subcategories1 = {
    'Comida': ['Típicas', 'De mar', 'Postres', 'Helados', 'Típicos', 'Internacionales'],
    'Hospedaje': ['Hostales', 'Moteles', 'Hoteles'],
    'Rumba': ['Salsera', 'Electronic Dance Music', 'Vallenata', 'Rockera', 'Reggaetonera', 'Adultos +18', 'Discotecas'],
    'Parranda/Farra': ['Caseta', 'Estadero', 'Bares', 'Puntos Fríos'],
    'Pasar el rato': ['Parques', 'Lugares para pescar', 'Centros de recreación', 'Canchas de Futbol', 'Deportes'],
    'Compras': ['Centros comerciales', 'Supermercados'],
    'Servicios turísticos': ['Alquileres de vehículos', 'Casas de cambio', 'Centros de Atención al Turista'],
    'Zonas turísticas': ['Lugares para pasear', 'Sitios históricos', 'Paisajes y Accidentes Geográficos', 'Playas', 'Museos'],
    'Establecimientos Públicos': ['Fiscalía', 'Juzgados', 'Comisaría de familia', 'Defensoría', 'Migración', 'Alcaldía', 'Dependencias'],
    'Estaciones de Transportes': ['Terminal de Transportes', 'Aeropuertos', 'Puertos marítimos', 'Puertos fluviales', 'Estaciones de taxis', 'Estaciones de transporte particulares'],
    'Talleres': ['Automovilístico', 'Celular', 'Computadores', 'Tecnología', 'Electrodomésticos', 'Madera', 'Metales', 'Vidrio', 'Joyas'],
    'Cuidado personal': ['Peluquerías', 'Barberías', 'Cosméticos', 'Gimnasios', 'Spa'],
    'Emergencias': ['Hospitales']
  };

  // Subcategorías 2, disponibles para cualquier subcategoría 1 en Comida y Hospedaje
  final List<String> subcategories2Comida = [
    'China', 'Japonesa', 'Italiana', 'Nacionales', 'Rápidas', 'Local'
  ];

  final List<String> subcategories2Hospedaje = [
    'Grandes', 'Pequeños'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20), // Espacio superior
            _buildProgressBar(), // Barra de progreso
            const SizedBox(height: 20),
            _buildContentContainer(context), // Contenedor con campos
            const SizedBox(height: 60), // Espacio inferior
          ],
        ),
      ),
    );
  }

  // Nueva versión de la barra de progreso
  Widget _buildProgressBar() {
    return Container(
      height: 50, // Aumentamos el tamaño de la barra
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
                value: 0.4, // 40% de progreso (puedes cambiar el valor según el paso)
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(HexColor('#ff0080')), // Color de la barra de progreso
                minHeight: 46, // Hacemos la barra más alta
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerRight, // Coloca el texto a la derecha
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      '40%', // Porcentaje del progreso
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
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Datos de entidad',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              color: HexColor('#ff0080'),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildCategoryField(), // Campo de categoría
          const SizedBox(height: 20),
          if (_selectedCategory != null) _buildSubcategory1Field(), // Campo de subcategoría 1
          const SizedBox(height: 20),
          if (_selectedSubcategory1 != null &&
              (_selectedCategory == 'Comida' || _selectedCategory == 'Hospedaje'))
            _buildSubcategory2Field(), // Campo de subcategoría 2
        ],
      ),
    );
  }

  Widget _buildCategoryField() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Categoría',
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
        fillColor: Colors.white, // Fondo blanco para el DropdownButtonFormField
        filled: true, // Activamos el fondo blanco
      ),
      value: _selectedCategory,
      items: subcategories1.keys.map((String category) {
        return DropdownMenuItem<String>(
          value: category,
          child: Text(category, style: GoogleFonts.montserrat(color: HexColor('#ff0080'))), // Cambiamos el texto a Montserrat y color rosa
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _selectedCategory = newValue;
          _selectedSubcategory1 = null; // Reiniciamos subcategoría 1
          _selectedSubcategory2 = null; // Reiniciamos subcategoría 2
        });
        widget.onCategoriaChanged(newValue!); // Callback para pasar la categoría seleccionada
      },
      style: GoogleFonts.montserrat(color: HexColor('#ff0080')), // Letra Montserrat en el campo seleccionado
    );
  }

  Widget _buildSubcategory1Field() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Subcategoría 1',
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
        fillColor: Colors.white, // Fondo blanco para el DropdownButtonFormField
        filled: true, // Activamos el fondo blanco
      ),
      value: _selectedSubcategory1,
      items: subcategories1[_selectedCategory]!.map((String subcategory1) {
        return DropdownMenuItem<String>(
          value: subcategory1,
          child: Text(subcategory1, style: GoogleFonts.montserrat(color: HexColor('#ff0080'))), // Letra Montserrat y color rosa
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _selectedSubcategory1 = newValue;
          _selectedSubcategory2 = null; // Reiniciamos subcategoría 2 si cambia
        });
        widget.onSubcategoria1Changed(newValue!); // Callback para pasar la subcategoría 1 seleccionada
      },
      style: GoogleFonts.montserrat(color: HexColor('#ff0080')), // Letra Montserrat en el campo seleccionado
    );
  }

  Widget _buildSubcategory2Field() {
    List<String> subcategory2Options = [];

    if (_selectedCategory == 'Comida') {
      subcategory2Options = subcategories2Comida;
    } else if (_selectedCategory == 'Hospedaje') {
      subcategory2Options = subcategories2Hospedaje;
    }

    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Subcategoría 2',
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
        fillColor: Colors.white, // Fondo blanco para el DropdownButtonFormField
        filled: true, // Activamos el fondo blanco
      ),
      value: _selectedSubcategory2,
      items: subcategory2Options.map((String subcategory2) {
        return DropdownMenuItem<String>(
          value: subcategory2,
          child: Text(subcategory2, style: GoogleFonts.montserrat(color: HexColor('#ff0080'))), // Letra Montserrat y color rosa
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _selectedSubcategory2 = newValue;
        });
        widget.onSubcategoria2Changed(newValue); // Callback para pasar la subcategoría 2 seleccionada
      },
      style: GoogleFonts.montserrat(color: HexColor('#ff0080')), // Letra Montserrat en el campo seleccionado
    );
  }
}
