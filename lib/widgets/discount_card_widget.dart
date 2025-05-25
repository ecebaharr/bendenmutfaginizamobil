import 'package:flutter/material.dart';
import '../models/discount_model.dart';

class DiscountCardWidget extends StatelessWidget {
  final List<DiscountModel> discounts;

  const DiscountCardWidget({super.key, required this.discounts});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: discounts.map((discount) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A), // koyu arka plan
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              // Dairesel görsel
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.orangeAccent, width: 4),
                ),
                child: ClipOval(
                  child: Image.network(
                    discount.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image_not_supported, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Yazılar
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      discount.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      discount.description,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '%${discount.amount} İndirim',
                      style: const TextStyle(
                        color: Colors.orangeAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Buton
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart_checkout, size: 16),
                label: const Text(""),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
