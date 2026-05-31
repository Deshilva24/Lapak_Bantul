import 'package:flutter/material.dart';
import 'package:flutter_application_2/home_page.dart';
import 'package:flutter_application_2/pbb1.dart'; 
import 'package:flutter_application_2/detail.dart';
import 'package:flutter_application_2/layanan_keliling.dart';
import 'package:flutter_application_2/screens/api_demo_page.dart';


class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0; 

    List<Widget> get _pages => [
    const HomePage(),             
    const PbbPage(),              
    const DetailSpptPage(statusBayar: "Sudah Lunas", tahun: "2026"), 
    const DummyPage(title: "Usaha"),         
    const LayananKelilingPage(),             
    const ApiDemoPage(),                     
  ];

  @override
  Widget build(BuildContext context) {
    const Color mainBlue = Color(0xFF0A3D6D);

    return Scaffold(
      
      body: _pages[_currentIndex], 
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; 
          });
        },
        type: BottomNavigationBarType.fixed, 
        selectedItemColor: mainBlue,         
        unselectedItemColor: Colors.grey,  
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