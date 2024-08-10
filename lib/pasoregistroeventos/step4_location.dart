import 'package:flutter/material.dart';

class Step4Location extends StatelessWidget {
  final String eventLocation;
  final Function(String) onLocationEntered;
  final Function() onSave;

  const Step4Location({
    Key? key,
    required this.eventLocation,
    required this.onLocationEntered,
    required this.onSave,
  }) : super(key: key);

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
            decoration: InputDecoration(
              labelText: 'Ubicación',
              labelStyle: TextStyle(color: Colors.grey),
            ),
            onChanged: onLocationEntered,
          ),
          Spacer(),
          Center(
            child: ElevatedButton(
              onPressed: onSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              ),
              child: Text(
                'Guardar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
