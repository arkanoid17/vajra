import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialogDisplay extends StatefulWidget{
  final String title;
  final String content;
  final String buttonText;
  final Function action;


  const AlertDialogDisplay(
      {Key? key,
        required this.title,
        required this.content,
        required this.buttonText,
        required this.action,
      })
      : super(key: key);

  @override
  State<AlertDialogDisplay> createState() => _AlertDialogDisplay();
  
}

class _AlertDialogDisplay extends State<AlertDialogDisplay>{
  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      title: Text(widget.title,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700),),
      content: Text(widget.content),
      actions: [
        TextButton(onPressed: ()=> {
            Navigator.pop(context),
            widget.action(context)
        }, child: Text(widget.buttonText))
      ],
    );
  }


  
} 