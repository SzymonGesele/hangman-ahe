import 'package:flutter/material.dart';

Widget letter(String char, bool visible) {
  return Container(

    margin: const EdgeInsets.all(3.0),
    alignment: Alignment.center,
    width: 30,
    height: 30,
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.white, width: 2.0)
      ),
    ),
    child: Visibility(
      visible: !visible,
      child: Text(
        char.toUpperCase(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.white
        ),
      ),
    ),
  );
}
