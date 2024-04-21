part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemModel> products;

  CartLoaded(this.products);
}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}