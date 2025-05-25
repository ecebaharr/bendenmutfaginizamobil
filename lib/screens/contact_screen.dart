import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/message_model.dart';
import '../services/message_service.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();


  Future<void> _submitForm() async {
      if (_formKey.currentState!.validate()) {
        final newMessage = MessageModel(
          nameSurname: _nameController.text,
          mail: _mailController.text,
          phone: _phoneController.text,
          subject: _subjectController.text,
          messageContent: _messageController.text,
        );

        final success = await MessageService.sendMessage(newMessage);

        if (success) {
          _nameController.clear();
          _mailController.clear();
          _phoneController.clear();
          _subjectController.clear();
          _messageController.clear();

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: const Text('Teşekkürler!', style: TextStyle(fontWeight: FontWeight.bold)),
                content: const Text('Mesajınız başarıyla bize ulaşmıştır!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacementNamed(context, '/home'); // anasayfa
                    },
                    child: const Text('Anasayfa'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // sadece popup'ı kapat
                    },
                    child: const Text('Yeni Mesaj'),
                  ),
                ],
              );
            },
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gönderim başarısız.')),
          );
        }
      }
    }


  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Bize Ulaşın',
                style: TextStyle(
                  fontFamily: 'DancingScript',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.orangeAccent,
                ),
              ),
              const SizedBox(height: 20),
              _buildInput(_nameController, 'Adınız Soyadınız'),
              _buildPhoneInput(_phoneController, 'Telefon Numaranız'),
              _buildEmailInput(_mailController, 'Email Adresiniz'),
              _buildInput(_subjectController, 'Konu'),
              _buildInput(_messageController, 'Mesajınız', maxLines: 4),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                ),
                child: const Text('Mesajı Gönder'),
              )
            ],
          ),
        ),
      ),
    );
  }

  // 🔸 Genel input alanı
  Widget _buildInput(TextEditingController controller, String label,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: (value) =>
        value!.isEmpty ? '$label alanı boş bırakılamaz' : null,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: label,
          labelStyle: const TextStyle(color: Colors.orangeAccent),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          errorStyle: const TextStyle(color: Colors.redAccent),
        ),
      ),
    );
  }

  // 🔸 Telefon numarası sadece rakam ve 11 hane
  Widget _buildPhoneInput(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        maxLength: 11,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label alanı boş bırakılamaz';
          } else if (!RegExp(r'^\d{11}$').hasMatch(value)) {
            return 'Telefon numarası 11 haneli olmalıdır';
          }
          return null;
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: label,
          labelStyle: const TextStyle(color: Colors.orangeAccent),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          counterText: '',
          errorStyle: const TextStyle(color: Colors.redAccent),
        ),
      ),
    );
  }

  // 🔸 Email inputu
// 📧 Email inputu (doğrulama ekli)
  Widget _buildEmailInput(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label alanı boş bırakılamaz';
          } else if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,4}$').hasMatch(value)) {
            return 'Geçerli bir e-posta adresi girin';
          }
          return null;
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: label,
          labelStyle: const TextStyle(color: Colors.orangeAccent),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }


}
