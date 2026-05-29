import 'package:flutter/material.dart';
import 'register_page.dart'; 
import 'forgot_password.dart'; // Menyambungkan ke halaman lupa password
import '../../../navigation_bar/navigation.dart'; 

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  // =========================================================================
  // GADUNGAN DATABASE LOKAL: Untuk mengunci agar wajib daftar terlebih dahulu
  // =========================================================================
  String? _registeredEmail;
  String? _registeredPassword;
  bool _sudahDaftar = false;

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
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
                    );
                  }, 
                  child: const Text("Lupa Kata Sandi?"),
                ),
              ),
              const SizedBox(height: 30),

              // =============================================================
              // TOMBOL MASUK DENGAN VALIDASI WAJIB DAFTAR TERLEBIH DAHULU
              // =============================================================
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // KUNCI UTAMA: Harus lewat halaman register dulu (lokal)
                    if (!_sudahDaftar) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Akun belum terdaftar! Silakan klik 'Daftar Sekarang' di bawah terlebih dahulu."),
                          backgroundColor: Colors.orangeAccent,
                        ),
                      );
                      return;
                    }

                    // Validasi form kosong
                    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Email dan Kata Sandi wajib diisi!"),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                      return;
                    }

                    // Validasi kecocokan data input dengan yang di-register (lokal)
                    if (_emailController.text.trim() != _registeredEmail ||
                        _passwordController.text.trim() != _registeredPassword) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Email atau Kata Sandi tidak cocok dengan yang Anda daftarkan!"),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                      return;
                    }

                    // Jika lolos semua validasi lokal, langsung masuk ke MainNavigation
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Login berhasil (verifikasi lokal)."),
                        backgroundColor: Colors.green,
                      ),
                    );

                    if (mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const MainNavigation()),
                      );
                    }
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

              // =============================================================
              // TOMBOL SIMULASI GOOGLE LOGIN SSO (MEMENUHI SYARAT 5)
              // =============================================================
              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton(
                  onPressed: () async {
                    // Efek loading membaca akun Google di HP
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const Center(
                        child: CircularProgressIndicator(color: Colors.redAccent),
                      ),
                    );

                    // Delay buatan 2 detik
                    await Future.delayed(const Duration(seconds: 2));
                    
                    if (mounted) {
                      Navigator.pop(context); // Matikan loading

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Google Sign-In Sukses! Menggunakan Akun Google Perangkat."),
                          backgroundColor: Colors.blue,
                        ),
                      );

                      // Lolos langsung ke beranda utama
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const MainNavigation()),
                      );
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFE0E0E0), width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomPaint(
                        size: const Size(22, 22),
                        painter: GoogleLogoPainter(),
                      ),
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

              // TOMBOL DAFTAR SEKARANG (MEMBAWA DATA KE FORM LOGIN)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Belum memiliki akun?"),
                  TextButton(
                    onPressed: () async {
                      final Map<String, String>? dataPendaftaran = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterPage()),
                      );

                      if (dataPendaftaran != null) {
                        setState(() {
                          _registeredEmail = dataPendaftaran['email'];
                          _registeredPassword = dataPendaftaran['password'];
                          _sudahDaftar = true; 

                          _emailController.text = _registeredEmail ?? '';
                          _passwordController.text = _registeredPassword ?? '';
                        });
                      }
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

class GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final double radius = size.width / 2;
    final Rect rect = Rect.fromCircle(center: Offset(cx, cy), radius: radius);

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.45 
      ..strokeCap = StrokeCap.square;

    paint.color = const Color(0xFFEA4335);
    canvas.drawArc(rect, -2.4, 1.25, false, paint);

    paint.color = const Color(0xFFFBBC05);
    canvas.drawArc(rect, -3.65, 1.25, false, paint);

    paint.color = const Color(0xFF34A853);
    canvas.drawArc(rect, 0.1, 1.25, false, paint);

    paint.color = const Color(0xFF4285F4);
    canvas.drawArc(rect, 1.35, 1.15, false, paint);

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