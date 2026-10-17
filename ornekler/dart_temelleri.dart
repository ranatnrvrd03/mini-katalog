// ignore_for_file: avoid_print

void main() {
  // ───────── 1. DEĞİŞKENLER VE VERİ TİPLERİ ─────────
  String urunAdi = 'HomePod Mini';
  int stok = 12;
  double fiyat = 99.0;
  bool stoktaVar = stok > 0;

  var kategori = 'Ses';          // Dart tipi kendisi anlar → String
  final String marka = 'Apple';  // Bir kez atanır, sonra değişmez
  const int maxSepet = 10;       // Kod yazılırken bilinen sabit

  print('--- 1. Değişkenler ---');
  print('$urunAdi ($marka) - Kategori: $kategori');
  print('Fiyat: \$$fiyat | Stok: $stok | Stokta var mı: $stoktaVar');
  print('Sepete en fazla $maxSepet ürün eklenebilir');

  // ───────── 2. FONKSİYONLAR ─────────
  print('\n--- 2. Fonksiyonlar ---');
  print('KDV dahil: \$${kdvliFiyat(fiyat)}');
  print('%10 KDV ile: \$${kdvliFiyat(fiyat, oran: 0.10)}');
  print(etiket('HomePod'));
  print(etiket('HomePod', 'Profound sound.'));

  // ───────── 3. COLLECTION YAPILARI ─────────
  print('\n--- 3. List ---');
  List<String> urunler = ['AirPods Pro', 'AirPods Max', 'HomePod'];
  urunler.add('HomePod Mini');
  print('Ürün sayısı: ${urunler.length}');
  print('İlk ürün: ${urunler[0]}');
  for (final u in urunler) {
    print('• $u');
  }
  final airpodslar = urunler.where((u) => u.startsWith('AirPods')).toList();
  print('Sadece AirPods: $airpodslar');

  print('\n--- 3. Set (tekrar etmeyen liste) ---');
  Set<String> kategoriler = {'Ses', 'Telefon', 'Ses', 'Tablet', 'Ses'};
  print(kategoriler); // 'Ses' sadece bir kez görünür

  print('\n--- 3. Map (anahtar → değer) ---');
  Map<String, dynamic> urun = {
    'id': 1,
    'name': 'HomePod Mini',
    'tagline': 'Color pop.',
    'price': 99,
  };
  print('Ad: ${urun['name']} | Fiyat: \$${urun['price']}');

  // Gün 4'te kullanacağımız JSON yapısının ön izlemesi:
  List<Map<String, dynamic>> katalog = [
    {'name': 'iPhone 15 Pro', 'price': 999},
    {'name': 'iPad Air', 'price': 599},
    {'name': 'HomePod Mini', 'price': 99},
  ];
  for (final p in katalog) {
    print('${p['name']} → \$${p['price']}');
  }

  // ───────── 4. NULL SAFETY ─────────
  print('\n--- 4. Null Safety ---');
  String? indirimKodu;                    // ? → null olabilir
  print(indirimKodu ?? 'İndirim kodu yok'); // ?? → null ise yedek değer
  print(indirimKodu?.length);              // ?. → null ise hata vermez, null döner

  indirimKodu = 'RANA10';
  print('Kod: $indirimKodu, uzunluk: ${indirimKodu.length}');
}

// Varsayılan değerli, isimli parametre: {double oran = 0.20}
double kdvliFiyat(double fiyat, {double oran = 0.20}) {
  return fiyat * (1 + oran);
}

// İsteğe bağlı parametre: [String? aciklama]
// Tek satırlık fonksiyonlarda => kısayolu
String etiket(String ad, [String? aciklama]) =>
    aciklama == null ? ad : '$ad - $aciklama';
