import 'package:flutter/material.dart';
import 'pbb2.dart'; // Import Page 5 agar bisa berpindah halaman

class PbbPage extends StatefulWidget {
  const PbbPage({super.key});

  @override
  State<PbbPage> createState() => _PbbPageState();
}

class _PbbPageState extends State<PbbPage> {
  final TextEditingController _nopController = TextEditingController();

  @override
  void dispose() {
    _nopController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color mainBlue = Color(0xFF0A3D6D);

    return Scaffold(
      backgroundColor: Colors.white,
      // ================= APPBAR =================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // Tombol leading sengaja dihapus agar tidak menumpuk dengan navigasi bottom bar utama
        title: const Text(
          "PBB",
          style: TextStyle(
            color: mainBlue,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade200, height: 1),
        ),
      ),

      // ================= BODY =================
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 24),

              // --- INPUT BOX NOP (SESUAI GAMBAR) ---
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF8FA3B7), width: 1.5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search_rounded, 
                      color: Colors.black54, 
                      size: 26,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _nopController,
                        keyboardType: TextInputType.number,
                        cursorColor: mainBlue,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                        decoration: const InputDecoration(
                          hintText: "Masukan NOP...",
                          hintStyle: TextStyle(
                            color: Color(0xFF9EA8B3), 
                            fontSize: 15,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                        ),
                        onSubmitted: (value) {
                          if (value.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const HasilPbbPage()),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 2),

              // --- BAGIAN TENGAH (IKON DOKUMEN & PANDUAN SESUAI GAMBAR) ---
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Desain Ikon Kaca Pembesar di Atas Dokumen Bertumpuk
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(
                          Icons.description_rounded, 
                          color: mainBlue, 
                          size: 90,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.search_rounded, 
                              color: mainBlue, 
                              size: 38,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Modifikasi Teks Terpisah untuk Bagian Tebal di Bawah (Sesuai Gambar)
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 16, 
                          color: Color(0xFF4A4A4A),
                          height: 1.4,
                        ),
                        children: [
                          TextSpan(text: "Masukan NOP untuk melihat\n"),
                          TextSpan(
                            text: "rincian pajak.",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 3),
              
              // --- TOMBOL CARI ---
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    if (_nopController.text.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HasilPbbPage()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Silakan masukkan Nomor NOP terlebih dahulu!"),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Cari NOP",
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 16, 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}