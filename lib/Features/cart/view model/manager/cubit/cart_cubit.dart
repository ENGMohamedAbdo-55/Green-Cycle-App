import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../model/cartmodel.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
}
