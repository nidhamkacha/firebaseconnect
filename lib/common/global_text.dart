import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlobalText extends StatelessWidget {
   final String? text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextStyle? textStyle;
  const GlobalText(
      {super.key,
      this.text,
      this.fontSize,
      this.color,
      this.fontWeight,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      style: textStyle ??
          GoogleFonts.poppins(
            fontSize: fontSize,
            color: color ?? Colors.black,
            fontWeight: fontWeight,
          ),
    );
  }
}