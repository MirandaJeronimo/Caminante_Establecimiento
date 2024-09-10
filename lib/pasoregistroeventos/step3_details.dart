import 'package:flutter/material.dart';

class Step3Details extends StatelessWidget {
  final String eventName;
  final String eventDescription;
  final bool isFreeEntry;
  final String? eventPrice;
  final Function(String, String, bool, String?) onDetailsEntered;

  const Step3Details({
    Key? key,
    required this.eventName,
    required this.eventDescription,
    required this.isFreeEntry,
    this.eventPrice,
    required this.onDetailsEntered,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detalles del evento',
            style: TextStyle(
              color: Colors.pink,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(
              labelText: 'Nombre del evento',
              labelStyle: TextStyle(color: Colors.grey),
            ),
            style: TextStyle(color: Colors.grey), // Color del texto ingresado
            onChanged: (value) => onDetailsEntered(value, eventDescription, isFreeEntry, eventPrice),
          ),
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(
              labelText: 'Descripción',
              labelStyle: TextStyle(color: Colors.grey),
            ),
            style: TextStyle(color: Colors.grey), // Color del texto ingresado
            onChanged: (value) => onDetailsEntered(eventName, value, isFreeEntry, eventPrice),
            maxLines: 4,
          ),
          SizedBox(height: 16.0),
          Row(
            children: [
              Checkbox(
                value: isFreeEntry,
                onChanged: (value) {
                  onDetailsEntered(eventName, eventDescription, value!, eventPrice);
                },
              ),
              Text('Entrada libre', style: TextStyle(color: Colors.grey)),
            ],
          ),
          if (!isFreeEntry)
            TextField(
              decoration: InputDecoration(
                labelText: 'Precio COP',
                labelStyle: TextStyle(color: Colors.grey),
              ),
              style: TextStyle(color: Colors.grey), // Color del texto ingresado
              onChanged: (value) => onDetailsEntered(eventName, eventDescription, isFreeEntry, value),
              keyboardType: TextInputType.number,
            ),
        ],
      ),
    );
  }
}
