import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/local/create_category.dart';
import 'package:booking_app/screens/menu/widgets/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/food/food_bloc.dart';
import 'widgets/create_category_form.dart';

class MenuScreen extends StatefulWidget {
  final MenuBloc mBloc;
  final FoodBloc fBloc;
  const MenuScreen({
    Key? key,
    required this.mBloc,
    required this.fBloc,
  }) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) => BlocConsumer<MenuBloc, MenuState>(
        bloc: widget.mBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is MenuLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Меню'),
                actions: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          shape: const StadiumBorder()),
                      onPressed: () => _createCategory(state.placeId),
                      child: const Text('Создать категорию')),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(15),
                child: state.categories.isNotEmpty
                    ? GridView.count(
                        crossAxisCount: 3,
                        children: state.categories
                            .map((x) => CategoryItem(
                                  name: x.name,
                                  categoryId: x.id,
                                  bloc: widget.fBloc,
                                  placeId: state.placeId,
                                ))
                            .toList(),
                      )
                    : const Center(
                        child: Text(
                          'Нет категорий',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
              ),
            );
          } else {
            return SizedBox(child: Text('ASDASDASD'));
          }
        },
      );

  Future _createCategory(int placeId) async {
    final data = await showDialog<CreateCategoryModel>(
        context: context,
        builder: (context) => const AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              titlePadding: EdgeInsets.symmetric(horizontal: 30),
              backgroundColor: Color.fromARGB(255, 23, 23, 23),
              title: Align(
                child: Text(
                  'Создать категорию',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              content: SizedBox(
                  height: 350, width: 500, child: CreateCategoryForm()),
            ));

    if (data == null) {
      return;
    }

    widget.mBloc.add(CreateCategory(name: data.name, placeId: placeId));
  }
}
