import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/local/create_dish.dart';
import 'package:booking_app/models/local/dish_model.dart';
import 'package:booking_app/models/local/product_model.dart';
import 'package:booking_app/screens/dish/widgets/create_dish_form.dart';
import 'package:booking_app/screens/dish/widgets/dish_item.dart';
import 'package:booking_app/screens/dish/widgets/edit_dish_form.dart';
import 'package:booking_app/widgets/tag_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DishScreen extends StatefulWidget {
  final DishBloc dBloc;
  final bool isSelectable;
  const DishScreen({
    super.key,
    required this.dBloc,
    required this.isSelectable,
  });

  @override
  State<DishScreen> createState() => _DishScreenState();
}

class _DishScreenState extends State<DishScreen> {
  final filterByTags = <String>[];
  final List<int> selectedDishes = [];

  @override
  Widget build(BuildContext context) => BlocConsumer<DishBloc, DishState>(
        bloc: widget.dBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is DishLoaded) {
            return Scaffold(
              floatingActionButton: widget.isSelectable
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          shape: const StadiumBorder()),
                      onPressed: () => Navigator.pop(context, selectedDishes),
                      child: const Text('Добавит в счёт'))
                  : null,
              appBar: AppBar(
                title: const Text('Еда'),
                actions: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          shape: const StadiumBorder()),
                      onPressed: () async => _createDish(state.products),
                      child: const Text('Создать позицию')),
                ],
              ),
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
                      children: state.tags
                          .map((e) => InkWell(
                              onTap: () {
                                setState(() {
                                  filterByTags.add(e);
                                });

                                widget.dBloc.add(FilterByTags(
                                    tags: filterByTags, allTags: state.tags));
                              },
                              child: TagItem(text: e)))
                          .toList(),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          'Фильтр:',
                          style: TextStyle(color: Colors.white),
                        ),
                        ...filterByTags
                            .map((e) => InkWell(
                                  onTap: () {
                                    setState(() {
                                      filterByTags.remove(e);
                                    });
                                    widget.dBloc.add(FilterByTags(
                                        tags: filterByTags,
                                        allTags: state.tags));
                                  },
                                  child: TagItem(text: e),
                                ))
                            .toList()
                      ],
                    ),
                    const SizedBox(height: 15),
                    if (state.dishes.isNotEmpty)
                      Expanded(
                        child: GridView.count(
                          primary: true,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          // childAspectRatio: 2,
                          children: state.dishes.map((x) {
                            if (widget.isSelectable) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedDishes.add(x.id);
                                  });
                                },
                                child: Container(
                                  color: selectedDishes.contains(x.id)
                                      ? Colors.amberAccent
                                      : null,
                                  child: DishItem(
                                    name: x.name,
                                    price: x.price,
                                    description: x.description,
                                    tags: x.tags,
                                    ingredients: x.ingredients,
                                    mediaId: x.mediaId,
                                  ),
                                ),
                              );
                            } else {
                              return InkWell(
                                onTap: () => _editDish(x, state.products),
                                child: DishItem(
                                  name: x.name,
                                  price: x.price,
                                  description: x.description,
                                  tags: x.tags,
                                  ingredients: x.ingredients,
                                  mediaId: x.mediaId,
                                ),
                              );
                            }
                          }).toList(),
                        ),
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
                      )
                  ],
                ),
              ),
            );
          } else if (state is DishLoading) {
            return const Center(child: CupertinoActivityIndicator(radius: 20));
          } else {
            return const SizedBox.shrink();
          }
        },
      );

  Future _createDish(List<ProductModel> products) async {
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
                  width: 500, child: CreateDishForm(products: products)),
            ));

    if (data == null) {
      return;
    }

    //TODO: где и кто будет заполнять список продуктов при создании блюда
    //TODO: мб блюдо создать просто так, а уже потом можно заредачить
    //TODO: добавив ему ингредиентов(хотя по факту эта операция простая)
    widget.dBloc.add(CreateDish(model: data));
  }

  Future _editDish(DishModel model, List<ProductModel> products) async {
    final data = await showDialog<DishModel>(
        context: context,
        builder: (context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              titlePadding: const EdgeInsets.symmetric(horizontal: 30),
              backgroundColor: const Color.fromARGB(255, 23, 23, 23),
              title: const Align(
                child: Text(
                  'Редактировать позицию',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              content: SizedBox(
                  width: 500,
                  child: EditDishForm(products: products, dish: model)),
            ));

    if (data == null) {
      return;
    }

    widget.dBloc.add(UpdateDish(model: data));
  }
}
