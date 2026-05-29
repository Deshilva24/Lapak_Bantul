import 'package:flutter/material.dart';
import 'auth/login_page.dart'; // Memastikan mengarah ke folder auth kamu

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _slideController = PageController();
  int _halamanAktif = 0;

  // Data konten asli buatanmu
  final List<Map<String, dynamic>> _kontenOnboarding = [
    {
      'judul': 'Selamat Datang di Lapak Bantul!',
      'subjudul': 'Solusi cerdas untuk mengelola dan memantau perkembangan usahamu dalam satu genggaman.',
      'gambar': 'assets/images/foto_1.png', 
      'warna': const Color(0xFF1A568C),
    },
    {
      'judul': 'Jaring Mitra Lebih Luas',
      'subjudul': 'Temukan mitra terpercaya dan bangun kolaborasi strategis untuk memajukan UMKM bersama.',
      'gambar': 'assets/images/foto_2.png', 
      'warna': const Color(0xFF1E88E5),
    },
    {
      'judul': 'Tumbuh Bersama Pelanggan',
      'subjudul': 'Ciptakan hubungan yang lebih dekat, hangat, dan loyal dengan setiap pelanggan setiamu.',
      'gambar': 'assets/images/foto_3.png', 
      'warna': const Color(0xFF1565C0),
    },
  ];

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  void _pindahHalaman() {
    if (_halamanAktif < _kontenOnboarding.length - 1) {
      _slideController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      _selesaiOnboarding();
    }
  }

  void _selesaiOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _slideController,
            onPageChanged: (index) => setState(() => _halamanAktif = index),
            itemCount: _kontenOnboarding.length,
            itemBuilder: (context, index) {
              return _TampilanHalaman(data: _kontenOnboarding[index]);
            },
          ),
          if (_halamanAktif < _kontenOnboarding.length - 1)
            Positioned(
              top: 50,
              right: 20,
              child: TextButton(
                onPressed: _selesaiOnboarding,
                child: const Text('Lewati', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          Positioned(
            bottom: 50,
            left: 30,
            right: 30,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _kontenOnboarding.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: 10,
                      width: _halamanAktif == index ? 30 : 10,
                      decoration: BoxDecoration(
                        color: _halamanAktif == index ? Colors.orange : Colors.white54,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _pindahHalaman,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF1A568C),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: Text(
                      _halamanAktif == _kontenOnboarding.length - 1 ? 'Mulai Sekarang' : 'Lanjut',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget tampilan halaman yang diletakkan di luar lingkup class State utama agar tidak bentrok
class _TampilanHalaman extends StatelessWidget {
  final Map<String, dynamic> data;
  const _TampilanHalaman({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      color: data['warna'],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            data['gambar'], 
            height: 250, 
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.image, 
              size: 200, 
              color: Colors.white
            )
          ),
          const SizedBox(height: 50),
          Text(
            data['judul'], 
            textAlign: TextAlign.center, 
            style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 20),
          Text(
            data['subjudul'], 
            textAlign: TextAlign.center, 
            style: const TextStyle(color: Colors.white70, fontSize: 16)
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}