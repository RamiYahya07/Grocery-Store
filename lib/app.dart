import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rw_test/core/api.dart';
import 'package:rw_test/features/home/presentation/viewModels/shops_cubit.dart';
import 'package:rw_test/features/home/data/repos/shop_repository.dart';
import 'package:rw_test/features/home/presentation/views/home_view.dart';

class GroceryStoreApp extends StatelessWidget {
  const GroceryStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopsCubit(repository: ShopRepository(api: Api())),
      child: MaterialApp(
        title: 'Grocery Store App',
        home: HomeView(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
