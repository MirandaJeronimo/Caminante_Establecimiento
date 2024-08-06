import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_color/flutter_color.dart'; // Importa flutter_color
import 'homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA7HQVKRiY1gt-3h0YSVf3oeOlgAn9uJOk", //  ==   current_key in google-services.json file
      appId: "1:1088120227990:android:484db0d5f19170b1ad1ab7", // ==  mobilesdk_app_id  in google-services.json file
      messagingSenderId: "1088120227990", // ==   project_number in google-services.json file
      projectId: "caminante2-aa447", // ==   project_id   in google-services.json file
    ),
  );
  runApp(const MyApp()); // Mantener const aquí
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Declarar como constante

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
        ),
      ),
      home: const OnboardingScreen(), // Declarar como constante si es posible
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key}); // Declarar como constante

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final List<String> _imagePaths = [
    'assets/onboarding1.png',
    'assets/onboarding2.png',
    'assets/onboarding3.png',
    'assets/onboarding4.png',
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page == _imagePaths.length - 1) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()), // Declarar como constante
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _imagePaths.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  _imagePaths[index],
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: _imagePaths.length,
                effect: ScrollingDotsEffect(
                  dotHeight: 12,
                  dotWidth: 12,
                  spacing: 16,
                  dotColor: HexColor('#D3D3D3'), // Usando HexColor
                  activeDotColor: HexColor('#8B04F6'), // Usando HexColor
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key}); // Declarar como constante

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/cover.png',
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    height: 200,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'CAMINANTE',
                    style: GoogleFonts.montserrat(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 30), // Ajusta el espacio antes de los campos de texto
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 60, // Ajusta la altura del TextField
                          child: _buildTextField(label: 'Correo Electrónico'),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 60, // Ajusta la altura del TextField
                          child: _buildPasswordTextField(label: 'Contraseña'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => const HomePage()), // Declarar como constante
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor('#ff0080'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Iniciar Sesión',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      // Manejo de navegación a la pantalla de registro si es necesario
                    },
                    child: Text(
                      '¿No tienes una cuenta? Regístrate',
                      style: GoogleFonts.montserrat(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({required String label, bool obscureText = false}) {
    return TextFormField(
      obscureText: obscureText,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15), // Ajusta el padding interno
        labelText: label,
        labelStyle: TextStyle(
          color: HexColor('#b7b7b7'),
        ),
        filled: true,
        fillColor: HexColor('#ffffff'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo es obligatorio';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordTextField({required String label}) {
    return TextFormField(
      obscureText: _obscureText,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15), // Ajusta el padding interno
        labelText: label,
        labelStyle: TextStyle(
          color: HexColor('#b7b7b7'),
        ),
        filled: true,
        fillColor: HexColor('#ffffff'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: HexColor('#b7b7b7'),
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}
