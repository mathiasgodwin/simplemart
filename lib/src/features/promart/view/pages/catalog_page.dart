import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:promart/promart.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:simplemart/src/configs/theme/styles.dart';
import 'package:simplemart/src/core/utils/utils.dart';
import 'package:simplemart/src/features/promart/logic/logic.dart';
import 'package:simplemart/src/features/promart/view/view.dart';

/// TODO: Finish the docs
/// CatalogPage to...
class CatalogPage extends StatelessWidget {
  const CatalogPage();

  /// Static named route for page
  static const String route = 'Catalog';

  /// Static method to return the widget as a PageRoute
  static Route go() =>
      MaterialPageRoute<void>(builder: (_) => const CatalogPage());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 1,
        leading: const SizedBox(),
        elevation: 0,
        backgroundColor: theme.primaryColor,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                'Promart!',
                style: TextStyle(
                  color: theme.colorScheme.onPrimary,
                  fontSize: kToolbarHeight * 0.4,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Flexible(
              child: Text("Let's go shopping"),
            ),
          ],
        ),
        actions: <Widget>[
          const IconButton(onPressed: null, icon: Icon(Icons.search_rounded)),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(CartPage.route());
            },
            icon: const Icon(Icons.shopping_basket_rounded),
          )
        ],
      ),
      body: const _BodyListView(),
    );
  }
}

class _BodyListView extends StatelessWidget {
  const _BodyListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: Insets.lg),
      children: <Widget>[
        //
        VSpace.s10,
        const Text(
          'New Arrival',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        VSpace.s10,
        const _ProductsAdsCarouselBig(),
        VSpace.s25,
        const _AllProductsGrid(),
        //
      ],
    );
  }
}

class _ProductsAdsCarouselBig extends StatelessWidget {
  const _ProductsAdsCarouselBig({super.key});

  @override
  Widget build(BuildContext context) {
    return GFCarousel(
      viewportFraction: 0.7,
      aspectRatio: 10 / 8,
      enableInfiniteScroll: false,
      scrollPhysics: const BouncingScrollPhysics(),
      items: <Widget>[
        for (int i = 1; i <= 5; i++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              child: Image.asset(
                'assets/images/carousel_landscape_$i.jpg',
                gaplessPlayback: true,
                fit: BoxFit.cover,
              ),
            ),
          ),
      ],
    );
  }
}

class _AllProductsGrid extends StatelessWidget {
  const _AllProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<PromartCatalogCubit, PromartCatalogState>(
      buildWhen: (prev, current) => prev != current,
      listener: (context, state) {
        if (state.status == PromartCatalogStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content:
                    Text(state.errorMessage ?? 'Could not load, try again'),
              ),
            );
        }
      },
      builder: (context, state) {
        if (state.status == PromartCatalogStatus.loaded) {
          return _ProductGridWidget(
            data: state.catalog!,
          );
        } else if (state.status == PromartCatalogStatus.loading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state.status == PromartCatalogStatus.failure) {
          return Center(
            child: GFIconButton(
              color: theme.primaryColor,
              shape: GFIconButtonShape.circle,
              size: GFSize.LARGE,
              icon: const Icon(Icons.replay),
              onPressed: () {
                context.read<PromartCatalogCubit>().loadCatalog();
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _ProductGridWidget extends StatelessWidget {
  final AllProductModel data;

  const _ProductGridWidget({
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveGridList(
      listViewBuilderOptions: ListViewBuilderOptions(
          shrinkWrap: true, physics: const ScrollPhysics()),
      horizontalGridSpacing: 16,
      verticalGridSpacing: 16,
      horizontalGridMargin: 1,
      verticalGridMargin: 1,
      minItemWidth: 150,
      minItemsPerRow: 1,
      maxItemsPerRow: 20,
      children: data.data.map(
        (item) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push<void>(ProductDetailsPage(item).route());
            },
            child: GFCard(
              padding: EdgeInsets.zero,
              image: Image.network(
                item.image,
                width: 150,
                height: 100,
              ),
              showImage: true,
              title: GFListTile(
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
                        fontWeight: FontWeight.w400,
                      ),
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
          );
        },
      ).toList(),
    );
  }
}
