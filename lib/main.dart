import 'package:bendenmutfaginizamobil/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/MenuScreen.dart';
import 'screens/contact_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'screens/booking_screen.dart';
import 'screens/masalar_screen.dart';
import 'screens/basket_screen.dart'; // 💥 SEPET EKRANI EKLENDİ

// Geçici boş sayfalar:
class TariflerScreen extends StatelessWidget {
  const TariflerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('İlginç Tarifler')),
      body: const Center(child: Text('Tarifler buraya gelecek')),
    );
  }
}

class RezervasyonScreen extends StatelessWidget {
  const RezervasyonScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rezervasyon Oluştur')),
      body: const Center(child: Text('Rezervasyon ekranı buraya gelecek')),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('tr_TR', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BendenMutfağınıza',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/menu': (context) => const MenuScreen(),
        '/contact': (context) => const ContactScreen(),
        '/ilginc-tarifler': (context) => const TariflerScreen(),
        '/masalar': (context) => const MasalarScreen(),
        '/rezervasyon': (context) => const BookingScreen(),
        '/kalori': (context) => const ChatScreen(),


        '/basket': (context) {
          final masaID = ModalRoute.of(context)!.settings.arguments as int;
          return BasketScreen(masaID: masaID);
        },
      },
    );
  }
}
