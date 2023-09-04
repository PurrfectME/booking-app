import 'package:bloc/bloc.dart';
import 'package:booking_app/models/local/product_model.dart';
import 'package:booking_app/models/models.dart';
import 'package:booking_app/providers/hive_db.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductLoading()) {
    on<ProductEvent>((event, emit) async {
      if (event is ProductsLoad) {
        emit(ProductLoading());

        final products = await HiveProvider.getProducts();

        final productsList = products
            .map((x) =>
                ProductModel(name: x.name, amount: x.amount, type: x.type))
            .toList();

        emit(ProductsLoaded(products: productsList));
      } else if (event is CreateProduct) {
        await HiveProvider.createProduct(Product(
            name: event.product.name,
            amount: event.product.amount,
            type: event.product.type));

        final products = await HiveProvider.getProducts();

        final productsList = products
            .map((x) =>
                ProductModel(name: x.name, amount: x.amount, type: x.type))
            .toList();

        emit(ProductsLoaded(products: productsList));
      }
    });
  }
}
