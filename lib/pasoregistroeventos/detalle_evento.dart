import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:caminante_establecimiento_firebase2/pasoregistroeventos/editar_evento.dart';
import 'package:caminante_establecimiento_firebase2/pasoregistroeventos/eliminar_evento.dart';

class DetalleEvento extends StatelessWidget {
  final Map<String, dynamic> evento;

  DetalleEvento({required this.evento});

  @override
  Widget build(BuildContext context) {
    final DateTime? fechaInicio = (evento['fechaInicio'] as Timestamp?)?.toDate();
    final DateTime? fechaFin = (evento['fechaFin'] as Timestamp?)?.toDate();

    return Scaffold(
      backgroundColor: HexColor('#8f3a7c'), // Fondo del color especificado
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Botón de regreso
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(height: 16.0),
              // Nombre del evento y botones de acciones
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      evento['nombre'] ?? 'Sin título',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      _buildActionButton(
                        icon: Icons.edit,
                        onPressed: () {
                          // Navegar a la pantalla de edición del evento
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EditarEvento(evento: evento)),
                          );
                        },
                      ),
                      SizedBox(width: 8.0),
                      _buildActionButton(
                        icon: Icons.delete, // Icono de eliminar
                        onPressed: () async {
                          // Confirmación antes de eliminar
                          final bool confirmDelete = await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Eliminar evento'),
                              content: Text('¿Estás seguro de que deseas eliminar este evento?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(false),
                                  child: Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(true),
                                  child: Text('Eliminar', style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            ),
                          );

                          if (confirmDelete) {
                            // Eliminar el evento de Firebase
                            await FirebaseFirestore.instance
                                .collection('eventos')
                                .doc(evento['id'])
                                .delete();

                            Navigator.of(context).pop(); // Regresar a la lista de eventos
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Divider(color: Colors.white), // Divider blanco después del nombre del evento
              SizedBox(height: 8.0),
              // Información de fecha y hora
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.white),
                  SizedBox(width: 8.0),
                  Text(
                    'Fecha: ${fechaInicio != null ? DateFormat('dd MMM yyyy').format(fechaInicio) : 'Fecha no especificada'}',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(Icons.access_time, color: Colors.white),
                  SizedBox(width: 8.0),
                  Text(
                    'Hora: ${evento['horaInicio'] ?? 'Hora no especificada'} - ${evento['horaFin'] ?? ''}',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              // Ubicación del evento
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.white),
                  SizedBox(width: 8.0),
                  Text(
                    evento['ubicacion'] ?? 'Ubicación no especificada',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              // Entrada libre o precio
              Row(
                children: [
                  Icon(
                    evento['entradaLibre'] == true
                        ? Icons.check_circle
                        : Icons.monetization_on,
                    color: evento['entradaLibre'] == true ? Colors.green : Colors.white,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    evento['entradaLibre'] == true
                        ? 'Entrada libre'
                        : 'Precio: ${evento['precio'] ?? 'No especificado'}',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              // Descripción del evento
              Text(
                'Descripción',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                evento['descripcion'] != null && evento['descripcion'].isNotEmpty
                    ? evento['descripcion']
                    : 'Sin descripción',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16.0),
              // Botón de itinerario centrado
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Acción del botón Ver Itinerario
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink, // Color del botón
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                  ),
                  child: Text(
                    'Ver itinerario',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
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

  Widget _buildActionButton({required IconData icon, required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: HexColor('#8f3a7c')),
        iconSize: 24.0,
        onPressed: onPressed,
      ),
    );
  }
}
