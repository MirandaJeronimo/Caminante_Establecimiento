import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'step1_color_selection.dart';
import 'step2_duration.dart';
import 'step3_details.dart';
import 'step4_location.dart';

class EditarEvento extends StatefulWidget {
  final Map<String, dynamic> evento;

  EditarEvento({required this.evento});

  @override
  _EditarEventoState createState() => _EditarEventoState();
}

class _EditarEventoState extends State<EditarEvento> {
  final PageController _pageController = PageController();

  late TextEditingController _nombreController;
  late TextEditingController _descripcionController;
  late TextEditingController _precioController;
  late TextEditingController _ubicacionController;

  late Color selectedColor;
  late int colorCode;
  late DateTime startDate;
  late TimeOfDay startTime;
  late DateTime endDate;
  late TimeOfDay endTime;
  late bool isFreeEntry;

  @override
  void initState() {
    super.initState();
    // Inicializar controladores y variables con los datos del evento
    _nombreController = TextEditingController(text: widget.evento['nombre']);
    _descripcionController = TextEditingController(text: widget.evento['descripcion']);
    _precioController = TextEditingController(text: widget.evento['precio']?.toString() ?? '');
    _ubicacionController = TextEditingController(text: widget.evento['ubicacion']);

    selectedColor = Color(widget.evento['color'] ?? 0xFFFFFFFF);
    colorCode = widget.evento['color2'] ?? 0;
    startDate = (widget.evento['fechaInicio'] as Timestamp).toDate();
    startTime = TimeOfDay.fromDateTime(startDate);
    endDate = (widget.evento['fechaFin'] as Timestamp).toDate();
    endTime = TimeOfDay.fromDateTime(endDate);
    isFreeEntry = widget.evento['entradaLibre'] ?? false;
  }

  void _saveChanges() async {
    await FirebaseFirestore.instance
        .collection('eventos')
        .doc(widget.evento['id']) // Usar el ID del documento existente
        .update({
      'nombre': _nombreController.text,
      'descripcion': _descripcionController.text,
      'precio': isFreeEntry ? null : _precioController.text,
      'entradaLibre': isFreeEntry,
      'fechaInicio': DateTime(
        startDate.year,
        startDate.month,
        startDate.day,
        startTime.hour,
        startTime.minute,
      ),
      'fechaFin': DateTime(
        endDate.year,
        endDate.month,
        endDate.day,
        endTime.hour,
        endTime.minute,
      ),
      'ubicacion': _ubicacionController.text,
      'color': selectedColor.value,
      'color2': colorCode,
    });

    Navigator.of(context).pop(); // Regresar a la pantalla de eventos
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Evento'),
        backgroundColor: selectedColor, // Usar el color seleccionado como fondo
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                        colorCode = _getColorCode(color);
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
                        startDate = start!;
                        startTime = startT!;
                        endDate = end!;
                        endTime = endT!;
                      });
                    },
                  ),
                  Step3Details(
                    eventName: _nombreController.text,
                    eventDescription: _descripcionController.text,
                    isFreeEntry: isFreeEntry,
                    eventPrice: _precioController.text,
                    onDetailsEntered: (name, description, freeEntry, price) {
                      setState(() {
                        _nombreController.text = name;
                        _descripcionController.text = description;
                        isFreeEntry = freeEntry;
                        _precioController.text = price ?? '';
                      });
                    },
                  ),
                  Step4Location(
                    eventLocation: _ubicacionController.text,
                    onLocationEntered: (location) {
                      setState(() {
                        _ubicacionController.text = location;
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
                  count: 4,
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
                        _saveChanges(); // Guardar los cambios cuando esté en la última página
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _pageController.hasClients && _pageController.page == 3 && _ubicacionController.text.isEmpty
                        ? Colors.grey
                        : Colors.pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                  ),
                  child: Text(
                    _pageController.hasClients && _pageController.page == 3
                        ? 'Guardar Cambios'
                        : 'Siguiente',
                    style: TextStyle(
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
                    style: TextStyle(
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

  int _getColorCode(Color color) {
    if (color == Colors.pink) return 1;
    if (color == Colors.blue) return 2;
    if (color == Colors.yellow) return 3;
    if (color == Colors.purple) return 4;
    if (color == Colors.grey) return 5;
    return 0;
  }
}
