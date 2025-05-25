import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../models/slider_model.dart';
import '../models/discount_model.dart';
import '../models/testimonial_model.dart';
import '../services/api_service.dart';
import '../widgets/CustomMenuOverlay.dart';
import '../widgets/slider_list_widget.dart';
import '../widgets/discount_card_widget.dart';
import '../widgets/product_card_widget.dart';
import '../widgets/testimonial_card_widget.dart';
import '../models/footer_model.dart';
import '../services/footer_service.dart';
import '../widgets/footer_widget.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<SliderModel>> sliderFuture;
  late Future<List<DiscountModel>> discountFuture;
  late Future<List<ProductModel>> productFuture;
  late Future<FooterModel?> footerFuture;


  @override
  void initState() {
    super.initState();
    sliderFuture = ApiService.getSliders();
    discountFuture = ApiService.getDiscounts();
    productFuture = ApiService.getLast9Products();
    footerFuture = FooterService.getFooter  ();


  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              // 🍔 HAMBURGER MENÜ İKONU (ilk satır)
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (_, __, ___) => CustomMenuOverlay(
                          onClose: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),

              // ✨ BAŞLIK KISMI
              const Text(
                'BendenMutfağınıza',
                style: TextStyle(
                  fontFamily: 'DancingScript',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.orangeAccent,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              const Text(
                'Restoran',
                style: TextStyle(
                  fontFamily: 'DancingScript',
                  fontSize: 26,
                  color: Colors.orangeAccent,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              // 🔥 SLIDER
              FutureBuilder<List<SliderModel>>(
                future: sliderFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Slider hatası: ${snapshot.error}',
                        style: const TextStyle(color: Colors.white));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('Slider bulunamadı',
                        style: TextStyle(color: Colors.white));
                  } else {
                    return SliderListWidget(sliders: snapshot.data!);
                  }
                },
              ),

              const SizedBox(height: 32),

              // 💸 DISCOUNT
              FutureBuilder<List<DiscountModel>>(
                future: discountFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('İndirim hatası: ${snapshot.error}',
                        style: const TextStyle(color: Colors.white));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('İndirim verisi yok',
                        style: TextStyle(color: Colors.white));
                  } else {
                    return DiscountCardWidget(discounts: snapshot.data!);
                  }
                },
              ),

              const SizedBox(height: 32),

              const Text(
                'Öne Çıkan Ürünlerimiz',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),

              // 🧃 PRODUCTS
              FutureBuilder<List<ProductModel>>(
                future: productFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Hata: ${snapshot.error}',
                        style: const TextStyle(color: Colors.white));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('Ürün bulunamadı.',
                        style: TextStyle(color: Colors.white));
                  } else {
                    return Column(
                      children: [
                        GridView.builder(
                          padding: const EdgeInsets.only(top: 8),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return ProductCardWidget(
                                product: snapshot.data![index]);
                          },
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/menu');
                          },
                          child: const Text(
                            'Daha Fazlasını Gör',
                            style: TextStyle(
                              color: Colors.orangeAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,


                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

// 🧾 Hakkımızda Kutusu
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFEAEAE7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Hakkımızda',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              Center(
                                child: Image.network(
                                  'https://cdn-icons-png.flaticon.com/128/5637/5637217.png',
                                  height: 120,
                                  errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.fastfood, size: 80, color: Colors.orangeAccent),
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'BendenMutfağınıza sayesinde tüm lezzetler evinizde!',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Elazığ’da başlayan bu lezzet yolculuğu, şimdi mobil uygulamayla cebinizde.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

// 👥 Yorumlar Kutusu
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFEAEAE7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Misafirlerimiz Hakkımızda Neler Dedi?',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 12),

                              FutureBuilder<List<TestimonialModel>>(
                                future: ApiService.getTestimonials(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Text('Yorum hatası: ${snapshot.error}',
                                        style: const TextStyle(color: Colors.redAccent));
                                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                    return const Text('Yorum bulunamadı.',
                                        style: TextStyle(color: Colors.black87));
                                  } else {
                                    return Column(
                                      children: snapshot.data!
                                          .map((item) => TestimonialCardWidget(testimonial: item))
                                          .toList(),
                                    );
                                  }
                                },
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/contact');
                                },
                                child: const Text(
                                  'İletişime Geç',
                                  style: TextStyle(
                                    color: Colors.orangeAccent,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),

                            ],

                          ),
                        ),
                        const SizedBox(height: 32),

                        FutureBuilder<FooterModel?>(
                          future: footerFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError || snapshot.data == null) {
                              return const Text('Footer verisi yüklenemedi.', style: TextStyle(color: Colors.white));
                            } else {
                              return FooterWidget(footer: snapshot.data!);
                            }
                          },
                        ),



                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
