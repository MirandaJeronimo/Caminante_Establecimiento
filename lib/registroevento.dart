import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:caminante_establecimiento_firebase2/pasoregistroeventos/step1_color_selection.dart';
import 'package:caminante_establecimiento_firebase2/pasoregistroeventos/step2_duration.dart';
import 'package:caminante_establecimiento_firebase2/pasoregistroeventos/step3_details.dart';
import 'package:caminante_establecimiento_firebase2/pasoregistroeventos/step4_location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistroEvento extends StatefulWidget {
  const RegistroEvento({super.key});

  @override
  _RegistroEventoState createState() => _RegistroEventoState();
}

class _RegistroEventoState extends State<RegistroEvento> {
  final PageController _pageController = PageController();
  Color selectedColor = Colors.white; // Color inicial
  int colorCode = 0; // Código del color inicial (por defecto, 0)

  // Variables para almacenar datos de cada paso
  DateTime? startDate;
  TimeOfDay? startTime;
  DateTime? endDate;
  TimeOfDay? endTime;
  String eventName = '';
  String eventDescription = '';
  bool isFreeEntry = false;
  String? eventPrice;
  String eventLocation = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {}); // Esto permite que el botón se actualice según la página
                },
                children: [
                  Step1ColorSelection(
                    selectedColor: selectedColor,
                    onColorSelected: (color) {
                      setState(() {
                        selectedColor = color;
                        // Asignar el código del color basado en el color seleccionado
                        if (color == Colors.pink) {
                          colorCode = 1;
                        } else if (color == Colors.blue) {
                          colorCode = 2;
                        } else if (color == Colors.yellow) {
                          colorCode = 3;
                        } else if (color == Colors.purple) {
                          colorCode = 4;
                        } else if (color == Colors.grey) {
                          colorCode = 5;
                        } else {
                          colorCode = 0; // Código por defecto si no coincide con ninguno
                        }
                      });
                    },
                  ),
                  Step2Duration(
                    startDate: startDate,
                    startTime: startTime,
                    endDate: endDate,
                    endTime: endTime,
                    onDateTimeSelected: (start, startT, end, endT) {
                      setState(() {
                        startDate = start;
                        startTime = startT;
                        endDate = end;
                        endTime = endT;
                      });
                    },
                  ),
                  Step3Details(
                    eventName: eventName,
                    eventDescription: eventDescription,
                    isFreeEntry: isFreeEntry,
                    eventPrice: eventPrice,
                    onDetailsEntered: (name, description, freeEntry, price) {
                      setState(() {
                        eventName = name;
                        eventDescription = description;
                        isFreeEntry = freeEntry;
                        eventPrice = price;
                      });
                    },
                  ),
                  Step4Location(
                    eventLocation: eventLocation,
                    onLocationEntered: (location) {
                      setState(() {
                        eventLocation = location;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 4, // Actualizar según el número de pasos
                  effect: WormEffect(
                    activeDotColor: Colors.pink,
                    dotColor: Colors.grey,
                    dotHeight: 8.0,
                    dotWidth: 8.0,
                    spacing: 16.0,
                  ),
                ),
              ),
            ),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey, size: 20),
          onPressed: () {
            if (_pageController.page == 0) {
              Navigator.of(context).pop();
            } else {
              _pageController.previousPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
        ),
        Text(
          'Registro de Evento',
          style: GoogleFonts.montserrat(
            color: Colors.grey,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_pageController.hasClients) {
                      if (_pageController.page! < 3) {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        _saveEvent(); // Guardar el evento cuando esté en la última página
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _pageController.hasClients && _pageController.page == 3 && eventLocation.isEmpty
                        ? Colors.grey
                        : Colors.pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                  ),
                  child: Text(
                    _pageController.hasClients && _pageController.page == 3
                        ? 'Guardar'
                        : 'Siguiente',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.pink),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                  ),
                  child: Text(
                    'Cancelar',
                    style: GoogleFonts.montserrat(
                      color: Colors.pink,
                      fontSize: 14.0,
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

  void _saveEvent() {
    if (eventLocation.isNotEmpty) {
      FirebaseFirestore.instance.collection('eventos').add({
        'nombre': eventName,
        'descripcion': eventDescription ?? 'Sin descripción',
        'fechaInicio': startDate ?? 'Fecha no especificada',
        'horaInicio': startTime?.format(context) ?? 'Hora no especificada',
        'fechaFin': endDate,
        'horaFin': endTime?.format(context) ?? '',
        'ubicacion': eventLocation,
        'entradaLibre': isFreeEntry,
        'precio': eventPrice,
        'color': selectedColor.value,
        'color2': colorCode, // El código de color, si se está usando
      }).then((value) {
        print("Evento guardado con éxito en Firestore!");
        Navigator.of(context).pop(); // Volver a la pantalla anterior
      }).catchError((error) {
        print("Error al guardar el evento: $error");
      });
    }
  }
}
