import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Uygulamanın kabuğu: değişmiyor → Stateless
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SayacSayfasi(),
    );
  }
}

// Sayaç sayfası: değişiyor → Stateful
class SayacSayfasi extends StatefulWidget {
  const SayacSayfasi({super.key});

  @override
  State<SayacSayfasi> createState() => _SayacSayfasiState();
}

class _SayacSayfasiState extends State<SayacSayfasi> {
  int sepetAdedi = 0; // Bu değişken "state"

  void urunEkle() {
    setState(() {
      sepetAdedi++;
    });
  }

  void urunCikar() {
    if (sepetAdedi == 0) return;
    setState(() {
      sepetAdedi--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mini Katalog')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sepetteki ürün sayısı:', style: TextStyle(fontSize: 18)),
            Text(
              '$sepetAdedi',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: urunCikar, child: const Text('Çıkar')),
                const SizedBox(width: 16),
                ElevatedButton(onPressed: urunEkle, child: const Text('Ekle')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}