class ShopModel {
  final String shopName;
  final String description;
  final String coverPhoto;
  final String estimatedDeliveryTime;
  final int minimumOrderAmount;
  final String minimumOrderCurrency;
  final String city;
  final bool availability;

  ShopModel({
    required this.shopName,
    required this.description,
    required this.coverPhoto,
    required this.estimatedDeliveryTime,
    required this.minimumOrderAmount,
    required this.minimumOrderCurrency,
    required this.city,
    required this.availability,
  });

  factory ShopModel.fromJson(Map<String, dynamic> jsonData) {
    return ShopModel(
      shopName: jsonData['shopName']['en'],
      description: jsonData['description']['en'],
      coverPhoto: jsonData['coverPhoto'],
      estimatedDeliveryTime: jsonData['estimatedDeliveryTime'],
      minimumOrderAmount: jsonData['minimumOrder']['amount'],
      minimumOrderCurrency: jsonData['minimumOrder']['currency'],
      city: jsonData['address']['city'],
      availability: jsonData['availability']??false,
    );
  }
}
