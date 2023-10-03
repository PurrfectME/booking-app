import 'dart:io';

import 'package:booking_app/models/local/ingredient_model.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/widgets/tag_item.dart';
import 'package:flutter/material.dart';

class DishItem extends StatelessWidget {
  final String name;
  final double price;
  final String description;
  final List<Tag> tags;
  final List<IngredientModel> ingredients;
  final String mediaId;

  const DishItem({
    Key? key,
    required this.name,
    required this.price,
    required this.description,
    required this.tags,
    required this.ingredients,
    required this.mediaId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
              width: 2, color: const Color.fromARGB(255, 45, 45, 45)),
          color: const Color.fromARGB(255, 23, 23, 23),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (mediaId.isNotEmpty)
              Container(
                height: 200,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  image: DecorationImage(
                      opacity: 1,
                      fit: BoxFit.fill,
                      image: FileImage(File(mediaId))),
                ),
              )
            else
              Container(
                height: 200,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  image: DecorationImage(
                      opacity: 1,
                      fit: BoxFit.cover,
                      //TODO: add default IMAGE
                      image: AssetImage('assets/images/neft.jpg')),
                ),
              ),
            const SizedBox(width: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Цена: $price',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    'Описание: $description',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Row(
                    children: tags.map((e) => TagItem(text: e.name)).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}