import 'package:flutter/material.dart';
import '../models/testimonial_model.dart';

class TestimonialCardWidget extends StatelessWidget {
  final TestimonialModel testimonial;

  const TestimonialCardWidget({super.key, required this.testimonial});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850],
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 👤 Profil fotoğrafı
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                testimonial.imageUrl, // ✅ SADECE bu!
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.person, size: 50, color: Colors.white),
              ),
            ),
            const SizedBox(width: 12),

            // 📝 İçer
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    testimonial.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent,
                    ),
                  ),
                  Text(
                    testimonial.title,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white54,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    testimonial.comment,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
