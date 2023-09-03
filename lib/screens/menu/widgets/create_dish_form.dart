import 'package:booking_app/constants/constants.dart';
import 'package:booking_app/models/local/create_dish.dart';
import 'package:booking_app/models/local/ingredient_model.dart';
import 'package:booking_app/screens/menu/widgets/select_ingredients_form.dart';
import 'package:flutter/material.dart';

import '../../../widgets/tag_item.dart';

class CreateDishForm extends StatefulWidget {
  final List<IngredientModel> ingredients;
  const CreateDishForm({super.key, required this.ingredients});

  @override
  State<CreateDishForm> createState() => _CreateDishFormState();
}

class _CreateDishFormState extends State<CreateDishForm> {
  final _formKey = GlobalKey<FormState>();

  late String name;
  late double price;
  late List<String> tags;
  late String description;
  late List<IngredientModel> selectedIngredients;

  @override
  Widget build(BuildContext context) => Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  initialValue: '',
                  keyboardType: TextInputType.text,
                  onSaved: (newValue) {
                    name = newValue!;
                  },
                  decoration: InputDecoration(
                    labelText: 'Название позиции',
                    floatingLabelStyle: const TextStyle(color: Colors.white),
                    labelStyle:
                        const TextStyle(color: Color.fromARGB(255, 66, 66, 66)),
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
                  initialValue: '',
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  onSaved: (newValue) {
                    price = double.parse(newValue!);
                  },
                  decoration: InputDecoration(
                    labelText: 'Цена',
                    floatingLabelStyle: const TextStyle(color: Colors.white),
                    labelStyle:
                        const TextStyle(color: Color.fromARGB(255, 66, 66, 66)),
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
                  initialValue: '',
                  keyboardType: TextInputType.text,
                  onSaved: (newValue) {
                    final separated = newValue!.split(' ');
                    tags = separated;
                  },
                  decoration: InputDecoration(
                    labelText: 'Теги для поиска',
                    floatingLabelStyle: const TextStyle(color: Colors.white),
                    labelStyle:
                        const TextStyle(color: Color.fromARGB(255, 66, 66, 66)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                            color: Constants.mainPurple, width: 2)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 66, 66, 66), width: 2),
                    ),
                    hintStyle:
                        const TextStyle(color: Color.fromARGB(255, 66, 66, 66)),
                    hintText: 'Вводить через пробел',
                  ),
                  // onChanged: phoneNumberOnChange,
                  // The validator receives the text that the user has entered.
                  // validator: validatePhoneNumber),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  initialValue: '',
                  keyboardType: TextInputType.text,
                  onSaved: (newValue) {
                    final separated = newValue!.split(' ');
                    tags = separated;
                  },
                  decoration: InputDecoration(
                    labelText: 'Описание',
                    floatingLabelStyle: const TextStyle(color: Colors.white),
                    labelStyle:
                        const TextStyle(color: Color.fromARGB(255, 66, 66, 66)),
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
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                        width: 2, color: const Color.fromARGB(255, 45, 45, 45)),
                    color: const Color.fromARGB(255, 23, 23, 23),
                  ),
                  child: Row(
                    children: selectedIngredients
                        .map((x) => TagItem(text: x.name))
                        .toList(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final list = [
                      IngredientModel(id: 0, name: "meat", amount: "2"),
                      IngredientModel(id: 1, name: "carrot", amount: "2"),
                      IngredientModel(id: 2, name: "look", amount: "2"),
                      IngredientModel(id: 3, name: "fish", amount: "2")
                    ];
                    //TODO: selectedIngredients.isNotEmpty ? selectedIngredients : widget.ingredients
                    _addIngredient(
                        widget.ingredients.isEmpty ? list : widget.ingredients);
                  },
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
              ],
            ),
            ElevatedButton(
              onPressed: () {
                _formKey.currentState!.save();
                Navigator.pop(
                    context,
                    CreateDishModel(
                        name: name,
                        price: price,
                        tags: tags,
                        description: description,
                        ingredients: selectedIngredients,
                        mediaId: "mediaID"));
              },
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
                      child: Text('Создать', style: TextStyle(fontSize: 20)))),
            ),
          ],
        ),
      );

  Future _addIngredient(List<IngredientModel> list) async {
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
                  width: 500, child: SelectIngredientsForm(ingredients: list)),
            ));

    if (data == null) {
      return;
    }

    setState(() {
      selectedIngredients = data;
    });
  }
}
