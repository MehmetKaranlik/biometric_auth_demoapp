import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  
    double get widthFraction => MediaQuery.of(this).size.width / 100;
    double get heightFraction => MediaQuery.of(this).size.height / 100;
}

