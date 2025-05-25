import 'package:flutter/material.dart';
import '../models/basket_model.dart';
import '../services/basket_service.dart';

class BasketScreen extends StatefulWidget {
  final int masaID;

  const BasketScreen({super.key, required this.masaID});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  late Future<List<BasketModel>> basketFuture;

  @override
  void initState() {
    super.initState();
    basketFuture = BasketService.getBasketsByTable(widget.masaID);
  }

  void _refreshBasket() {
    setState(() {
      basketFuture = BasketService.getBasketsByTable(widget.masaID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Sepetim'),
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder<List<BasketModel>>(
        future: basketFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Hata: ${snapshot.error}",
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "Sepetiniz boş.",
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            final sepet = snapshot.data!;
            double toplamTutar = sepet.fold(0, (sum, item) => sum + item.totalPrice);
            double kdv = toplamTutar * 0.10;
            double genelToplam = toplamTutar + kdv;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: sepet.length,
                    itemBuilder: (context, index) {
                      final urun = sepet[index];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        color: Colors.white10,
                        child: ListTile(
                          leading: const Icon(Icons.fastfood, color: Colors.orangeAccent),
                          title: Text(
                            urun.productName,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            "${urun.count} x ${urun.price.toStringAsFixed(2)} ₺",
                            style: const TextStyle(color: Colors.white70),
                          ),
                          trailing: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${urun.totalPrice.toStringAsFixed(2)} ₺",
                                style: const TextStyle(
                                  color: Colors.orangeAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 2),
                              GestureDetector(
                                onTap: () async {
                                  await BasketService.deleteFromBasket(urun.basketID);
                                  _refreshBasket();
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                  size: 20, // Küçük boyutta ikon
                                ),
                              ),
                            ],
                          ),



                        ),
                      );
                    },
                  ),
                ),
                Container(
                  color: Colors.orange.shade900,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Ara Toplam:", style: TextStyle(color: Colors.white)),
                          Text("${toplamTutar.toStringAsFixed(2)} ₺", style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("KDV (%10):", style: TextStyle(color: Colors.white)),
                          Text("${kdv.toStringAsFixed(2)} ₺", style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Genel Toplam:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                          Text("${genelToplam.toStringAsFixed(2)} ₺", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () async {
                          final result = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: Colors.black,
                              title: const Text(
                                "Sipariş Onayı",
                                style: TextStyle(color: Colors.orangeAccent),
                              ),
                              content: const Text(
                                "Siparişi onaylamak istiyor musunuz?",
                                style: TextStyle(color: Colors.white),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: const Text("İptal", style: TextStyle(color: Colors.redAccent)),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text("Onayla", style: TextStyle(color: Colors.greenAccent)),
                                ),
                              ],
                            ),
                          );

                          if (result == true) {
                            await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.black,
                                title: const Text(
                                  "Sipariş Alındı",
                                  style: TextStyle(color: Colors.greenAccent),
                                ),
                                content: const Text(
                                  "Siparişiniz başarıyla bize ulaşmıştır.\nSiparişiniz masanıza tahminen 15 dakika içerisinde gelcektir. Şimdiden afiyet olsun.\nBizi seçtiğiniz için teşekkür ederiz!",
                                  style: TextStyle(color: Colors.white),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context); // alert'ı kapat
                                      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false); // anasayfaya dön
                                    },
                                    child: const Text("Teşekkürler", style: TextStyle(color: Colors.orangeAccent)),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                        child: const Text("Siparişi Tamamla"),
                      ),
                        ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}