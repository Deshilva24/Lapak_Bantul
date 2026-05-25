import 'package:flutter/material.dart';
import 'register_page.dart'; 
import '../../../navigation_bar/navigation.dart'; 
// Import file UserModel kamu (naik 3 tingkat ke folder models)
import '../../../../models/user_model.dart'; 

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              const Text(
                "Selamat Datang Kembali",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF003566),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Silakan masuk untuk melanjutkan akses layanan Anda.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 50),

              const Text("Email", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 10),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Masukkan email anda",
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 25),

              const Text("Kata Sandi", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  hintText: "Masukkan kata sandi",
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(onPressed: () {}, child: const Text("Lupa Kata Sandi?")),
              ),
              const SizedBox(height: 30),

              // TOMBOL MASUK KE HOME
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // Validasi email
                    if (!_emailController.text.contains('@') || _emailController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Format email salah! Harus menggunakan '@'"),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                      return; 
                    }

                    if (_passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Kata sandi tidak boleh kosong!"),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                      return;
                    }

                    // LOGIKA PINTAR: Memotong email untuk dijadikan nama otomatis
                    String emailInput = _emailController.text;
                    String namaOtomatis = emailInput.split('@')[0]; 
                    
                    if (namaOtomatis.isNotEmpty) {
                      namaOtomatis = namaOtomatis[0].toUpperCase() + namaOtomatis.substring(1);
                    }

                    // PROSES DATA MENGGUNAKAN USER MODEL
                    Map<String, dynamic> dummyDataJson = {
                      "id": 101,
                      "email": emailInput, 
                      "first_name": namaOtomatis, 
                      "last_name": "", 
                      "avatar": "https://reqres.in/img/faces/1-image.jpg"
                    };

                    UserModel userSiswa = UserModel.fromJson(dummyDataJson);

                    // Menampilkan Snackbar sukses
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            const Icon(Icons.check_circle, color: Colors.white),
                            const SizedBox(width: 10),
                            Text("Sukses Login! Selamat Datang, ${userSiswa.namaLengkap}."),
                          ],
                        ),
                        backgroundColor: Colors.green,
                        duration: const Duration(seconds: 2),
                      ),
                    );

                    // NAVIGASI KE HOME PAGE
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MainNavigation()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF003566),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Masuk", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 15),

              // TOMBOL GOOGLE LOGIN
              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Fitur Google Login sedang disiapkan!"),
                        backgroundColor: Colors.blueAccent,
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFE0E0E0), width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // =============================================================
                      // REPARASI TOTAL: LOGO GOOGLE VECTOR ASLI (PEKAT, BULAT, GENDUT)
                      // =============================================================
                      CustomPaint(
                        size: const Size(22, 22), // Ukuran ideal & pas
                        painter: GoogleLogoPainter(),
                      ),
                      // =============================================================
                      const SizedBox(width: 14),
                      const Text(
                        "Masuk dengan Google",
                        style: TextStyle(
                          fontSize: 16, 
                          fontWeight: FontWeight.bold, 
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),

              // TOMBOL KE REGISTER
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Belum memiliki akun?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterPage()),
                      );
                    },
                    child: const Text("Daftar Sekarang", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================================================================
// CLASS KHUSUS UNTUK MENGGAMBAR LOGO GOOGLE VECTOR ORIGINAL SECARA PRESISI
// =========================================================================
class GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final double radius = size.width / 2;
    final Rect rect = Rect.fromCircle(center: Offset(cx, cy), radius: radius);

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.45 // Membuat ketebalan huruf G pas montoknya
      ..strokeCap = StrokeCap.square;

    // 1. Bagian Merah (Atas)
    paint.color = const Color(0xFFEA4335);
    canvas.drawArc(rect, -2.4, 1.25, false, paint);

    // 2. Bagian Kuning (Kiri)
    paint.color = const Color(0xFFFBBC05);
    canvas.drawArc(rect, -3.65, 1.25, false, paint);

    // 3. Bagian Hijau (Bawah)
    paint.color = const Color(0xFF34A853);
    canvas.drawArc(rect, 0.1, 1.25, false, paint);

    // 4. Bagian Biru (Kanan & Garis Tengah)
    paint.color = const Color(0xFF4285F4);
    canvas.drawArc(rect, 1.35, 1.15, false, paint);

    // Menggambar sayap garis horisontal khas huruf G Google
    final Paint linePaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;
    
    final Rect horizontalBar = Rect.fromLTWH(
      cx, 
      cy - (paint.strokeWidth / 2), 
      radius * 0.95, 
      paint.strokeWidth
    );
    canvas.drawRect(horizontalBar, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}