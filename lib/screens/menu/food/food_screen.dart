// import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/blocs/food/food_bloc.dart';
import 'package:booking_app/models/local/create_food.dart';
import 'package:booking_app/screens/menu/widgets/create_food_form.dart';
import 'package:booking_app/widgets/tag_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/category_item.dart';

class FoodScreen extends StatefulWidget {
  final FoodBloc fBloc;
  const FoodScreen({super.key, required this.fBloc});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  @override
  Widget build(BuildContext context) => BlocConsumer<FoodBloc, FoodState>(
        bloc: widget.fBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is FoodLoaded) {
            return Scaffold(
              appBar: AppBar(title: const Text('Еда'), actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        shape: const StadiumBorder()),
                    onPressed: () => _createFood(state.placeId),
                    child: const Text('Создать позицию')),
              ]),
              body: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Теги',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        TagItem(text: "Мясо"),
                        TagItem(text: "Паста"),
                        TagItem(text: "Обеденное"),
                        TagItem(text: "Основное"),
                        TagItem(text: "Суп"),
                        TagItem(text: "Мясо"),
                        TagItem(text: "Мясо"),
                        TagItem(text: "Мясо"),
                      ],
                    ),
                    const SizedBox(height: 30),
                    if (state.food.isNotEmpty)
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        children: state.food
                            //TODO: remove categoryItem
                            .map((x) => CategoryItem(
                                  name: x.name,
                                  categoryId: x.id,
                                  bloc: null,
                                  placeId: 0,
                                ))
                            .toList(),
                      )
                    else
                      const Center(
                        child: Text(
                          'Нет позиций еды',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );

  Future _createFood(int placeId) async {
    final data = await showDialog<CreateFoodModel>(
        context: context,
        builder: (context) => const AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              titlePadding: EdgeInsets.symmetric(horizontal: 30),
              backgroundColor: Color.fromARGB(255, 23, 23, 23),
              title: Align(
                child: Text(
                  'Создать позицию',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              content:
                  SizedBox(height: 350, width: 500, child: CreateFoodForm()),
            ));

    if (data == null) {
      return;
    }

    //TODO: где и кто будет заполнять список продуктов при создании блюда
    //TODO: мб блюдо создать просто так, а уже потом можно заредачить
    //TODO: добавив ему ингредиентов(хотя по факту эта операция простая)
    // widget.mBloc.add(CreateFood(model: data, placeId: placeId));
  }
}
