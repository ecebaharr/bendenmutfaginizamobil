import 'package:flutter/material.dart';


class CustomMenuOverlay extends StatelessWidget {
  final VoidCallback onClose;
  final bool showMasalar;
  final int? seciliMasaID;

  const CustomMenuOverlay({
    super.key,
    required this.onClose,
    this.showMasalar = false,
    this.seciliMasaID,
  });

  Widget menuItem(BuildContext context, String title, String? routeName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: routeName != null
            ? () {
          Navigator.pop(context);
          Navigator.pushNamed(context, routeName);
        }
            : null,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: routeName != null ? Colors.white : Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.95),
      child: SafeArea(
        child: Stack(
          children: [
            // ❌ Kapatma butonu
            Positioned(
              top: 20,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 32),
                onPressed: onClose,
              ),
            ),

            // Menü içerikleri
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  menuItem(context, "ANASAYFA", "/home"),
                  menuItem(context, "MENÜ", "/menu"),
                  menuItem(context, "İLGİNÇ TARİFLER", "/ilginc-tarifler"),
                  menuItem(context, "REZERVASYON OLUŞTUR", "/rezervasyon"),
                  menuItem(context, "YEMEK ASİSTANI", "/kalori"), // 💥 BURAYA EKLENDİ

                  if (showMasalar) menuItem(context, "MASALAR", "/masalar"),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.person, color: Colors.white),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          if (seciliMasaID != null) {
                            Navigator.pushNamed(
                              context,
                              "/sepet",
                              arguments: seciliMasaID,
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.black,
                                title: const Text("Uyarı", style: TextStyle(color: Colors.orange)),
                                content: const Text("Lütfen önce masa seçiniz.", style: TextStyle(color: Colors.white)),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.pushNamed(context, "/masalar");
                                    },
                                    child: const Text("Masa Seç", style: TextStyle(color: Colors.orange)),
                                  )
                                ],
                              ),
                            );
                          }
                        },
                        child: const Icon(Icons.shopping_cart, color: Colors.white),
                      ),


                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
