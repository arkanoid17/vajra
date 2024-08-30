import 'package:flutter/material.dart';
import 'package:vajra_test/cores/themes/app_palette.dart';

class Loader extends StatelessWidget {
  final Color? loaderColor;

  const Loader({super.key, this.loaderColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: loaderColor ?? AppPalette.primaryColor,
      ),
    );
  }
}
