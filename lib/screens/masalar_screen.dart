import 'package:flutter/material.dart';
import '../models/menu_table_model.dart';
import '../services/menu_table_service.dart';
import 'basket_screen.dart';


class MasalarScreen extends StatefulWidget {
  const MasalarScreen({super.key});

  @override
  State<MasalarScreen> createState() => _MasalarScreenState();
}

class _MasalarScreenState extends State<MasalarScreen> {
  late Future<List<MenuTableModel>> _masalarFuture;

  @override
  void initState() {
    super.initState();
    _masalarFuture = MenuTableService.getTables();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Masalar'),
        backgroundColor: Colors.orangeAccent,
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<List<MenuTableModel>>(
        future: _masalarFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Hata oluştu: ${snapshot.error}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Hiç masa bulunamadı.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final masalar = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.3,
              ),
              itemCount: masalar.length,
              itemBuilder: (context, index) {
                final masa = masalar[index];
                final doluMu = masa.status;

                return GestureDetector(
                  onTap: () {
                    if (!masa.status) {
                      // Eğer masa boşsa, MenuScreen'e masaID (menuTableID) ile yönlendir
                      Navigator.pushNamed(
                        context,
                        '/menu',
                        arguments: masa.menuTableID,
                      );
                    } else {
                      // Doluysa bilgi ver
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Bu masa şu anda dolu."),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                  },


                  child: Container(
                    decoration: BoxDecoration(
                      color: doluMu ? Colors.red : Colors.green,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          masa.status == true ? Icons.point_of_sale : Icons.chair_alt,
                          color: Colors.white,
                          size: 32,
                        ),

                        Text(
                          masa.name,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          doluMu ? 'Masa Dolu' : 'Masa Boş',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
