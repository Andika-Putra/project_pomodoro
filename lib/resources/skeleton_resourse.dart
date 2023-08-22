import 'package:flutter/material.dart';

class Bone extends StatelessWidget {
  final double? height, width;

  const Bone({
    super.key,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            16,
          ),
        ),
      ),
    );
  }
}
