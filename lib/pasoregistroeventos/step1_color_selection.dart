import 'package:flutter/material.dart';

class Step1ColorSelection extends StatelessWidget {
  final Color selectedColor;
  final ValueChanged<Color> onColorSelected;

  const Step1ColorSelection({
    Key? key,
    required this.selectedColor,
    required this.onColorSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Elige un color',
            style: TextStyle(
              color: Colors.pink,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Puedes crear más de un evento en un mes, elige un color y dale identidad al evento actual.',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0),
          child: Center(
            child: Image.asset(
              'assets/colorevento.png', // Ruta de la imagen
              width: 300.0,
              height: 300.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildColorPicker(Colors.pink),
              _buildColorPicker(Colors.blue),
              _buildColorPicker(Colors.yellow),
              _buildColorPicker(Colors.purple),
              _buildColorPicker(Colors.grey),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildColorPicker(Color color) {
    return GestureDetector(
      onTap: () => onColorSelected(color),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: selectedColor == color ? Colors.black : Colors.transparent,
            width: 2.0,
          ),
        ),
      ),
    );
  }

}
