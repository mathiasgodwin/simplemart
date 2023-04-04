import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promart/promart.dart';
import 'package:simplemart/src/features/promart/logic/logic.dart';
import 'package:simplemart/src/features/promart/view/view.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const CartPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cart',
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Icon(
              Icons.shopping_cart_checkout_rounded,
            ),
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final cartItems = state.items;

          return cartItems.isNotEmpty
              ? _CartListView(cartItems: cartItems)
              : const Center(child: Text('Your cart is empty'));
        },
      ),
    );
  }
}

class _CartListView extends StatelessWidget {
  const _CartListView({required this.cartItems});

  final BuiltList<CartItem> cartItems;
  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + item.count * item.product.price);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          for (final item in cartItems) _CartListItem(item: item),
        ],
      ),
    );
  }
}

class _CartListItem extends StatelessWidget {
  const _CartListItem({required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<CartBloc>();
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => bloc.add(CartItemRemoved(item: item)),
          ),
          Expanded(
            child: SizedNetworkImage(
              imageUrl: item.product.image,
              imageWidth: 40,
              imageHeight: 40,
            ),
          ),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => bloc.add(CartItemCountIncreased(item: item)),
              ),
              Text(
                '${item.count}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () => bloc.add(CartItemCountDecreased(item: item)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
