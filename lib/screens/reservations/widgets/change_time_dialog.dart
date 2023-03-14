import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangeTimeDialog extends StatelessWidget {
  final String label;

  const ChangeTimeDialog({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              shrinkWrap: true,
              children: [
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data')
              ],
            ),
          ],
        ),
      );
}
