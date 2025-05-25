import 'package:flutter/material.dart';

class AramaScreen extends StatefulWidget {
  const AramaScreen({super.key});

  @override
  State<AramaScreen> createState() => _AramaScreenState();
}

class _AramaScreenState extends State<AramaScreen> {
  final TextEditingController _aramaController = TextEditingController();
  List<Map<String, String>> tumVeriler = [
    {"baslik": "Harput Köfte", "icerik": "Elazığ yöresine ait meşhur köfte yemeği."},
    {"baslik": "İçli Köfte", "icerik": "Bulgur ve kıymayla yapılan eşsiz lezzet."},
    {"baslik": "Künefe", "icerik": "Tel kadayıf ve peynirle yapılan tatlı."},
  ];
  List<Map<String, String>> aramaSonuclari = [];

  void _ara(String kelime) {
    final sonuc = tumVeriler.where((item) =>
    item["baslik"]!.toLowerCase().contains(kelime.toLowerCase()) ||
        item["icerik"]!.toLowerCase().contains(kelime.toLowerCase())
    ).toList();

    setState(() {
      aramaSonuclari = sonuc;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Arama"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _aramaController,
              onChanged: _ara,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Aramak istediğiniz kelimeyi yazın...",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white12,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.white),
                  onPressed: () {
                    _aramaController.clear();
                    _ara('');
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: aramaSonuclari.isEmpty
                  ? const Center(
                child: Text(
                  "Aradığınız kelime uygulamamızda bulunamadı.",
                  style: TextStyle(color: Colors.white70),
                ),
              )
                  : ListView.builder(
                itemCount: aramaSonuclari.length,
                itemBuilder: (context, index) {
                  final item = aramaSonuclari[index];
                  return Card(
                    color: Colors.white10,
                    child: ListTile(
                      title: Text(item["baslik"]!, style: const TextStyle(color: Colors.orange)),
                      subtitle: Text(item["icerik"]!, style: const TextStyle(color: Colors.white70)),
                      onTap: () {
                        // 👉 Detay sayfasına yönlendir
                        Navigator.pushNamed(context, "/detay", arguments: item);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
