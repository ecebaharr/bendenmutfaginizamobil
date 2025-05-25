import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductModel product;

  const ProductCardWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 📸 Görsel
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 100,
              width: double.infinity,
              child: Image.network(
                product.imageUrl, // ✅ SADECE bu kadar!
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                      child: CircularProgressIndicator(strokeWidth: 2));
                },
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, size: 80, color: Colors.white),
              ),

            ),
          ),

          const SizedBox(height: 8),

          // 🏷️ Ürün Adı
          Text(
            product.productName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 14,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 4),

          // 🧾 Açıklama (kaydırmalı alan)
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              thickness: 2,
              radius: const Radius.circular(4),
              child: SingleChildScrollView(
                child: Text(
                  product.description,
                  style:
                  const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // 💰 Fiyat
          Text(
            '${product.price.toStringAsFixed(2)} ₺',
            style: const TextStyle(
              color: Colors.orangeAccent,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
