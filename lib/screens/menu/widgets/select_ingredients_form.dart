import 'package:booking_app/constants/constants.dart';
import 'package:booking_app/models/local/ingredient_model.dart';
import 'package:booking_app/models/local/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SelectIngredientsForm extends StatefulWidget {
  final List<ProductModel> products;
  final List<IngredientModel> selected;
  const SelectIngredientsForm({
    super.key,
    required this.products,
    required this.selected,
  });

  @override
  State<SelectIngredientsForm> createState() => _SelectIngredientsFormState();
}

class _SelectIngredientsFormState extends State<SelectIngredientsForm> {
  //TODO: make MAP instead of array to improve performance
  List<IngredientModel> selectedIngredientsWithAmount = [];

  final TextEditingController _typeAheadController = TextEditingController();

  Map<String, TextEditingController> amountControllers = {};

  @override
  void dispose() {
    amountControllers.forEach((key, value) {
      amountControllers[key]!.dispose();
    });
    _typeAheadController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    widget.selected.map((e) {
      selectedIngredientsWithAmount.add(e);
      amountControllers[e.name] = TextEditingController(text: e.amount);
    }).toList();

    widget.products.map((e) {
      if (!selectedIngredientsWithAmount.any((x) => x.name == e.name)) {
        amountControllers[e.name] = TextEditingController();
      }
    }).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                style: const TextStyle(color: Colors.white),
                controller: _typeAheadController,
                decoration: InputDecoration(
                  labelText: 'Искать ингредиент',
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
              ),
              //TODO: убрать из поиска уже добавленные ингредиенты
              suggestionsCallback: (pattern) => widget.products.where(
                  (product) => product.name
                      .toLowerCase()
                      .contains(pattern.toLowerCase())),
              itemBuilder: (context, suggestion) => ListTile(
                title: Text(suggestion.name),
              ),
              onSuggestionSelected: (suggestion) {
                _typeAheadController.text = suggestion.name;
                _addIngredient(suggestion);
              },
            ),
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
              rows: selectedIngredientsWithAmount
                  .map((x) => DataRow(cells: [
                        DataCell(Text(x.name,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15))),
                        DataCell(TextField(
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      color: Constants.mainPurple, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 66, 66, 66),
                                    width: 2),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                selectedIngredientsWithAmount
                                    .firstWhere((e) => x.name == e.name)
                                    .amount = value;
                              });
                            },
                            controller: amountControllers[x.name])),
                      ]))
                  .toList(),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, selectedIngredientsWithAmount);
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
                      child:
                          Text('Сохранить', style: TextStyle(fontSize: 20)))),
            ),
          ],
        ),
      );

  void _addIngredient(ProductModel product) {
    setState(() {
      selectedIngredientsWithAmount
          .add(IngredientModel(name: product.name, amount: '0'));
    });
  }
}
