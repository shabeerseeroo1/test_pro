import 'package:flutter/material.dart';

extension CustomWidget on Widget {
  Center center() {
    return Center(
      child: this,
    );
  }

  Padding padding({required double horizontal, required double vertical}){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal,vertical: vertical),
      child: this,
    );
  }
}
