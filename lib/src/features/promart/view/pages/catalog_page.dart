import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
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
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: Insets.lg),
      children: <Widget>[
        VSpace.s10,
        const Text(
          'Electronics',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        VSpace.s10,
        const ProductByCategoryName(category: 'electronics'),
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
  const _ProductsAdsCarouselBig({Key? key}) : super(key: key);

  // ignore: avoid_field_initializers_in_const_classes
  final List<String> _imagePath = const [
    'carousel_landscape_1',
    'carousel_landscape_2',
    'carousel_landscape_3',
    'carousel_landscape_4',
    'carousel_landscape_5',
  ];
  @override
  Widget build(BuildContext context) {
    return GFCarousel(
      viewportFraction: 0.7,
      aspectRatio: 10 / 8,
      enableInfiniteScroll: false,
      scrollPhysics: const BouncingScrollPhysics(),
      items: <Widget>[
        for (final item in _imagePath)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              child: Image.asset(
                'assets/images/$item.jpg',
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
  const _AllProductsGrid({Key? key}) : super(key: key);

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
        } else if (state.status == PromartCatalogStatus.loaded) {}
      },
      builder: (context, state) {
        if (state.status == PromartCatalogStatus.loaded) {
          return _ProductGridWidget(
            state: state,
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
  final PromartCatalogState state;

  const _ProductGridWidget({
    required this.state,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
      ),
      itemCount: state.catalog!.data.length,
      itemBuilder: (BuildContext context, int index) {
        final item = state.catalog!.data[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push<void>(ProductDetailsPage(item).route());
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
    );
  }
}
