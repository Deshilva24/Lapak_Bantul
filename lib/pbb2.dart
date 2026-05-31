import 'package:flutter/material.dart';
import 'detail.dart'; 

class HasilPbbPage extends StatelessWidget {
  const HasilPbbPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color mainBlue = Color(0xFF0A3D6D);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: mainBlue, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "PBB",
          style: TextStyle(color: mainBlue, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade200, height: 1),
        ),
      ),
      body: Column(
        children: [
          // --- Search Bar ---
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: mainBlue, width: 2),
              ),
              child: const Row( // Ditambahkan const di sini
                children: [
                  Icon(Icons.search, color: Colors.black87),
                  SizedBox(width: 15),
                  Text(
                    "378429749820294337",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: mainBlue),
                  ),
                ],
              ),
            ),
          ),

          // --- List Hasil SPPT ---
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                // DATA TAHUN 2021
                _buildSpptCard(
                  context,
                  tahun: "2021",
                  lokasi: "DS. Ngireng-ireng RT01/RW01",
                  nominal: "200,000",
                  status: "Belum Lunas",
                  statusColor: const Color(0xFFF27878),
                ),
                const SizedBox(height: 15),
                // DATA TAHUN 2020
                _buildSpptCard(
                  context,
                  tahun: "2020",
                  lokasi: "DS. Ngireng-ireng RT01/RW01",
                  nominal: "376,000",
                  status: "Sudah Lunas", 
                  statusColor: const Color(0xFF4CAF50),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpptCard(
    BuildContext context, {
    required String tahun,
    required String lokasi,
    required String nominal,
    required String status,
    required Color statusColor,
  }) {
    const Color mainBlue = Color(0xFF0A3D6D);

    return InkWell(
      onTap: () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailSpptPage(
              statusBayar: status, 
              tahun: tahun,        
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(11),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                child: Text(
                  status,
                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SPPT $tahun",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: mainBlue),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, color: Colors.black54, size: 20),
                      const SizedBox(width: 10),
                      Text(lokasi, style: const TextStyle(color: Colors.black87)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.monetization_on, color: Colors.black, size: 20),
                      const SizedBox(width: 10),
                      const Text("NJOP Bumi dan Bangunan", style: TextStyle(color: Colors.black87)),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: mainBlue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          nominal,
                          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Divider(),
                  const Center( 
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Lihat Detail", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
                        Icon(Icons.chevron_right, color: Colors.grey),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}