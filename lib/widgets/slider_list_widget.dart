import 'package:flutter/material.dart';
import '../models/slider_model.dart';

class SliderListWidget extends StatelessWidget {
  final List<SliderModel> sliders;

  const SliderListWidget({super.key, required this.sliders});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: sliders.map((slider) {
        return Column(
          children: [
            _sliderCard(slider.title1, slider.description1, slider.imageUrl1),
            _sliderCard(slider.title2, slider.description2, slider.imageUrl2),
            _sliderCard(slider.title3, slider.description3, slider.imageUrl3),
            const SizedBox(height: 20),
          ],
        );
      }).toList(),
    );
  }

  Widget _sliderCard(String title, String description, String imageUrl) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.broken_image, size: 100),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
