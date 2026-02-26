import 'package:rw_test/constants.dart';
import 'package:rw_test/core/api.dart';
import 'package:rw_test/core/config/app_config.dart';
import 'package:rw_test/features/home/data/models/shop_model.dart';

class ShopRepository {
  final Api api;
  ShopRepository({required this.api});

  Future<List<ShopModel>> getAllShops() async {
    final response = await api.get(
      url: kBaseUrl,  
      headers: {'secretKey': AppConfig.secretKey},
      query: {"deviceKind": "web"},
    );
    print(response);
    final List<dynamic> result = response["result"];

    return result.map((json) => ShopModel.fromJson(json)).toList();
  }
}
