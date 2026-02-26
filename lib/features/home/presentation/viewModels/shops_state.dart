part of 'shops_cubit.dart';

@immutable
sealed class GetAllShopsState extends Equatable {
  const GetAllShopsState();
  @override
  List<Object?> get props => [];
}

final class GetAllShopsInitial extends GetAllShopsState {}

final class GetAllShopsLoading extends GetAllShopsState {}

enum SortType { none, eta, minimumOrder }

final class GetAllShopsSuccess extends GetAllShopsState {
  final List<ShopModel> shops;
  final List<ShopModel> filteredShops;
  final String searchQuery;
  final SortType sortType;
  final bool openOnly;
  const GetAllShopsSuccess({
    required this.shops,
    required this.filteredShops,
    this.searchQuery = '',
    this.openOnly = false,
    this.sortType = SortType.none,
  });
  @override
  List<Object?> get props =>
      [shops, filteredShops, searchQuery, sortType, openOnly];

  GetAllShopsSuccess copyWith({
    List<ShopModel>? shops,
    List<ShopModel>? filteredShops,
    String? searchQuery,
    SortType? sortType,
    bool? openOnly,
  }) {
    return GetAllShopsSuccess(
      shops: shops ?? this.shops,
      filteredShops: filteredShops ?? this.filteredShops,
      searchQuery: searchQuery ?? this.searchQuery,
      sortType: sortType ?? this.sortType,
      openOnly: openOnly ?? this.openOnly,
    );
  }
}

final class GetAllShopsFailure extends GetAllShopsState {
  final String errorMessage;
  const GetAllShopsFailure({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
