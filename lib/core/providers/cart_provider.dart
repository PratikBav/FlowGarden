import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/cart_item.dart';
import '../../models/product.dart';

class CartNotifier extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() => [];

  void addProduct(Product product) {
    final existingIndex = state.indexWhere((item) => item.product.id == product.id);
    if (existingIndex >= 0) {
      final updatedList = [...state];
      final item = updatedList[existingIndex];
      updatedList[existingIndex] = item.copyWith(quantity: item.quantity + 1);
      state = updatedList;
    } else {
      state = [...state, CartItem(product: product)];
    }
  }

  void removeProduct(String productId) {
    state = state.where((item) => item.product.id != productId).toList();
  }

  void updateQuantity(String productId, int newQuantity) {
    if (newQuantity <= 0) {
      removeProduct(productId);
      return;
    }
    state = [
      for (final item in state)
        if (item.product.id == productId)
          item.copyWith(quantity: newQuantity)
        else
          item
    ];
  }

  void clearCart() {
    state = [];
  }

  double get totalPrice {
    return state.fold(0, (total, item) => total + item.totalPrice);
  }
}

final cartProvider = NotifierProvider<CartNotifier, List<CartItem>>(() {
  return CartNotifier();
});
