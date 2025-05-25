import 'package:flutter/material.dart';
import '../models/tasty_recipe_model.dart';
import '../services/tasty_recipe_service.dart';
import 'tarif_detail_screen.dart'; // Detay ekranına yönlendirme için

class TariflerScreen extends StatefulWidget {
  const TariflerScreen({super.key});

  @override
  State<TariflerScreen> createState() => _TariflerScreenState();
}

class _TariflerScreenState extends State<TariflerScreen> {
  late Future<List<TastyRecipeModel>> tarifFuture;

  @override
  void initState() {
    super.initState();
    tarifFuture = TastyRecipeService.fetchRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İlginç Tarifler'),
        backgroundColor: Colors.orangeAccent,
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<List<TastyRecipeModel>>(
        future: tarifFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Hata: ${snapshot.error}',
                style: const TextStyle(color: Colors.redAccent),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Tarif bulunamadı.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final tarifler = snapshot.data!;
          return ListView.builder(
            itemCount: tarifler.length,
            itemBuilder: (context, index) {
              final tarif = tarifler[index];
              return Card(
                color: Colors.white12,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: Image.network(
                    tarif.thumbnailUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.image),
                  ),
                  title: Text(
                    tarif.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${tarif.totalTimeMinutes} dakika',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TarifDetailScreen(tarif: tarif),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
