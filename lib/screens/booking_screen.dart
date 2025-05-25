import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/booking_model.dart';
import '../services/booking_service.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final mailController = TextEditingController();
  final personCountController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime? selectedDate;

  Future<void> _submitBooking() async {
    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen bir tarih seçin.")),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      final booking = BookingModel(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        mail: mailController.text.trim(),
        personCount: int.parse(personCountController.text.trim()),
        description: descriptionController.text.trim(),
        date: DateFormat('yyyy-MM-dd').format(selectedDate!), // artık null değil
      );

      bool success = await BookingService.sendBooking(booking);

      if (success) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Colors.white,
            title: const Text(
              "🎉 Başarılı",
              style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
            ),
            content: const Text(
              "Rezervasyonunuz alınmıştır.\nEn kısa sürede sizinle iletişime geçilecektir.",
              style: TextStyle(color: Colors.black87),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // alert dialogu kapat
                  Navigator.pop(context); // önceki sayfaya dön
                },
                child: const Text(
                  "Tamam",
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ],
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Hata oluştu. Tekrar deneyin.")),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Rezervasyon Oluştur"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildField("Ad Soyad", nameController),
              _buildField("Telefon (11 hane)", phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (val) {
                    if (val == null || val.length != 11) {
                      return "11 haneli telefon numarası girin";
                    }
                    if (!RegExp(r'^\d+$').hasMatch(val)) {
                      return "Sadece rakam girin";
                    }
                    return null;
                  }),
              _buildField("E-posta", mailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val == null ||
                        !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(val)) {
                      return "Geçerli bir e-posta girin";
                    }
                    return null;
                  }),
              _buildField("Kişi Sayısı", personCountController,
                  keyboardType: TextInputType.number),
              _buildField("Açıklama", descriptionController),
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
                icon: const Icon(Icons.calendar_today,
                    color: Colors.orangeAccent),
                label: Text(
                  selectedDate != null
                      ? DateFormat('dd MMMM yyyy', 'tr_TR')
                      .format(selectedDate!)
                      : "Tarih Seç",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("Rezervasyon Oluştur"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text,
        String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.orangeAccent),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orangeAccent),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
