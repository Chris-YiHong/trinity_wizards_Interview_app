import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget(
      {super.key,
      required this.title,
      this.text,
      this.hintText,
      this.icon,
      required this.textEditingController,
      this.textInputAction});
  final String title;
  final String? text;
  final String? hintText;
  final IconData? icon;
  final TextEditingController textEditingController;
  final TextInputAction? textInputAction;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
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
          child: TextField(
            controller: widget.textEditingController,
            style: const TextStyle(fontSize: 16),
            textInputAction: widget.textInputAction ?? TextInputAction.next,
            decoration: InputDecoration(
              suffixIcon: Icon(
                widget.icon,
                color: Colors.grey,
              ),
              hintText: widget.hintText,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.withOpacity(0.1),
                  width: 1.0,
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
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

class TitleWidget extends StatelessWidget {
  final String title;
  const TitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.grey.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
