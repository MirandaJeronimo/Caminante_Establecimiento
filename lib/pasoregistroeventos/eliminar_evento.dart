import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';

class EliminarEvento extends StatelessWidget {
  final Map<String, dynamic> evento;

  EliminarEvento({required this.evento});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eliminar Evento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¿Estás seguro de que deseas eliminar este evento?',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              evento['nombre'] ?? 'Sin título',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Mostrar el cuadro de diálogo de confirmación personalizado
                    final bool confirmDelete = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.white, // Fondo blanco del diálogo
                          content: Text(
                            '¿Quieres borrar este evento?',
                            style: GoogleFonts.montserrat(
                              color: HexColor('#B3B3B3'), // Texto gris claro
                              fontSize: 16.0,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0), // Bordes redondeados del diálogo
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text(
                                'Cancelar',
                                style: GoogleFonts.montserrat(
                                  color: HexColor('#FF007F'), // Color del texto del botón "Cancelar"
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: HexColor('#FF007F'), // Color de fondo del botón "Borrar"
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                                minimumSize: Size(90, 40), // Tamaño mínimo del botón
                              ),
                              child: Text(
                                'Eliminar',
                                style: GoogleFonts.montserrat(
                                  color: Colors.white, // Texto blanco en el botón "Eliminar"
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );

                    if (confirmDelete) {
                      // Eliminar el evento de Firebase
                      await FirebaseFirestore.instance
                          .collection('eventos')
                          .doc(evento['id']) // Asegúrate de que 'id' contenga el ID correcto del documento
                          .delete();

                      Navigator.of(context).pop(); // Regresar a la pantalla anterior
                      Navigator.of(context).pop(); // Regresar a la lista de eventos
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text('Eliminar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Cancelar y regresar
                  },
                  child: Text('hola'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
