import 'package:flutter/material.dart';

class DatePickerTextFieldWidget extends StatefulWidget {
  const DatePickerTextFieldWidget({
    Key? key,
    required this.title,
    required this.text,
    required this.icon,
    required this.initialDate,
    required this.onDateChanged,
    required this.textEditingController,
  }) : super(key: key);

  final String title;
  final String text;
  final IconData icon;
  final DateTime initialDate;
  final Function(DateTime) onDateChanged;
  final TextEditingController textEditingController;

  @override
  _DatePickerTextFieldWidgetState createState() =>
      _DatePickerTextFieldWidgetState();
}

class _DatePickerTextFieldWidgetState extends State<DatePickerTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 8,
        ),
        Expanded(
          flex: 2,
          child: Text(
            widget.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          flex: 4,
          child: InkWell(
            onTap: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: widget.initialDate,
                firstDate: DateTime(1900),
                lastDate: DateTime(2101),
              );
              if (selectedDate != null) {
                widget.onDateChanged(selectedDate);
                setState(() {
                  widget.textEditingController.text =
                      "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                });
              }
            },
            child: IgnorePointer(
              child: TextFormField(
                controller: widget.textEditingController,
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    widget.icon,
                    color: Colors.grey,
                  ),
                  hintText: 'Select Date',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.1),
                      width: 1.0,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 12.0,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
      ],
    );
  }
}
