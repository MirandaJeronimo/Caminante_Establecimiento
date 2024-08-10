import 'package:flutter/material.dart';

class Step2Duration extends StatelessWidget {
  final DateTime? startDate;
  final TimeOfDay? startTime;
  final DateTime? endDate;
  final TimeOfDay? endTime;
  final Function(DateTime?, TimeOfDay?, DateTime?, TimeOfDay?) onDateTimeSelected;

  const Step2Duration({
    Key? key,
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
    required this.onDateTimeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Duración del evento',
            style: TextStyle(
              color: Colors.pink,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 16.0),
          _buildDateTimePicker(
            context,
            'Fecha de inicio',
            startDate,
                (date) => onDateTimeSelected(date, startTime, endDate, endTime),
          ),
          SizedBox(height: 16.0),
          _buildTimePicker(
            context,
            'Hora de inicio',
            startTime,
                (time) => onDateTimeSelected(startDate, time, endDate, endTime),
          ),
          SizedBox(height: 16.0),
          _buildDateTimePicker(
            context,
            'Fecha de finalización',
            endDate,
                (date) => onDateTimeSelected(startDate, startTime, date, endTime),
          ),
          SizedBox(height: 16.0),
          _buildTimePicker(
            context,
            'Hora de finalización',
            endTime,
                (time) => onDateTimeSelected(startDate, startTime, endDate, time),
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimePicker(
      BuildContext context, String label, DateTime? selectedDate, Function(DateTime) onDateSelected) {
    return Row(
      children: [
        Text(label, style: TextStyle(color: Colors.grey)),
        Spacer(),
        TextButton(
          onPressed: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
            );
            if (picked != null) {
              onDateSelected(picked);
            }
          },
          child: Text(
            selectedDate != null
                ? "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"
                : 'Seleccionar',
            style: TextStyle(color: Colors.pink),
          ),
        ),
      ],
    );
  }

  Widget _buildTimePicker(
      BuildContext context, String label, TimeOfDay? selectedTime, Function(TimeOfDay) onTimeSelected) {
    return Row(
      children: [
        Text(label, style: TextStyle(color: Colors.grey)),
        Spacer(),
        TextButton(
          onPressed: () async {
            final picked = await showTimePicker(
              context: context,
              initialTime: selectedTime ?? TimeOfDay.now(),
            );
            if (picked != null) {
              onTimeSelected(picked);
            }
          },
          child: Text(
            selectedTime != null
                ? "${selectedTime.hour}:${selectedTime.minute} ${selectedTime.period == DayPeriod.am ? 'AM' : 'PM'}"
                : 'Seleccionar',
            style: TextStyle(color: Colors.pink),
          ),
        ),
      ],
    );
  }
}
