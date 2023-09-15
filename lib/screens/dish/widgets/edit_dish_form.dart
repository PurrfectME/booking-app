import 'dart:io';

import 'package:booking_app/constants/constants.dart';
import 'package:booking_app/models/local/create_dish.dart';
import 'package:booking_app/models/local/dish_model.dart';
import 'package:booking_app/models/local/ingredient_model.dart';
import 'package:booking_app/models/local/product_model.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/screens/dish/widgets/select_ingredients_form.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class EditDishForm extends StatefulWidget {
  final DishModel dish;
  final List<ProductModel> products;
  const EditDishForm({
    super.key,
    required this.products,
    required this.dish,
  });

  @override
  State<EditDishForm> createState() => _EditDishFormState();
}

class _EditDishFormState extends State<EditDishForm> {
  bool isHovered = false;
  final _formKey = GlobalKey<FormState>();

  late DishModel localDish;

  @override
  void initState() {
    localDish = widget.dish.copyWith();

    widget.dish.ingredients.map((e) {
      amountControllers[e.name] = TextEditingController(text: e.amount);
    }).toList();

    super.initState();
  }

  Map<String, TextEditingController> amountControllers = {};

  @override
  void dispose() {
    amountControllers.forEach((key, value) {
      amountControllers[key]!.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      initialValue: localDish.name,
                      keyboardType: TextInputType.text,
                      onSaved: (newValue) {
                        localDish = localDish.copyWith(name: newValue!);
                      },
                      decoration: InputDecoration(
                        labelText: 'Название позиции',
                        floatingLabelStyle:
                            const TextStyle(color: Colors.white),
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 66, 66, 66)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: Constants.mainPurple, width: 2)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 66, 66, 66), width: 2),
                        ),
                      ),
                      // onChanged: phoneNumberOnChange,
                      // The validator receives the text that the user has entered.
                      // validator: validatePhoneNumber),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      initialValue: localDish.price.toString(),
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      onSaved: (newValue) {
                        localDish.price = double.parse(newValue!);
                      },
                      decoration: InputDecoration(
                        labelText: 'Цена',
                        floatingLabelStyle:
                            const TextStyle(color: Colors.white),
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 66, 66, 66)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: Constants.mainPurple, width: 2)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 66, 66, 66), width: 2),
                        ),
                      ),
                      // onChanged: phoneNumberOnChange,
                      // The validator receives the text that the user has entered.
                      // validator: validatePhoneNumber),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      initialValue: localDish.tags.map((e) => e.name).join(' '),
                      keyboardType: TextInputType.text,
                      onSaved: (newValue) {
                        final separated = newValue!.split(' ');
                        localDish = localDish.copyWith(
                            tags: separated
                                .map((e) => Tag(id: 0, name: e))
                                .toList());
                      },
                      decoration: InputDecoration(
                        labelText: 'Теги для поиска',
                        floatingLabelStyle:
                            const TextStyle(color: Colors.white),
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 66, 66, 66)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: Constants.mainPurple, width: 2)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 66, 66, 66), width: 2),
                        ),
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 66, 66, 66)),
                        hintText: 'Вводить через пробел',
                      ),
                      // onChanged: phoneNumberOnChange,
                      // The validator receives the text that the user has entered.
                      // validator: validatePhoneNumber),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      initialValue: localDish.description,
                      keyboardType: TextInputType.text,
                      onSaved: (newValue) {
                        localDish = localDish.copyWith(description: newValue!);
                      },
                      decoration: InputDecoration(
                        labelText: 'Описание',
                        floatingLabelStyle:
                            const TextStyle(color: Colors.white),
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 66, 66, 66)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: Constants.mainPurple, width: 2)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 66, 66, 66), width: 2),
                        ),
                      ),
                      // onChanged: phoneNumberOnChange,
                      // The validator receives the text that the user has entered.
                      // validator: validatePhoneNumber),
                    ),
                    const SizedBox(height: 20),
                    DataTable(
                      columns: const [
                        DataColumn(
                          label: Text(
                            'Название',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Количество',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(''),
                        ),
                      ],
                      rows: localDish.ingredients
                          .map((x) => DataRow(cells: [
                                DataCell(Text(x.name,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15))),
                                DataCell(
                                  TextField(
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                                color: Constants.mainPurple,
                                                width: 2)),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 66, 66, 66),
                                              width: 2),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        final d = localDish.copyWith();
                                        final ingrs = d.ingredients;
                                        ingrs
                                            .firstWhere((e) => x.name == e.name)
                                            .amount = value;

                                        setState(() {
                                          localDish = localDish.copyWith(
                                              ingredients: ingrs);
                                        });
                                      },
                                      controller: amountControllers[x.name]),
                                ),
                                DataCell(
                                  IconButton(
                                    icon: const Icon(Icons.delete_forever,
                                        color: Colors.white),
                                    onPressed: () {
                                      setState(() {
                                        localDish = localDish.copyWith(
                                          ingredients: localDish.ingredients
                                              .where((ingredient) =>
                                                  ingredient != x)
                                              .toList(),
                                        );
                                      });
                                    },
                                  ),
                                ),
                              ]))
                          .toList(),
                    ),
                    ElevatedButton(
                      onPressed: () async => await _addIngredient(
                        widget.products,
                        localDish.ingredients,
                      ),
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          disabledForegroundColor:
                              const Color.fromARGB(255, 155, 155, 155),
                          backgroundColor: Constants.mainPurple,
                          disabledBackgroundColor:
                              const Color.fromARGB(255, 45, 45, 45),
                          shape: const StadiumBorder()),
                      child: const SizedBox(
                          height: 50,
                          width: 150,
                          child: Center(
                              child: Text('Выбрать ингредиенты',
                                  style: TextStyle(fontSize: 20)))),
                    ),
                    const SizedBox(height: 20),
                    MouseRegion(
                      onEnter: (_) {
                        setState(() {
                          isHovered = true;
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          isHovered = false;
                        });
                      },
                      child: Stack(children: [
                        if (localDish.mediaId.isNotEmpty)
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
                                  image: FileImage(File(localDish.mediaId))),
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
                                  fit: BoxFit.fill,
                                  image: AssetImage('assets/images/neft.jpg')),
                            ),
                          ),
                        if (isHovered)
                          Positioned.fill(
                            child: InkWell(
                              onTap: _selectAndReplaceImage,
                              child: const Icon(Icons.camera_alt, size: 100),
                            ),
                          ),
                      ]),
                    ),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _formKey.currentState!.save();
              Navigator.pop(context, localDish);
            },
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                disabledForegroundColor:
                    const Color.fromARGB(255, 155, 155, 155),
                backgroundColor: Constants.mainPurple,
                disabledBackgroundColor: const Color.fromARGB(255, 45, 45, 45),
                shape: const StadiumBorder()),
            child: const SizedBox(
                height: 50,
                width: 150,
                child: Center(
                    child: Text('Сохранить', style: TextStyle(fontSize: 20)))),
          ),
        ],
      );

  Future _selectAndReplaceImage() async {
    const typeGroup = XTypeGroup(
      label: 'images',
      extensions: ['jpg', 'png'],
    );
    final file = await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);

    if (file != null) {
      setState(() {
        localDish = localDish.copyWith(mediaId: file.path);
      });
    }
  }

  Future _addIngredient(
      List<ProductModel> list, List<IngredientModel> selected) async {
    final data = await showDialog<List<IngredientModel>>(
        context: context,
        builder: (context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              titlePadding: const EdgeInsets.symmetric(horizontal: 30),
              backgroundColor: const Color.fromARGB(255, 23, 23, 23),
              title: const Align(
                child: Text(
                  'Выберите ингредиенты',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              content: SizedBox(
                  width: 500,
                  child: SelectIngredientsForm(
                      products: list, selected: selected)),
            ));

    if (data == null) {
      return;
    }

    setState(() {
      localDish = localDish.copyWith(ingredients: data);

      data.map((e) {
        amountControllers[e.name] = TextEditingController(text: e.amount);
      }).toList();
    });
  }
}
