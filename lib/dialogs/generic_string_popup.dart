import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GenericStringPopup extends StatefulWidget{

  final List<String> options;
  final String selectedOption;
  final Function onPopupChanged;
  final Widget child;

  const GenericStringPopup({Key? key, required this.options, required this.selectedOption, required this.onPopupChanged, required this.child})
      : super(key: key);

  @override
  State<GenericStringPopup> createState() => _GenericStringPopup();

}


class _GenericStringPopup extends State<GenericStringPopup>{
  @override
  Widget build(BuildContext context) {
    return  PopupMenuButton<String>(
      itemBuilder: (context) => widget.options
          .map((item) => PopupMenuItem<String>(
        value: item,
        child: Text(
          item,
        ),
      ))
          .toList(),
      onSelected: (value) {
        widget.onPopupChanged(value);
      },
      child: Icon(Icons.filter_alt_outlined),
    );
  }

}