import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promart/promart.dart';

import 'package:simplemart/src/configs/theme/theme.dart';
import 'package:simplemart/src/features/promart/logic/bloc/bloc.dart';
import 'package:simplemart/src/features/promart/logic/bottom_bar_selector/bottom_bar_selector_cubit.dart';
import 'package:simplemart/src/features/promart/logic/cubit/promart_catalogue/promart_catalogue_cubit.dart';

import 'package:simplemart/src/features/promart/view/view.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PromartRepository(
        dataSource: RemoteDataSource(
          client: Dio(),
        ),
      ),
      child: const _AppBloc(),
    );
  }
}

class _AppBloc extends StatelessWidget {
  const _AppBloc();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PromartCatalogCubit>(
          create: (_) => PromartCatalogCubit(
            context.read<PromartRepository>(),
          )..loadCatalog(),
        ),
        BlocProvider(
          create: (context) => CartBloc(),
        ),
        BlocProvider(
          create: (context) => WishlistBloc(),
        ),
        BlocProvider(
          create: (context) => BottomBarSelectorCubit(),
        )
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      navigatorKey: _navigatorKey,
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (_) => SplashLoaderPage.go(),
    );
  }
}
