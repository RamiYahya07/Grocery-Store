import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rw_test/features/home/data/models/shop_model.dart';
import 'package:rw_test/features/home/data/repos/shop_repository.dart';

part 'shops_state.dart';

class ShopsCubit extends Cubit<GetAllShopsState> {
 final ShopRepository repository;
  Timer? _debounce;
  ShopsCubit({required this.repository}) : super(GetAllShopsInitial());

  Future<void> getAllShops() async {
    emit(GetAllShopsLoading());

    try {
      final shops = await repository.getAllShops();

      emit(GetAllShopsSuccess(shops: shops, filteredShops: shops));
    } catch (e) {
      emit(GetAllShopsFailure(errorMessage: e.toString()));
    }
  }

  // SEARCH
  void search(String query) {
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () {
      final currentState = state;
      if (currentState is GetAllShopsSuccess) {
        final filtered = _applyFilters(
          shops: currentState.shops,
          query: query,
          sortType: currentState.sortType,
          openOnly: currentState.openOnly,
        );

        emit(
          currentState.copyWith(searchQuery: query, filteredShops: filtered),
        );
      }
    });
  }

  //  SORT
  void changeSort(SortType sortType) {
    final currentState = state;
    if (currentState is GetAllShopsSuccess) {
      final filtered = _applyFilters(
        shops: currentState.shops,
        query: currentState.searchQuery,
        sortType: sortType,
        openOnly: currentState.openOnly,
      );

      emit(currentState.copyWith(sortType: sortType, filteredShops: filtered));
    }
  }

  //  FILTER (Open Only)
  void toggleOpenOnly(bool value) {
    final currentState = state;
    if (currentState is GetAllShopsSuccess) {
      final filtered = _applyFilters(
        shops: currentState.shops,
        query: currentState.searchQuery,
        sortType: currentState.sortType,
        openOnly: value,
      );

      emit(currentState.copyWith(openOnly: value, filteredShops: filtered));
    }
  }



  List<ShopModel> _applyFilters({
    required List<ShopModel> shops,
    required String query,
    required SortType sortType,
    required bool openOnly,
  }) {
    List<ShopModel> result = List.from(shops);

    // Search
    if (query.isNotEmpty) {
      result = result.where((shop) {
        final name = shop.shopName.toLowerCase();
        final description = shop.description.toLowerCase();
        final searchLower = query.toLowerCase();

        return name.contains(searchLower) || description.contains(searchLower);
      }).toList();
    }

    // Open Only Filter
    if (openOnly) {
      result = result.where((shop) => shop.availability == true).toList();
    }

    // Sort
    switch (sortType) {
      case SortType.eta:
        result.sort(
          (a, b) => a.estimatedDeliveryTime.compareTo(b.estimatedDeliveryTime),
        );
        break;

      case SortType.minimumOrder:
        result.sort(
          (a, b) => a.minimumOrderAmount.compareTo(b.minimumOrderAmount),
        );
        break;

      case SortType.none:
        break;
    }

    return result;
  }
}
