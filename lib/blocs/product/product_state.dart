part of 'product_bloc.dart';

class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {}

class ProductsLoaded extends ProductState {
  final List<ProductModel> products;
  const ProductsLoaded({
    required this.products,
  });

  @override
  List<Object> get props => [products];
}
