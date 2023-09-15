import 'package:booking_app/constants/constants.dart';
import 'package:booking_app/models/local/create_dish.dart';
import 'package:booking_app/models/local/ingredient_model.dart';
import 'package:booking_app/models/local/product_model.dart';
import 'package:booking_app/screens/dish/widgets/select_ingredients_form.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';

import '../../../widgets/tag_item.dart';

class CreateDishForm extends StatefulWidget {
  final List<ProductModel> products;
  const CreateDishForm({super.key, required this.products});

  @override
  State<CreateDishForm> createState() => _CreateDishFormState();
}

class _CreateDishFormState extends State<CreateDishForm> {
  final _formKey = GlobalKey<FormState>();

  late String name;
  late double price;
  late List<String> tags;
  late String description;
  late String mediaId;
  List<IngredientModel> selectedIngredients = [];

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
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      initialValue: '',
                      keyboardType: TextInputType.text,
                      onSaved: (newValue) {
                        name = newValue!;
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
                      initialValue: '',
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      onSaved: (newValue) {
                        price = double.parse(newValue!);
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
                      initialValue: '',
                      keyboardType: TextInputType.text,
                      onSaved: (newValue) {
                        final separated = newValue!.split(' ');
                        tags = separated;
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
                      initialValue: '',
                      keyboardType: TextInputType.text,
                      onSaved: (newValue) {
                        description = newValue!;
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
                      ],
                      rows: selectedIngredients
                          .map((x) => DataRow(cells: [
                                DataCell(Text(x.name,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15))),
                                DataCell(TextField(
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                              color: Constants.mainPurple,
                                              width: 2)),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                            color:
                                                Color.fromARGB(255, 66, 66, 66),
                                            width: 2),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedIngredients
                                            .firstWhere((e) => x.name == e.name)
                                            .amount = value;
                                      });
                                    },
                                    controller: amountControllers[x.name])),
                              ]))
                          .toList(),
                    ),
                    ElevatedButton(
                      onPressed: () async => await _addIngredient(
                        widget.products,
                        selectedIngredients,
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
                    InkWell(
                      onTap: _selectAndReplaceImage,
                      child: const Icon(Icons.camera_alt, size: 100),
                    ),
                  ],
                ),
              ),
            ),
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
                      mediaId: mediaId));
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
                    child: Text('Создать', style: TextStyle(fontSize: 20)))),
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
        mediaId = file.path;
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
      selectedIngredients = data;

      data.map((e) {
        amountControllers[e.name] = TextEditingController(text: e.amount);
      }).toList();
    });
  }
}
