import 'package:flutter/material.dart';
import 'package:flutter_application_2/home_page.dart';
import 'package:flutter_application_2/pbb1.dart'; 
import 'package:flutter_application_2/detail.dart';
import 'package:flutter_application_2/layanan_keliling.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0; // Mengontrol menu bawah mana yang sedang aktif

  // Menggunakan Getter agar parameter dinamis dari file asli kamu bisa masuk tanpa error const
  List<Widget> get _pages => [
    const HomePage(),             // Index 0: Beranda (home_page.dart)
    const PbbPage(),              // Index 1: PBB langsung ke Input NOP (pbb1.dart)
    const DetailSpptPage(statusBayar: "Sudah Lunas", tahun: "2026"), // Index 2: Kendaraan langsung ke Detail SPPT (detail.dart)
    const DummyPage(title: "Usaha"),         // Index 3: Usaha (Kosong Dulu)
    const LayananKelilingPage(),             // Index 4: Keliling (layanan_keliling.dart)
    const DummyPage(title: "API Demo"),      // Index 5: API Demo (Kosong Dulu)
  ];

  @override
  Widget build(BuildContext context) {
    const Color mainBlue = Color(0xFF0A3D6D);

    return Scaffold(
      // Tubuh halaman di tengah yang akan berubah-ubah sesuai menu yang diklik
      body: _pages[_currentIndex], 
      
      // Bottom Navigation Bar yang nempel terus di bawah beranda dan halaman lainnya
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Berpindah halaman saat menu bawah diklik
          });
        },
        type: BottomNavigationBarType.fixed, // Menampilkan ke-6 menu secara sejajar rapi
        selectedItemColor: mainBlue,         // Warna biru saat menu aktif
        unselectedItemColor: Colors.grey,    // Warna abu-abu saat menu tidak aktif
        selectedFontSize: 11,
        unselectedFontSize: 11,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined), 
            activeIcon: Icon(Icons.home), 
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description_outlined), 
            activeIcon: Icon(Icons.description), 
            label: "PBB",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car_outlined), 
            activeIcon: Icon(Icons.directions_car), 
            label: "Kendaraan",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_outlined), 
            activeIcon: Icon(Icons.storefront), 
            label: "Usaha",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping_outlined), 
            activeIcon: Icon(Icons.local_shipping), 
            label: "Keliling",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud_outlined), 
            activeIcon: Icon(Icons.cloud), 
            label: "API Demo",
          ),
        ],
      ),
    );
  }
}

class DummyPage extends StatelessWidget {
  final String title;
  const DummyPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.hourglass_empty, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              "Halaman $title\nSementara Masih Kosong", 
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}