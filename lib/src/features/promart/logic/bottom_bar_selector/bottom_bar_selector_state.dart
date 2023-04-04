part of 'bottom_bar_selector_cubit.dart';

enum HomeBottomBar { home, wishList, cart, userAccount }

class BottomBarSelectorState extends Equatable {
  const BottomBarSelectorState({
    this.bottomBars = HomeBottomBar.home,
  });

  final HomeBottomBar bottomBars;
  @override
  List<Object> get props => [bottomBars];
}
