import 'package:booking_app/blocs/blocs.dart';
import 'package:booking_app/models/local/product_model.dart';
import 'package:booking_app/screens/products/widgets/create_product_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatefulWidget {
  final ProductBloc pBloc;
  const ProductsScreen({
    Key? key,
    required this.pBloc,
  }) : super(key: key);

  @override
  _DataTableExampleState createState() => _DataTableExampleState();
}

class _DataTableExampleState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) => BlocConsumer<ProductBloc, ProductState>(
        bloc: widget.pBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is ProductsLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Продукты'),
                actions: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          shape: const StadiumBorder()),
                      onPressed: _createProduct,
                      child: const Text('Создать продукт')),
                ],
              ),
              body: SingleChildScrollView(
                child: DataTable(
                  columnSpacing: 40,
                  columns: const [
                    DataColumn(
                        label: Text('Название',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Количество',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Мера',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))),
                  ],
                  rows: state.products
                      .map((x) => DataRow(cells: [
                            DataCell(Text(x.name,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15))),
                            DataCell(Text(x.amount.toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15))),
                            DataCell(Text(x.type,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15))),
                          ]))
                      .toList(),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );

  Future _createProduct() async {
    final data = await showDialog<ProductModel>(
        context: context,
        builder: (context) => const AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              titlePadding: EdgeInsets.symmetric(horizontal: 30),
              backgroundColor: Color.fromARGB(255, 23, 23, 23),
              title: Align(
                child: Text(
                  'Создать продукт',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              content: SizedBox(width: 500, child: CreateProductForm()),
            ));

    if (data == null) {
      return;
    }

    //TODO: где и кто будет заполнять список продуктов при создании блюда
    //TODO: мб блюдо создать просто так, а уже потом можно заредачить
    //TODO: добавив ему ингредиентов(хотя по факту эта операция простая)
    widget.pBloc.add(CreateProduct(product: data));
  }
}
