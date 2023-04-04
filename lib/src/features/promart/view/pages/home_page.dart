import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplemart/src/features/promart/logic/bottom_bar_selector/bottom_bar_selector_cubit.dart';
import 'package:simplemart/src/features/promart/view/view.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const List<Widget> pages = [
    CatalogPage(),
    WishlistPage(),
    CartPage(),
    UserAccountPage(),
  ];
  @override
  Widget build(BuildContext context) {
    //
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final bottomBar =
        context.select((BottomBarSelectorCubit cubit) => cubit.state);
    final bottomBarCubit = context.read<BottomBarSelectorCubit>();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          switch (value) {
            case 0:
              bottomBarCubit.setBar(HomeBottomBar.home);
              break;
            case 1:
              bottomBarCubit.setBar(HomeBottomBar.wishList);
              break;
            case 2:
              bottomBarCubit.setBar(HomeBottomBar.cart);
              break;
            case 3:
              bottomBarCubit.setBar(HomeBottomBar.userAccount);
              break;
            default:
          }
        },
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.onSurface,
        unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
        selectedLabelStyle: textTheme.bodySmall,
        unselectedLabelStyle: textTheme.bodySmall,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home_filled),
          ),
          BottomNavigationBarItem(
            label: 'Wishlist',
            icon: Icon(Icons.shopping_basket),
          ),
          BottomNavigationBarItem(
            label: 'Carts',
            icon: Icon(Icons.shopping_cart),
          ),
          BottomNavigationBarItem(
            label: 'Account',
            icon: Icon(Icons.person),
          ),
        ],
        currentIndex: bottomBarCubit.state.bottomBars.index,
      ),
      body: pages[bottomBarCubit.state.bottomBars.index],
    );
  }
}
