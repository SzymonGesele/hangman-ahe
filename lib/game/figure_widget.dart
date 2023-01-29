import 'package:flutter/material.dart';

Widget figure(String path) {
  return SizedBox(
    child: Visibility(
      child: Image.asset(path)
    ),
  );
}
