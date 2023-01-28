import 'package:flutter/material.dart';

Widget figure(String path, bool visible) {
  return SizedBox(
    width: 350,
    height: 350,
    child: Visibility(
      visible: visible,
      child: Image.asset(path)
    ),
  );
}
