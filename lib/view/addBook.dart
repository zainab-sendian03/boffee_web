import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hello/core/constants/color.dart';

class CustomFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: medium_Brown,
      borderType: BorderType.RRect,
      dashPattern: [6, 3],
      strokeWidth: 3,
      radius: Radius.circular(12),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            color: Beige,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 32.0,
            ),
          ),
        ),
      ),
    );
  }
}
