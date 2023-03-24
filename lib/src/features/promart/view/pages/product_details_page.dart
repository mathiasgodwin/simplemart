// ignore_for_file: strict_raw_type

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:simplemart/src/features/promart/logic/logic.dart';
import 'package:simplemart/src/features/promart/view/view.dart';
import 'package:promart/promart.dart';
import 'package:simplemart/src/configs/theme/styles.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage(this.productData, {super.key});
  final AllProductData productData;

  //
  Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => ProductDetailsPage(productData),
    );
  }

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GFButton(
            color: Colors.black,
            onPressed: () {
              context
                  .read<CartBloc>()
                  .add(ProductAdded(product: widget.productData));
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    content: Text('Item Added to Cart'),
                    duration: Duration(seconds: 1),
                  ),
                );
            },
            text: 'ADD TO CART',
          ),
          GFButton(
            color: theme.primaryColor,
            onPressed: () {
              context
                  .read<CartBloc>()
                  .add(ProductAdded(product: widget.productData));
              Navigator.of(context).push<void>(CartPage.route());
            },
            text: 'BUY NOW',
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: _ProductImageCard(data: widget.productData),
            ),
            VSpace.s25,
            Flexible(
              child: _ProductSubDetails(
                data: widget.productData,
              ),
            ),
            const Flexible(child: SizedBox(height: 10)),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: const [
                    Text(
                      'PRODUCT DESCRIPTION',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  widget.productData.description,
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductImageCard extends StatelessWidget {
  const _ProductImageCard({
    super.key,
    required this.data,
  });

  final AllProductData data;

  @override
  Widget build(BuildContext context) {
    return GFCard(
      padding: EdgeInsets.zero,
      image: Image.network(
        data.image,
        height: 250,
      ),
      showImage: true,
      title: GFListTile(
        padding: const EdgeInsets.only(top: 16),
        margin: EdgeInsets.zero,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GFIconButton(
              color: GFColors.TRANSPARENT,
              icon: const Icon(Icons.arrow_back_ios_rounded),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            GFIconButton(
              color: GFColors.TRANSPARENT,
              icon: const Icon(Icons.shopping_bag),
              onPressed: () {
                Navigator.of(context).push(CartPage.route());
              },
            )
          ],
        ),
      ),
      titlePosition: GFPosition.start,
    );
  }
}

class _ProductSubDetails extends StatelessWidget {
  const _ProductSubDetails({
    required this.data,
    super.key,
  });

  final AllProductData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  data.title,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              SizedBox(
                width: 200,
                child: Text(
                  data.title,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GFButton(
                    onPressed: () {},
                    color: Colors.green.withOpacity(0.1),
                    text: 'Extra ₦200 Off',
                    textStyle:
                        const TextStyle(fontSize: 10, color: Colors.black),
                    shape: GFButtonShape.pills,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  GFButton(
                    onPressed: () {},
                    color: Colors.red.withOpacity(0.1),
                    text: 'EMI Starts from ₦451',
                    textStyle: const TextStyle(fontSize: 10, color: Colors.red),
                    shape: GFButtonShape.pills,
                  ),
                ],
              ),
              BlocBuilder<WishlistBloc, WishlistState>(
                builder: (context, state) {
                  final wish = WishlistItem(product: data);

                  // Check if item is a favorite already
                  final isWished = state.items.contains(wish);
                  return GFIconButton(
                    key: const Key('GFIconbutton_wishlist_icon'),
                    shape: GFIconButtonShape.circle,
                    color: Colors.white,
                    icon: isWished
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : const Icon(
                            Icons.favorite_border,
                            color: Colors.grey,
                          ),
                    onPressed: () {
                      context.read<WishlistBloc>().add(
                            WishAdded(product: data),
                          );
                    },
                  );
                },
              )
            ],
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      '₦${data.price}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '₦${data.price}',
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                    ),
                  ],
                  // , breast cancer
                ),
                RichText(
                  text: const TextSpan(
                    text: '53% Off',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
