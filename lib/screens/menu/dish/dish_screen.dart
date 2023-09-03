import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/local/create_dish.dart';
import 'package:booking_app/models/local/ingredient_model.dart';
import 'package:booking_app/screens/menu/widgets/create_dish_form.dart';
import 'package:booking_app/screens/menu/widgets/dish_item.dart';
import 'package:booking_app/widgets/tag_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DishScreen extends StatefulWidget {
  final DishBloc dBloc;
  const DishScreen({super.key, required this.dBloc});

  @override
  State<DishScreen> createState() => _DishScreenState();
}

class _DishScreenState extends State<DishScreen> {
  @override
  Widget build(BuildContext context) => BlocConsumer<DishBloc, DishState>(
        bloc: widget.dBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is DishLoaded) {
            return Scaffold(
              appBar: AppBar(title: const Text('Еда'), actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        shape: const StadiumBorder()),
                    onPressed: () async => _createDish(state.ingredients),
                    child: const Text('Создать позицию')),
              ]),
              body: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
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
                        // state.food.map((x) => x.tags)
                        const TagItem(text: "Мясо"),
                        const TagItem(text: "Паста"),
                        const TagItem(text: "Обеденное"),
                        const TagItem(text: "Основное"),
                        const TagItem(text: "Суп"),
                        const TagItem(text: "Мясо"),
                        const TagItem(text: "Мясо"),
                        const TagItem(text: "Мясо"),
                      ],
                    ),
                    const SizedBox(height: 30),
                    if (state.dishes.isNotEmpty)
                      Expanded(
                        child: GridView.count(
                          primary: true,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          children: state.dishes
                              .map(
                                  (x) => DishItem(name: x.name, price: x.price))
                              .toList(),
                        ),
                      )
                    // FoodItem(
                    //     name: state.food[0].name, price: state.food[0].price)
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

  Future _createDish(List<IngredientModel> ingredients) async {
    final data = await showDialog<CreateDishModel>(
        context: context,
        builder: (context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              titlePadding: const EdgeInsets.symmetric(horizontal: 30),
              backgroundColor: const Color.fromARGB(255, 23, 23, 23),
              title: const Align(
                child: Text(
                  'Создать позицию',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              content: SizedBox(
                  width: 500, child: CreateDishForm(ingredients: ingredients)),
            ));

    if (data == null) {
      return;
    }

    //TODO: где и кто будет заполнять список продуктов при создании блюда
    //TODO: мб блюдо создать просто так, а уже потом можно заредачить
    //TODO: добавив ему ингредиентов(хотя по факту эта операция простая)
    widget.dBloc.add(CreateDish(model: data));
  }
}