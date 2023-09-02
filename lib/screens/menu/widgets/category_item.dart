import 'package:booking_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/food/food_bloc.dart';

class CategoryItem extends StatelessWidget {
  final String name;
  final int categoryId;
  final Bloc? bloc;
  final int placeId;
  const CategoryItem({
    Key? key,
    required this.name,
    required this.categoryId,
    required this.bloc,
    required this.placeId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          switch (categoryId) {
            //food
            case 0:
              bloc!.add(FoodLoad(placeId: placeId));
              Navigator.push<void>(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FoodScreen(fBloc: bloc as FoodBloc)));
              break;
            default:
          }
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          width: 100,
          height: 100,
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
