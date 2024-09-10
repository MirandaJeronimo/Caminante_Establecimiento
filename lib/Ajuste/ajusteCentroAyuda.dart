import 'package:flutter/material.dart';

class ajusteCentroAyuda extends StatelessWidget {
  const ajusteCentroAyuda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        leading: Icon(Icons.mic, color: Colors.green), // Ícono de micrófono
        title: Text('12:04 PM', style: TextStyle(color: Colors.white)),
        actions: [
          Icon(Icons.notifications),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          // Encabezado con imagen de perfil, nombre y tipo de establecimiento
          Container(
            color: Colors.pink,
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage('https://example.com/profile.jpg'), // Imagen de ejemplo
                ),
                SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nombre del perfil',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'tipoEstablecimiento',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Lista de opciones de perfil
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: [
                ProfileOption(icon: Icons.card_giftcard, text: 'Mis cupones'),
                ProfileOption(icon: Icons.history, text: 'Mis visitas'),
                ProfileOption(icon: Icons.emoji_events, text: 'Logros obtenidos'),
                ProfileOption(icon: Icons.local_hospital, text: 'Líneas de emergencia'),
                ProfileOption(icon: Icons.help, text: 'Ayúdanos'),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text('Tarifas de precios en playa'),
                ),
              ],
            ),
          ),
        ],
      ),
      // Barra de navegación inferior
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Ubicación',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String text;

  ProfileOption({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.pink),
      title: Text(text, style: TextStyle(fontSize: 18.0)),
      onTap: () {},
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ajusteCentroAyuda(),
  ));
}





























































