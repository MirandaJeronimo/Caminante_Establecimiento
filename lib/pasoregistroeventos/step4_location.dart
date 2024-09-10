import 'package:flutter/material.dart';

class Step4Location extends StatefulWidget {
  final String? eventLocation;
  final Function(String) onLocationEntered;

  const Step4Location({
    Key? key,
    this.eventLocation,
    required this.onLocationEntered,
  }) : super(key: key);

  @override
  _Step4LocationState createState() => _Step4LocationState();
}

class _Step4LocationState extends State<Step4Location> {
  late TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    _locationController = TextEditingController(text: widget.eventLocation);
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ubicación del evento',
            style: TextStyle(
              color: Colors.pink,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: _locationController,
            style: TextStyle(color: Colors.grey), // Color gris para el texto
            decoration: InputDecoration(
              labelText: 'Ingresa la ubicación del evento',
              labelStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onChanged: (value) {
              widget.onLocationEntered(value);
            },
          ),
        ],
      ),
    );
  }
}
