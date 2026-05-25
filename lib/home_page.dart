import 'package:flutter/material.dart';
import 'home2.dart'; // Ke Page 2
import 'pbb1.dart';  // Ke Page 4

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Beranda",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage("assets/images/profil lapak bantul.jpg"),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          /// HEADER BIRU
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(color: Color(0xFF0A3D6D)),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("LaPak Bantul", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(height: 6),
                      Text("Pusat layanan pajak\nterpadu", style: TextStyle(fontSize: 14, color: Colors.white70)),
                    ],
                  ),
                ),
                Container(
                  width: 70, height: 70,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.yellow[200]),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset("assets/images/profil lapak bantul.jpg", fit: BoxFit.contain),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          /// GRID MENU
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  MenuItem(
                    icon: Icons.description,
                    title: "PBB",
                    onTap: () {
                      // LANGSUNG KE PAGE 4
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const PbbPage()));
                    },
                  ),
                  MenuItem(icon: Icons.description, title: "BPHTB", onTap: () {}),
                  MenuItem(icon: Icons.event_note, title: "Rekap", onTap: () {}),
                  MenuItem(
                    icon: Icons.local_shipping,
                    title: "Layanan\nKeliling",
                    onTap: () {
                      // KE PAGE 2
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Home2()));
                    },
                  ),
                  MenuItem(icon: Icons.info, title: "Informasi", onTap: () {}),
                  MenuItem(icon: Icons.grid_view, title: "Lainnya", onTap: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const MenuItem({super.key, required this.icon, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF3F6F9),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.black87),
            const SizedBox(height: 12),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}