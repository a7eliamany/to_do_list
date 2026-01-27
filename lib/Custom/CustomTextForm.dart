import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;
  const CustomTextForm({
    super.key,
    required this.textEditingController,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 25),
      minLines: 1,
      maxLines: 3,
      validator: validator,
      controller: textEditingController,
      decoration: InputDecoration(
        hintStyle: TextStyle(fontSize: 25),
        hintText: "Task",
        border: InputBorder.none,
        suffixIcon: IconButton(
          onPressed: () => textEditingController.clear(),
          icon: Icon(Icons.cancel, color: Colors.white30),
        ),
      ),
    );
  }
}
