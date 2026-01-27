import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "home",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Icon(Icons.menu),
      ],
    );
  }
}
