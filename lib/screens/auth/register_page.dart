import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Global Key untuk mengontrol validasi Form secara otomatis
  final _formKey = GlobalKey<FormState>();

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

  // =========================================================================
  // PERBAIKAN ALUR NAVIGASI: KEMBALI KE HALAMAN LOGIN SETELAH BERHASIL
  // =========================================================================
  void _prosesDaftar() {
    // Memicu pengecekan seluruh validator di TextFormField secara otomatis
    if (_formKey.currentState!.validate()) {
      // Jika semua form valid, tampilkan sukses
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 10),
              Text("Pendaftaran Berhasil! Selamat Datang, ${_inputNama.text}."),
            ],
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );

      // Kembalikan data pendaftaran ke halaman login sebagai syarat wajib login
      Navigator.pop(context, {
        'email': _inputEmail.text.trim(),
        'password': _inputPass.text.trim(),
      });
    }
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
        child: Form(
          key: _formKey, // Membungkus inputan dengan widget Form
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

              _buildField("Nama Lengkap", Icons.person_outline, _inputNama, (value) {
                if (value == null || value.isEmpty) {
                  return "Nama lengkap tidak boleh kosong!";
                }
                return null;
              }),
              const SizedBox(height: 16),
              
              _buildField("Email", Icons.email_outlined, _inputEmail, (value) {
                if (value == null || value.isEmpty) {
                  return "Email tidak boleh kosong!";
                }
                if (!value.contains('@')) {
                  return "Format email salah! Harus menggunakan '@'";
                }
                return null;
              }),
              const SizedBox(height: 16),
              
              _buildField("Nomor Telepon", Icons.phone_android, _inputPhone, (value) {
                if (value == null || value.isEmpty) {
                  return "Nomor telepon tidak boleh kosong!";
                }
                return null;
              }, keyboardType: TextInputType.phone),
              const SizedBox(height: 16),

              _buildPasswordField("Kata Sandi", _inputPass, _isSecure, () {
                setState(() => _isSecure = !_isSecure);
              }, (value) {
                if (value == null || value.isEmpty) {
                  return "Kata sandi tidak boleh kosong!";
                }
                if (value.length < 6) {
                  return "Kata sandi minimal harus 6 karakter!";
                }
                return null;
              }),
              const SizedBox(height: 16),
              
              _buildPasswordField("Konfirmasi Kata Sandi", _inputConfirm, _isConfirmSecure, () {
                setState(() => _isConfirmSecure = !_isConfirmSecure);
              }, (value) {
                if (value == null || value.isEmpty) {
                  return "Konfirmasi kata sandi tidak boleh kosong!";
                }
                if (value != _inputPass.text) {
                  return "Kata sandi tidak cocok!";
                }
                return null;
              }),

              const SizedBox(height: 40),

              // Tombol Daftar
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF003566),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _prosesDaftar,
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
      ),
    );
  }

  // Widget pembantu (Helper) yang sudah di-upgrade ke TextFormField + Validator
  Widget _buildField(
    String label, 
    IconData icon, 
    TextEditingController ctrl, 
    String? Function(String?)? validator,
    {TextInputType keyboardType = TextInputType.text}
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          controller: ctrl,
          keyboardType: keyboardType,
          validator: validator, // Menyuntikkan fungsi validasi
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: const Color(0xFF003566)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField(
    String label, 
    TextEditingController ctrl, 
    bool hide, 
    VoidCallback toggle,
    String? Function(String?)? validator
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          controller: ctrl,
          obscureText: hide,
          validator: validator, // Menyuntikkan fungsi validasi
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF003566)),
            suffixIcon: IconButton(
              icon: Icon(hide ? Icons.visibility_off : Icons.visibility),
              onPressed: toggle,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
          ),
        ),
      ],
    );
  }
}