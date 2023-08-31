import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String name;
  const CategoryItem({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(10),
          width: 300,
          height: 300,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Center(
            child: Text(name),
          ),
        ),
      );
}
