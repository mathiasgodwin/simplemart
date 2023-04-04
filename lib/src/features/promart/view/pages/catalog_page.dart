import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promart/promart.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:simplemart/src/configs/theme/styles.dart';
import 'package:simplemart/src/features/promart/logic/logic.dart';
import 'package:simplemart/src/features/promart/view/view.dart';

/// TODO: Finish the docs
/// CatalogPage to...
class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

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
  const _BodyListView();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ScrollPhysics(),
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

        ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 40,
            maxHeight: 300,
          ),
          child: const _ImageCarousel(),
        ),
        VSpace.s25,
        const _AllProductsGrid(),
        //
      ],
    );
  }
}

class _ImageCarousel extends StatelessWidget {
  const _ImageCarousel();

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const BouncingScrollPhysics(),
      controller: PageController(
        viewportFraction: 0.7,
      ),
      children: [
        for (int i = 1; i <= 5; i++)
          Padding(
            padding: const EdgeInsets.all(8),
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
  const _AllProductsGrid();

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
            child: IconButton(
              color: theme.primaryColor,
              icon: const Icon(
                Icons.replay,
                size: 24,
              ),
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
  const _ProductGridWidget({
    required this.data,
  });
  final AllProductModel data;

  @override
  Widget build(BuildContext context) {
    return ResponsiveGridList(
      listViewBuilderOptions: ListViewBuilderOptions(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
      ),
      horizontalGridMargin: 1,
      verticalGridMargin: 1,
      minItemWidth: 150,
      maxItemsPerRow: 20,
      children: data.data.map(
        (item) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push<void>(ProductDetailsPage(item).route());
            },
            child: Card(
              child: Column(
                children: <Widget>[
                  Image.network(
                    item.image,
                    width: 150,
                    height: 100,
                  ),
                  ListTile(
                    isThreeLine: true,
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
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            item.title,
                            maxLines: 1,
                            softWrap: true,
                            style: const TextStyle(
                              fontSize: 12,
                              overflow: TextOverflow.clip,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '\$${item.price.toString().trim()}',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
