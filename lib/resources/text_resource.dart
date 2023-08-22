// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'font_size_resource.dart';

class SimpleText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? weight;
  final Color? color;
  final String? family;
  final bool? overflow;
  final bool? maxLines;
  final TextAlign? textAlign;

  SimpleText({
    required this.text,
    this.size,
    this.weight,
    this.color,
    this.family,
    this.overflow,
    this.maxLines,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size == null
            ? FontSize().adjustFont(14)
            : FontSize().adjustFont(size!),
        fontWeight: weight ?? FontWeight.normal,
        color: color ?? Colors.black54,
        fontFamily: family ?? "Lato",
      ),
      overflow: overflow == true ? TextOverflow.ellipsis : TextOverflow.visible,
      maxLines: maxLines == true ? 2 : null,
      textAlign: textAlign ?? TextAlign.left,
    );
  }
}
