import 'package:flutter/material.dart';
import '../services/chat_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  String? _calorieResponse;
  String? _ingredientResponse;
  bool _isLoading = false;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _handleQuery() async {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
      _calorieResponse = null;
      _ingredientResponse = null;
    });

    final query = _controller.text.trim();

    try {
      if (_tabController.index == 0) {
        // Kalori sekmesi
        final res = await ChatService.ask(query);
        setState(() => _calorieResponse = res);
      } else {
        // İçindekiler sekmesi
        final res = await ChatService.ingredients(query);
        setState(() => _ingredientResponse = res);
      }
    } catch (e) {
      setState(() {
        if (_tabController.index == 0) {
          _calorieResponse = "Hata: $e";
        } else {
          _ingredientResponse = "Hata: $e";
        }
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildResponseBox(String? response) {
    if (_isLoading) {
      return const CircularProgressIndicator(color: Colors.orangeAccent);
    } else if (response != null) {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green.shade900.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.greenAccent),
        ),
        child: Text(
          response,
          style: const TextStyle(
            color: Colors.greenAccent,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("🍽 Yemek Asistanı"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Kalori"),
            Tab(text: "İçindekiler"),
          ],
          indicatorColor: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[900],
                hintText: "Yemek adı girin (ör. lahmacun)",
                hintStyle: const TextStyle(color: Colors.white38),
                prefixIcon: const Icon(Icons.fastfood, color: Colors.orangeAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.orangeAccent),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _handleQuery,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
              child: const Text("Sorgula", style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 20),
            _tabController.index == 0
                ? _buildResponseBox(_calorieResponse)
                : _buildResponseBox(_ingredientResponse),
          ],
        ),
      ),
    );
  }
}
