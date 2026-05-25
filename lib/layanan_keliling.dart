import 'package:flutter/material.dart';
import 'pbb1.dart'; 

// Pindahkan ke sini agar bisa dipakai semua class & tidak bikin kuning (warning)
const Color mainBlue = Color(0xFF0A3D6D);

class LayananKelilingPage extends StatelessWidget {
  const LayananKelilingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.grey, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Layanan Keliling",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _DateTab(date: "21/01/2024", isSelected: true),
                _DateTab(date: "25/01/2024"),
                _DateTab(date: "28/01/2024"),
              ],
            ),
          ),
          const SizedBox(height: 25),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Hari ini, 21 Januari 2024",
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: const [
                _ServiceCard(
                  title: "Mobil 01",
                  time: "08:00 - 16:00",
                  location: "Mangir lor & Manager tengah, sendang",
                ),
                SizedBox(height: 15),
                _ServiceCard(
                  title: "Mobil 02",
                  time: "08:00 - 16:00",
                  location: "Mangir lor & Manager tengah, sendang",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DateTab extends StatelessWidget {
  final String date;
  final bool isSelected;
  const _DateTab({required this.date, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? mainBlue : const Color(0xFFF3F6F9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.calendar_month,
            size: 18,
            color: isSelected ? Colors.orange : mainBlue,
          ),
          const SizedBox(width: 8),
          Text(
            date,
            style: TextStyle(
              color: isSelected ? Colors.white : mainBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String title;
  final String time;
  final String location;
  const _ServiceCard({required this.title, required this.time, required this.location});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const PbbPage()));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: mainBlue)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(color: mainBlue, borderRadius: BorderRadius.circular(20)),
                  child: Text(time, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.grey, size: 20),
                const SizedBox(width: 8),
                Expanded(child: Text(location, style: const TextStyle(color: Colors.black54, fontSize: 14))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}