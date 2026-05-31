import 'package:flutter/material.dart';

class DetailSpptPage extends StatelessWidget {

  final String statusBayar;
  final String tahun;

  const DetailSpptPage({
    super.key, 
    required this.statusBayar, 
    required this.tahun
  });

  @override
  Widget build(BuildContext context) {
    const Color mainBlue = Color(0xFF0A3D6D);

    Color badgeColor = statusBayar == "Sudah Lunas" ? const Color(0xFF4CAF50) : const Color.fromARGB(255, 255, 0, 0);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: mainBlue, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Rincian Pajak $tahun", 
          style: const TextStyle(color: mainBlue, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("No. NOP 378429749820294337", style: TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(height: 8),
            const Text(
              "AHMAD NABIL BAHROIN\nROGER SUMATRA",
              style: TextStyle(color: mainBlue, fontSize: 22, fontWeight: FontWeight.bold, height: 1.2),
            ),
            const SizedBox(height: 30),
            const Divider(thickness: 1, height: 1),
            const SizedBox(height: 20),

            _buildDetailItem("Lokasi", "DS. Ngireng-ireng, RT01/RW01"),
            
            _buildDetailStatus("Status Pembayaran", statusBayar, badgeColor),
            
            _buildDetailItem("Tahun Pajak", tahun),
            _buildDetailItem("Denda Administrasi", statusBayar == "Sudah Lunas" ? "Rp. 0" : "Rp. 5.000"),
            _buildDetailItem("NJOP Bumi", "Rp. 300,000"),
            _buildDetailItem("Luas Bumi", "227 m\u00B2"),

            const SizedBox(height: 40),
            
            if (statusBayar == "Sudah Lunas")
              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download_rounded, color: mainBlue),
                  label: const Text("Unduh Bukti Bayar", style: TextStyle(color: mainBlue, fontWeight: FontWeight.bold)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: mainBlue, width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(color: Color(0xFF2D3142), fontSize: 17, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Divider(color: Colors.grey.shade200, thickness: 1),
        ],
      ),
    );
  }

  // 3. Tambahkan parameter Color agar warna badge bisa berubah (Hijau/Orange)
  Widget _buildDetailStatus(String title, String status, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: color, 
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
          const SizedBox(height: 12),
          Divider(color: Colors.grey.shade200, thickness: 1),
        ],
      ),
    );
  }
}