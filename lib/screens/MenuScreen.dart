import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';
import '../widgets/CustomMenuOverlay.dart';
import 'product_detail_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<CategoryModel> kategoriler = [];
  List<ProductModel> tumUrunler = [];
  List<ProductModel> filtreliUrunler = [];
  int? seciliKategoriId;
  int? masaID; // 👈 MASA ID'yi alacağımız değişken

  bool yukleniyor = true;

  @override
  void initState() {
    super.initState();
    _verileriGetir();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 👇 Route ile gelen masaID’yi al
    masaID = ModalRoute.of(context)?.settings.arguments as int?;
    print("Seçilen Masa ID: $masaID");
  }

  Future<void> _verileriGetir() async {
    try {
      kategoriler = await ApiService.getCategories();
      tumUrunler = await ApiService.getLast9Products();

      setState(() {
        filtreliUrunler = tumUrunler;
        yukleniyor = false;
      });
    } catch (e) {
      print("Veri hatası: $e");
    }
  }

  void _filtrele(int? kategoriId) {
    setState(() {
      seciliKategoriId = kategoriId;
      filtreliUrunler = kategoriId == null
          ? tumUrunler
          : tumUrunler.where((u) => u.categoryId == kategoriId).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Menü', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (_, __, ___) => CustomMenuOverlay(
                    onClose: () => Navigator.of(context).pop(),
                    showMasalar: true,
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: yukleniyor
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: kategoriler.length + 1,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ChoiceChip(
                      label: const Text("Hepsi"),
                      selected: seciliKategoriId == null,
                      onSelected: (_) => _filtrele(null),
                      selectedColor: Colors.orangeAccent,
                      backgroundColor: Colors.grey[300],
                    ),
                  );
                }

                final kategori = kategoriler[index - 1];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ChoiceChip(
                    label: Text(kategori.categoryName),
                    selected: seciliKategoriId == kategori.categoryID,
                    onSelected: (_) => _filtrele(kategori.categoryID),
                    selectedColor: Colors.orangeAccent,
                    backgroundColor: Colors.grey[300],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.72,
              ),
              itemCount: filtreliUrunler.length,
              itemBuilder: (context, index) {
                final urun = filtreliUrunler[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailScreen(
                          urun: urun,
                          masaID: masaID, // 👈 MASA ID'yi detay sayfasına da taşı
                        ),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12)),
                            child: Image.network(
                              urun.imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image_not_supported, size: 48),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Column(
                            children: [
                              Text(
                                urun.productName,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${urun.price.toStringAsFixed(2)} ₺",
                                style: const TextStyle(
                                    color: Colors.orangeAccent,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
