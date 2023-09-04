import 'package:booking_app/constants/constants.dart';
import 'package:booking_app/models/local/ingredient_model.dart';
import 'package:booking_app/models/local/product_model.dart';
import 'package:flutter/material.dart';

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
  Map<String, String> selectedIngredientsWithAmount = {};

  Map<String, TextEditingController> amountControllers = {};

  @override
  void dispose() {
    amountControllers.forEach((key, value) {
      amountControllers[key]!.dispose();
    });

    super.dispose();
  }

  @override
  void initState() {
    widget.selected.map((e) {
      selectedIngredientsWithAmount[e.name] = e.amount;

      amountControllers[e.name] = TextEditingController(text: e.amount);
    }).toList();

    widget.products.map((e) {
      if (!selectedIngredientsWithAmount.containsKey(e.name)) {
        amountControllers[e.name] = TextEditingController();
      }
    }).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
        width: double.maxFinite,
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.products.length,
              itemBuilder: (context, index) {
                final product = widget.products[index];
                final ingredient = IngredientModel(
                  name: product.name,
                  amount: product.amount.toString(),
                );

                final isSelected =
                    selectedIngredientsWithAmount.containsKey(ingredient.name);

                return ListTile(
                  title: Row(
                    children: [
                      Text(ingredient.name,
                          style: const TextStyle(color: Colors.white)),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          controller: amountControllers[ingredient.name],
                          style: const TextStyle(color: Colors.white),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Количество',
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
                                  color: Color.fromARGB(255, 66, 66, 66),
                                  width: 2),
                            ),
                          ),
                          enabled: isSelected,
                          onChanged: (text) {
                            final amount = double.tryParse(text) ?? 0;
                            _updateAmount(ingredient.name, amount);
                          },
                        ),
                      )
                    ],
                  ),
                  trailing: isSelected
                      ? const Icon(Icons.check_box, color: Constants.mainPurple)
                      : const Icon(Icons.check_box_outline_blank,
                          color: Constants.mainPurple),
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedIngredientsWithAmount.remove(ingredient.name);
                        amountControllers[ingredient.name]!.clear();
                      } else {
                        amountControllers[ingredient.name]!.text =
                            selectedIngredientsWithAmount[ingredient]
                                    ?.toString() ??
                                '';
                        selectedIngredientsWithAmount[ingredient.name] = '0';
                      }
                    });
                  },
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                final result = <IngredientModel>[];

                selectedIngredientsWithAmount.forEach((key, value) => result
                    .add(IngredientModel(name: key, amount: value.toString())));

                Navigator.pop(context, result);
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

  void _updateAmount(String name, double amount) {
    setState(() {
      if (amount > 0) {
        selectedIngredientsWithAmount[name] = amount.toString();
      } else {
        selectedIngredientsWithAmount.remove(name);
      }
    });
  }
}
