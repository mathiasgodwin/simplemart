import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promart/promart.dart';
import 'package:simplemart/src/features/promart/logic/logic.dart';
import 'package:simplemart/src/features/promart/view/view.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const WishlistPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Wish List',
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Icon(
              Icons.shopping_basket_outlined,
            ),
          ),
        ],
      ),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          final wishItems = state.items;
          return wishItems.isNotEmpty
              ? _WishlistListView(wishListItem: wishItems)
              : const Center(
                  child: Text('Your Wishlist is empty'),
                );
        },
      ),
    );
  }
}

class _WishlistListView extends StatelessWidget {
  const _WishlistListView({required this.wishListItem});
  final BuiltList<WishlistItem> wishListItem;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [for (final item in wishListItem) _WishlistItem(item: item)],
      ),
    );
  }
}

class _WishlistItem extends StatelessWidget {
  const _WishlistItem({required this.item});

  final WishlistItem item;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<WishlistBloc>();
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => bloc.add(WishAdded(product: item.product)),
          ),
          Expanded(
            child: SizedNetworkImage(
              imageUrl: item.product.image,
              imageWidth: 40,
              imageHeight: 40,
            ),
          ),
        ],
      ),
    );
  }
}
