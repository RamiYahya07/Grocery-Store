import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rw_test/features/home/presentation/viewModels/shops_cubit.dart';
import 'package:rw_test/features/home/presentation/views/widgets/shop_card.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeViewBody> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ShopsCubit>(context).getAllShops();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopsCubit, GetAllShopsState>(
      builder: (context, state) {
        if (state is GetAllShopsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GetAllShopsFailure) {
          return Center(
            child: Text(
              state.errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (state is GetAllShopsSuccess) {
          //  No Results State
          if (state.filteredShops.isEmpty) {
            return const Center(
              child: Text("No shops found", style: TextStyle(fontSize: 18)),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: state.filteredShops.length,
            itemBuilder: (context, index) {
              final shop = state.filteredShops[index];
              return ShopCard(shop: shop);
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
