import 'package:booking_app/constants/constants.dart';
import 'package:booking_app/models/local/ingredient_model.dart';
import 'package:flutter/material.dart';

class SelectIngredientsForm extends StatefulWidget {
  final List<IngredientModel> ingredients;
  const SelectIngredientsForm({super.key, required this.ingredients});

  @override
  State<SelectIngredientsForm> createState() => _SelectIngredientsFormState();
}

class _SelectIngredientsFormState extends State<SelectIngredientsForm> {
  List<IngredientModel> selectedIngredients = [];

  @override
  Widget build(BuildContext context) => Container(
        width: double.maxFinite,
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.ingredients.length,
              itemBuilder: (context, index) {
                final ingredient = widget.ingredients[index];
                final isSelected = selectedIngredients.contains(ingredient);

                return ListTile(
                  title: Text(ingredient.name,
                      style: const TextStyle(color: Colors.white)),
                  trailing: isSelected
                      ? const Icon(Icons.check_box, color: Constants.mainPurple)
                      : const Icon(Icons.check_box_outline_blank,
                          color: Constants.mainPurple),
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedIngredients.remove(ingredient);
                      } else {
                        selectedIngredients.add(ingredient);
                      }
                    });
                  },
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, selectedIngredients);
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
}
