import 'package:flutter/material.dart';
import '../models/footer_model.dart';
import '../services/footer_service.dart';
import '../widgets/footer_widget.dart';

class FooterScreen extends StatelessWidget {
  const FooterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FooterModel?>(
      future: FooterService.getFooter(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || snapshot.data == null) {
          return const Center(child: Text("Footer verisi alınamadı."));
        } else {
          return FooterWidget(footer: snapshot.data!);
        }
      },
    );
  }
}
