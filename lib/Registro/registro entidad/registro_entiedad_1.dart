import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:caminante_establecimiento_firebase2/Registro/registro entidad/registro_entiedad_2.dart'; // pantalla selector de registro
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';

class RegistroEntidad1 extends StatefulWidget {
  const RegistroEntidad1({super.key});

  @override
  _RegistroEntidad1State createState() => _RegistroEntidad1State();
}

class _RegistroEntidad1State extends State<RegistroEntidad1> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _register() async {
    try {
      if (_passwordController.text == _confirmPasswordController.text) {
        // Crear cuenta en Firebase Authentication
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Guardar datos iniciales en Firestore
        await FirebaseFirestore.instance.collection('entidades').doc(userCredential.user!.uid).set({
          'email': _emailController.text,
          'tipo': 'entidad',  // Campo para identificar que es una entidad
          'fechaRegistro': FieldValue.serverTimestamp(),
        });

        // Si se crea correctamente, avanzar al siguiente paso del registro
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegistroEntidad2()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Las contraseñas no coinciden')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/fondoregistrohd.png', // Usar la imagen de fondo
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Text(
                      'Regresar',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Bienvenido a Caminante',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Correo',
                    hintStyle: TextStyle(color: HexColor('#b7b7b7')),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 20),
                  ),
                  style: TextStyle(color: HexColor('#4A4A4A')),
                ),
                const SizedBox(height: 10),
                Text(
                  'Usaremos este correo como protección de cuenta.',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 50),
                Text(
                  'Contraseña',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Contraseña',
                    hintStyle: TextStyle(color: HexColor('#b7b7b7')),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 20),
                  ),
                  style: TextStyle(color: HexColor('#4A4A4A')),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Confirmar contraseña',
                    hintStyle: TextStyle(color: HexColor('#b7b7b7')),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 20),
                  ),
                  style: TextStyle(color: HexColor('#4A4A4A')),
                ),
                const SizedBox(height: 10),
                Text(
                  'Usa 8 o más caracteres con una combinación de letras, números y símbolos.',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _register, // Llama a la función de registro
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      'Continuar',
                      style: GoogleFonts.montserrat(
                        color: HexColor('#ff0080'),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
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
}
