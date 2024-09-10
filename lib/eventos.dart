import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'ajustes.dart';
import 'cupones.dart';
import 'publicidad.dart';
import 'package:caminante_establecimiento_firebase2/establecimiento.dart';
import 'registroevento.dart';
import 'package:caminante_establecimiento_firebase2/pasoregistroeventos/detalle_evento.dart';

// Función para obtener el color basado en el código
Color getColorFromCode(int colorCode) {
  switch (colorCode) {
    case 1:
      return Colors.pink;
    case 2:
      return Colors.blue;
    case 3:
      return Colors.yellow;
    case 4:
      return Colors.purple;
    case 5:
      return Colors.grey;
    default:
      return Colors.black; // Negro por defecto si no hay código de color
  }
}
final List<String> mesesAbreviados = [
  'ENE', 'FEB', 'MAR', 'ABR', 'MAY', 'JUN',
  'JUL', 'AGO', 'SEP', 'OCT', 'NOV', 'DIC'
];

class Eventos extends StatefulWidget {
  const Eventos({super.key});

  @override
  _EventosState createState() => _EventosState();
}

class _EventosState extends State<Eventos> {
  List<Map<String, dynamic>> eventos = [];
  String? selectedMonth;

  final List<String> months = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre',
  ];

  @override
  void initState() {
    super.initState();
    _fetchEventosFromFirebase();
  }

  Future<void> _fetchEventosFromFirebase() async {
    final snapshot = await FirebaseFirestore.instance.collection('eventos').get();
    final eventosList = snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id; // Agregar el ID del documento al objeto de datos
      return data;
    }).toList();

    setState(() {
      eventos = List<Map<String, dynamic>>.from(eventosList);
    });
  }

  void _showAgregarEventoDialog() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegistroEvento()),
    ).then((result) {
      if (result != null && result is Map<String, dynamic>) {
        setState(() {
          eventos.add(result); // Añadimos el evento a la lista
        });
        FirebaseFirestore.instance.collection('eventos').add(result); // Guardar en Firebase
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HexColor('#8f3a7c'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Eventos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 16.0),
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 30.0,
                  child: ElevatedButton(
                    onPressed: _showAgregarEventoDialog,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Agregar nuevo evento',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Icon(
                          Icons.add,
                          color: Colors.grey,
                          size: 20.0,
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90.0),
              child: Container(
                height: 1.0,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: Text(
                  'Eventos programados',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90.0),
              child: Container(
                height: 1.0,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: DropdownButton<String>(
                  value: selectedMonth,
                  icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                  iconSize: 24,
                  dropdownColor: Colors.white,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedMonth = newValue;
                    });
                  },
                  selectedItemBuilder: (BuildContext context) {
                    return months.map<Widget>((String value) {
                      return Text(
                        value,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      );
                    }).toList();
                  },
                  items: months.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: GoogleFonts.montserrat(
                          color: HexColor('#ff0080'),
                          fontSize: 16,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: eventos.length,
                itemBuilder: (context, index) {
                  final evento = eventos[index];
                  final int colorCode = evento['color2'] ?? 0; // Asignar 0 si color2 es null
                  final DateTime fechaInicio = (evento['fechaInicio'] as Timestamp).toDate();
                  final String dia = fechaInicio.day.toString().padLeft(2, '0');
                  final String mes = mesesAbreviados[fechaInicio.month - 1]; // Inicial del mes

                  return Container(
                    margin: EdgeInsets.only(bottom: 12.0),
                    decoration: BoxDecoration(
                      color: getColorFromCode(colorCode),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 4),
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Colors.white24, // Fondo para el día y mes
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Text(
                            '$dia\n$mes', // Mostrar día y inicial del mes
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        evento['nombre'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0, // Tamaño de fuente aumentado
                          fontWeight: FontWeight.bold, // Texto en negrita
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '🕒 ${evento['horaInicio']} - ${evento['horaFin']}',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            evento['entradaLibre'] ? 'Entrada libre' : 'Precio: ${evento['precio'] ?? 'No especificado'}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      onTap: () {
                        // Navega a la pantalla de detalles del evento con el evento seleccionado
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetalleEvento(evento: evento),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),


          ],
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 4.0,
        child: BottomAppBar(
          color: Colors.white,
          child: Container(
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildIconButton(context, 'assets/eventos.png', const Eventos(), isSelected: true),
                _buildIconButton(context, 'assets/cupones.png', const Cupones(), isSelected: false),
                _buildIconButton(context, 'assets/trazado.png', const Establecimiento(), isSelected: false),
                _buildIconButton(context, 'assets/publicidad.png', const Publicidad(), isSelected: false),
                _buildIconButton(context, 'assets/ajustes.png', const Ajustes(), isSelected: false),
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
