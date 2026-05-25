import 'package:flutter/material.dart';
// ignore: unused_import
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _inputNama = TextEditingController();
  final _inputEmail = TextEditingController();
  final _inputPhone = TextEditingController();
  final _inputPass = TextEditingController();
  final _inputConfirm = TextEditingController();
  
  bool _isSecure = true;
  bool _isConfirmSecure = true;

  @override
  void dispose() {
    _inputNama.dispose();
    _inputEmail.dispose();
    _inputPhone.dispose();
    _inputPass.dispose();
    _inputConfirm.dispose();
    super.dispose();
  }

  void _prosesDaftar() {
    if (_inputNama.text.isEmpty || _inputEmail.text.isEmpty || _inputPass.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Mohon lengkapi semua data!"),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Cek apakah password cocok
    if (_inputPass.text != _inputConfirm.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Kata sandi tidak cocok!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Jika OK, tampilkan sukses dan pindah halaman
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Pendaftaran Berhasil!"),
        backgroundColor: Colors.green,
      ),
    );

    // Berpindah kembali ke halaman Login
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF003566)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Daftar Akun",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF003566)),
            ),
            const Text(
              "Buat akun baru untuk mengakses LaPak Bantul",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 32),

            _buildField("Nama Lengkap", Icons.person_outline, _inputNama),
            const SizedBox(height: 16),
            _buildField("Email", Icons.email_outlined, _inputEmail),
            const SizedBox(height: 16),
            _buildField("Nomor Telepon", Icons.phone_android, _inputPhone),
            const SizedBox(height: 16),

            _buildPasswordField("Kata Sandi", _inputPass, _isSecure, () {
              setState(() => _isSecure = !_isSecure);
            }),
            const SizedBox(height: 16),
            _buildPasswordField("Konfirmasi Kata Sandi", _inputConfirm, _isConfirmSecure, () {
              setState(() => _isConfirmSecure = !_isConfirmSecure);
            }),

            const SizedBox(height: 40),

            // Tombol Daftar yang sudah aktif
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF003566),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _prosesDaftar, // Memanggil fungsi di atas
                child: const Text(
                  "Daftar",
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // Widget pembantu (Helper) agar kode rapi
  Widget _buildField(String label, IconData icon, TextEditingController ctrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: ctrl,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: const Color(0xFF003566)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField(String label, TextEditingController ctrl, bool hide, VoidCallback toggle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: ctrl,
          obscureText: hide,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF003566)),
            suffixIcon: IconButton(
              icon: Icon(hide ? Icons.visibility_off : Icons.visibility),
              onPressed: toggle,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }
}