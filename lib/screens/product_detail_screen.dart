import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/basket_service.dart';
import '../services/menu_table_service.dart'; // 💥 MASA DURUMU İÇİN EKLENDİ

class ProductDetailScreen extends StatelessWidget {
  final ProductModel urun;
  final int? masaID;

  const ProductDetailScreen({
    super.key,
    required this.urun,
    this.masaID,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text(urun.productName),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Image.network(
                urun.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.image_not_supported,
                    color: Colors.white70, size: 80),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    urun.productName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    urun.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "${urun.price.toStringAsFixed(2)} ₺",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 14),
                      ),
                      onPressed: () async {
                        if (masaID != null) {
                          bool basarili = await BasketService.addToBasket(
                            menuTableID: masaID!,
                            productID: urun.productID,
                            count: 1,
                            price: urun.price,
                          );

                          if (basarili) {
                            await MenuTableService.changeTableStatusToTrue(masaID!); // 💥 MASA DURUMUNU TRUE YAP

                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Ürün sepete eklendi!"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context); // dialog kapat
                                      Navigator.pop(context); // detaydan çık
                                    },
                                    child: const Text("Menüye Dön"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pushNamed(context, "/basket", arguments: masaID);
                                    },
                                    child: const Text("Sepete Git"),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Sepete eklenemedi."),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Masa bilgisi alınamadı."),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        }
                      },
                      child: const Text("Sepete ekle",
                          style: TextStyle(fontSize: 16)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
