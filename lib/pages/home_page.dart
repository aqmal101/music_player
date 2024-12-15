import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  final String _message = 'Hi, Aqmal';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const SizedBox(width: 8.0), // Tambahkan jarak antara ikon dan teks
            RichText(
              text: TextSpan(
                text: _message,
                style: const TextStyle(
                  fontSize: 24.0,
                  color: Colors.black,
                ),
              ),
            ),
            Icon(
              Icons.waving_hand, // Ganti dengan ikon pilihan Anda
              color: Colors.deepOrange, // Tentukan warna ikon
              size: 32.0, // Tentukan ukuran ikon
            ),
          ],
        ),
        backgroundColor: Colors.white, // Contoh warna latar belakang
      ),
      body: const Center(
        child: Text('Home Page Content'),
      ),
    );
  }
}
