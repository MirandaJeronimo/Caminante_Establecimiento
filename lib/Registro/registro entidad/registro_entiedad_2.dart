import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:caminante_establecimiento_firebase2/Registro/registro entidad/registro_entidad_3.dart';
import 'package:caminante_establecimiento_firebase2/Registro/registro entidad/registro_entidad_4.dart';
import 'package:caminante_establecimiento_firebase2/Registro/registro entidad/registro_entidad_5.dart';
import 'package:caminante_establecimiento_firebase2/Registro/registro entidad/registro_entidad_6.dart';
import 'package:caminante_establecimiento_firebase2/Registro/registro entidad/registro_entidad_7.dart';
import 'package:caminante_establecimiento_firebase2/Registro/registro entidad/confirmacion_registro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistroEntidad2 extends StatefulWidget {
  const RegistroEntidad2({Key? key}) : super(key: key);

  @override
  _RegistroEntidad2State createState() => _RegistroEntidad2State();
}

class _RegistroEntidad2State extends State<RegistroEntidad2> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Almacenamos los valores de los diferentes pasos del registro
  String _nombreEntidad = '';
  String _naturalezaEntidad = '';
  String _categoria = '';
  String _subcategoria = '';
  String _paginaOficial = '';
  String _correoInstitucional = '';
  String _municipio = '';
  String _direccionEntidad = '';
  String _ubicacion = '';

  bool _isLoading = false; // Indicador de carga

  Future<void> _guardarDatos() async {
    setState(() {
      _isLoading = true; // Mostrar el indicador de carga
    });

    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await FirebaseFirestore.instance.collection('entidades').doc(user.uid).update({
          'nombreEntidad': _nombreEntidad,
          'naturalezaEntidad': _naturalezaEntidad,
          'categoria': _categoria,
          'subcategoria': _subcategoria,
          'ubicacion': '$_municipio, $_direccionEntidad\nCoordenadas: $_ubicacion',
          'paginaOficial': _paginaOficial,
          'correoInstitucional': _correoInstitucional,
          'fechaActualizacion': FieldValue.serverTimestamp(),
        });

        // Navegar a la pantalla de confirmación
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ConfirmacionRegistro()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar los datos: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false; // Ocultar el indicador de carga
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/fondoregistrohd.png',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top),
                _buildHeader(),
                const SizedBox(height: 10),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    children: [
                      RegistroEntidad3(
                        onNombreEntidadChanged: (value) {
                          setState(() {
                            _nombreEntidad = value;
                          });
                        },
                        onNaturalezaEntidadChanged: (value) {
                          setState(() {
                            _naturalezaEntidad = value;
                          });
                        },
                      ),
                      RegistroEntidad4(
                        onCategoriaChanged: (value) {
                          setState(() {
                            _categoria = value;
                          });
                        },
                        onSubcategoria1Changed: (value) {
                          setState(() {
                            _subcategoria = value;
                          });
                        },
                        onSubcategoria2Changed: (value) {
                          setState(() {
                            _subcategoria = value ?? ''; // Ajuste si hay una subcategoría 2
                          });
                        },
                      ),
                      RegistroEntidad5(
                        onPaginaOficialChanged: (value) {
                          setState(() {
                            _paginaOficial = value;
                          });
                        },
                        onCorreoInstitucionalChanged: (value) {
                          setState(() {
                            _correoInstitucional = value;
                          });
                        },
                      ),
                      RegistroEntidad6(
                        onMunicipioChanged: (value) {
                          setState(() {
                            _municipio = value;
                          });
                        },
                        onDireccionChanged: (value) {
                          setState(() {
                            _direccionEntidad = value;
                          });
                        },
                        onUbicacionChanged: (value) {
                          setState(() {
                            _ubicacion = '${value?.latitude}, ${value?.longitude}';
                          });
                        },
                      ),
                      RegistroEntidad7(
                        nombreEntidad: _nombreEntidad,
                        naturalezaEntidad: _naturalezaEntidad,
                        categoria: _categoria,
                        subcategoria: _subcategoria,
                        ubicacion: '$_municipio, $_direccionEntidad\nCoordenadas: $_ubicacion',
                        paginaOficial: _paginaOficial,  // Añadimos estos valores
                        correoInstitucional: _correoInstitucional,  // Añadimos estos valores
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildContinueButton(),
                _buildExitButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
          onPressed: () {
            if (_currentPage == 0) {
              Navigator.of(context).pop();
            } else {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
        ),
        Text(
          'Registro de Entidad',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading
            ? null // Desactivamos el botón si está en modo de carga
            : () {
          if (_currentPage < 4) {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          } else {
            _guardarDatos(); // Guardar los datos cuando se llega al último paso
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: HexColor('#ff0080'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Text(
          _currentPage < 4 ? 'Siguiente' : 'Finalizar',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildExitButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0), // Subimos el botón agregando padding
      child: Center(
        child: TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Sale del proceso de registro
          },
          child: Text(
            'Salir',
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
