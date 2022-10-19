import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vajra/resource_helper/strings.dart';

class PopupMenuDialog extends StatefulWidget {
  final List<String> names;
  final String selected;
  final Function onLocationChanged;

  const PopupMenuDialog({Key? key, required this.names, required this.selected, required this.onLocationChanged})
      : super(key: key);

  @override
  State<PopupMenuDialog> createState() => _PopupMenuDialog();
}

class _PopupMenuDialog extends State<PopupMenuDialog> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
        itemBuilder: (context) => widget.names
            .map((item) => PopupMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                  ),
                ))
            .toList(),
        onSelected: (value) {
          widget.onLocationChanged(value);
        },
        child: Row(
          children: [
            Text(widget.selected,
            style: const TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(width: 5,height: 1),
            const Icon(Icons.arrow_drop_down,color: Colors.white,)
          ],
        )
    );
  }
}
