import 'package:flutter/material.dart';
import '../models/footer_model.dart';


class FooterWidget extends StatelessWidget {
  final FooterModel footer;

  const FooterWidget({super.key, required this.footer});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      color: Colors.black, // Arka plan sabit ve kontrast
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Divider(color: Colors.orangeAccent, thickness: 1.5),
          const SizedBox(height: 20),

          Text(
            footer.footerTitle,
            style: const TextStyle(
              fontFamily: 'DancingScript',
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.orangeAccent,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),

          Text(
            footer.footerDescription,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 28),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _infoItem("📍", "Lokasyon", footer.location),
              _infoItem("📞", "Telefon", footer.phone),
              _infoItem("📧", "Mail", footer.mail),
            ],
          ),

          const SizedBox(height: 28),

          Column(
            children: [
              Text(
                "${footer.openDays}: ${footer.openDaysDescription}",
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                "⏰ ${footer.openHours}",
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),

          const SizedBox(height: 32),
          const Divider(color: Colors.white24),
          const SizedBox(height: 8),

          const Text("© 2025 Tüm hakları saklıdır.",
              style: TextStyle(color: Colors.white54, fontSize: 12)),
          const Text("Sevtap Gençtürk Bahar",
              style: TextStyle(color: Colors.white38, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _infoItem(String icon, String title, String value) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            color: Colors.orangeAccent,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 90,
          child: Text(
            value,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
