import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:simplemart/src/features/promart/logic/logic.dart';
import 'package:simplemart/src/features/promart/view/view.dart';

class ProductByCategoryName extends StatelessWidget {
  final String? category;
  const ProductByCategoryName({required this.category, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<ProductsByCategoriesCubit, ProductsByCategoriesState>(
      buildWhen: (prev, current) => prev != current,
      listener: (context, state) {
        if (state.status == ProductByCategoriesStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(state.errorMessage ?? 'Could not load, try again'),
            ));
        } else if (state.status == ProductByCategoriesStatus.loading) {}
      },
      builder: (context, state) {
        if (state.status == ProductByCategoriesStatus.loaded) {
          return Container(
            color: theme.cardColor,
            margin: const EdgeInsets.only(left: 8, right: 8),
            height: 270,
            width: double.infinity,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.products!.data.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var item = state.products!.data[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push<void>(ProductDetailsPage(item).route());
                  },
                  child: SizedBox(
                    width: 0.2,
                    child: GFCard(
                      image: Image.network(
                        item.image,
                        width: 150,
                        height: 150,
                      ),
                      showImage: true,
                      title: GFListTile(
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        title: Text(
                          item.title,
                          maxLines: 1,
                          softWrap: true,
                          style: const TextStyle(
                            overflow: TextOverflow.clip,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subTitle: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              item.title,
                              maxLines: 1,
                              softWrap: true,
                              style: const TextStyle(
                                  fontSize: 12,
                                  overflow: TextOverflow.clip,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '\$${item.price.toString()}',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state.status == ProductByCategoriesStatus.loading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state.status == ProductByCategoriesStatus.failure) {
          return Center(
            child: GFIconButton(
              color: theme.primaryColor,
              shape: GFIconButtonShape.circle,
              size: GFSize.LARGE,
              icon: const Icon(Icons.replay),
              onPressed: () {
                context
                    .read<ProductsByCategoriesCubit>()
                    .getProductsByCategory('electronics');
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
