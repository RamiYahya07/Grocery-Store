import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rw_test/features/home/presentation/viewModels/shops_cubit.dart';

class HomeViewAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeViewAppBar({super.key});

  @override
  State<HomeViewAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
class _HomeAppBarState extends State<HomeViewAppBar> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: _isSearching
          ? TextField(
              controller: _searchController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: "Search shops...",
                border: InputBorder.none,
              ),
              onChanged: (value) {
                context.read<ShopsCubit>().search(value);
              },
            )
          : const Text('Grocery Store'),

      actions: [
        // SEARCH 
        IconButton(
          icon: Icon(_isSearching ? Icons.close : Icons.search),
          onPressed: () {
            setState(() {
              _isSearching = !_isSearching;

              if (!_isSearching) {
                _searchController.clear();
                context.read<ShopsCubit>().search('');
              }
            });
          },
        ),

        // SORT MENU
        PopupMenuButton<SortType>(
          icon: const Icon(Icons.sort),
          onSelected: (value) {
            context.read<ShopsCubit>().changeSort(value);
          },
          itemBuilder: (context) => const [
            PopupMenuItem(
              value: SortType.eta,
              child: Text("Sort by ETA"),
            ),
            PopupMenuItem(
              value: SortType.minimumOrder,
              child: Text("Sort by Minimum Order"),
            ),
          ],
        ),

        // FILTER
        BlocBuilder<ShopsCubit, GetAllShopsState>(
          builder: (context, state) {
            if (state is GetAllShopsSuccess) {
              return IconButton(
                icon: Icon(
                  state.openOnly
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                ),
                tooltip: "Open Only",
                onPressed: () {
                  context
                      .read<ShopsCubit>()
                      .toggleOpenOnly(!state.openOnly);
                },
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}