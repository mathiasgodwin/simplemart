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
  static Route go() => MaterialPageRoute<void>(builder: (_) => CatalogPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const ValueKey<int>(0),
        leadingWidth: 1,
        leading: const SizedBox(),
        elevation: 0,
        backgroundColor: Colors.purple,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Promart!',
              style: TextStyle(
                color: Colors.white,
                fontSize: kToolbarHeight * 0.4,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: kToolbarHeight * 0.08,
            ),
            Text("Let's go shopping", style: TextStyle()),
          ],
        ),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded)),
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
      children: <Widget>[
        VSpace.s10,

        const _RowDivider('Electronics'),
        VSpace.s10,
        const ProductByCategoryName(category: 'electronics'),
        //
        VSpace.s10,
        const _RowDivider('New Arrival'),
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
              borderRadius: BorderRadius.all(
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

class _RowDivider extends StatelessWidget {
  const _RowDivider(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          GFButton(
            onPressed: () {},
            text: 'MORE',
            color: Colors.purple,
          )
        ],
      ),
    );
  }
}

class _AllProductsGrid extends StatelessWidget {
  const _AllProductsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _w = size(context).width;
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
          return Center(
            child: GFShimmer(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 46,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: Colors.white,
                            height: 8,
                            width: double.infinity,
                          ),
                          const SizedBox(height: 6),
                          Container(
                            color: Colors.white,
                            height: 8,
                            width: _w * 0.5,
                          ),
                          const SizedBox(height: 6),
                          Container(
                            color: Colors.white,
                            height: 8,
                            width: _w * 0.25,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else if (state.status == PromartCatalogStatus.failure) {
          return Center(
            child: GFIconButton(
              color: Colors.purple,
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
