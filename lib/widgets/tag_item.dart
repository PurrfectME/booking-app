import 'package:flutter/material.dart';

class TagItem extends StatelessWidget {
  final String text;
  const TagItem({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      margin: const EdgeInsets.only(top: 13, bottom: 13, right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23),
          border: Border.all(color: Colors.white, width: 1)),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ));
}
