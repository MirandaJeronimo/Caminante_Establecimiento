import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

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
          _buildCustomTimePicker(
            context,
            'Hora de inicio',
            startTime ?? TimeOfDay.now(),  // Usamos un valor por defecto si es null
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
          _buildCustomTimePicker(
            context,
            'Hora de finalización',
            endTime ?? TimeOfDay.now(),  // Usamos un valor por defecto si es null
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

  Widget _buildCustomTimePicker(
      BuildContext context, String label, TimeOfDay selectedTime, Function(TimeOfDay) onTimeSelected) {
    return Row(
      children: [
        Text(label, style: TextStyle(color: Colors.grey)),
        Spacer(),
        TextButton(
          onPressed: () {
            try {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 250.0,
                    child: TimePickerSpinner(
                      is24HourMode: false,
                      normalTextStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                      highlightedTextStyle: TextStyle(
                        fontSize: 24,
                        color: Colors.pink,
                      ),
                      spacing: 50,
                      itemHeight: 60,
                      isForce2Digits: true,
                      time: DateTime(0, 0, 0, selectedTime.hour, selectedTime.minute),
                      onTimeChange: (time) {
                        if (time != null) {
                          onTimeSelected(TimeOfDay(hour: time.hour, minute: time.minute));
                        }
                      },
                    ),
                  );
                },
              );
            } catch (e) {
              // Captura cualquier excepción inesperada para depuración
              print('Error al abrir el TimePicker: $e');
            }
          },
          child: Text(
            "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')} ${selectedTime.period == DayPeriod.am ? 'AM' : 'PM'}",
            style: TextStyle(color: Colors.pink),
          ),
        ),
      ],
    );
  }
}
