import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangeTimeDialog extends StatelessWidget {
  String label;
  ChangeTimeDialog({super.key, required this.label});

  @override
  Widget build(BuildContext context) => Container(
        height: 500,
        child: AlertDialog(
          title: Text(
            '${label} на:',
          ),
          content: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            shrinkWrap: true,
            children: [Text('data'), Text('data'), Text('data'), Text('data')],
          ),
        ),
      );
}
