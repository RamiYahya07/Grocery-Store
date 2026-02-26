import 'package:flutter/material.dart';
import 'package:rw_test/features/home/data/models/shop_model.dart';
import 'package:rw_test/features/home/presentation/views/widgets/availability_badge.dart';

class ShopCard extends StatelessWidget {
  final ShopModel shop;

  const ShopCard({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover Photo
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              shop.coverPhoto,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Shop Name & availaility
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        shop.shopName ,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    availabilityBadge(shop.availability ),
                  ],
                ),

                const SizedBox(height: 6),

                // Description
                Text(
                  shop.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 10),

                // ETA
                Row(
                  children: [
                    const Icon(Icons.timer, size: 18),
                    const SizedBox(width: 4),
                    Text("${shop.estimatedDeliveryTime} "),
                  ],
                ),

                const SizedBox(height: 6),

                // Minimum Order
                Row(
                  children: [
                    const Icon(Icons.shopping_cart, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      "Min Order: ${shop.minimumOrderAmount }${shop.minimumOrderCurrency}",
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                // Location
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 18),
                    const SizedBox(width: 4),
                    Text(shop.city),
                  ],
                ),
              ],
            ),
          ), 
        ],
      ),
    );
  }

}
