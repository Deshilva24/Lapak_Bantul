class UserModel {
  // Properti data dasar
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  // Constructor utama
  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  // Fungsi konversi JSON (Sudah dilengkapi pengaman null safety)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Diberi proteksi '??' supaya jika data dari internet kosong, aplikasi tidak crash
    int idBaru = json['id'] ?? 0; 
    String emailBaru = (json['email'] ?? '').toString();
    String namaDepan = (json['first_name'] ?? '').toString();
    String namaBelakang = (json['last_name'] ?? '').toString();
    String fotoProfil = (json['avatar'] ?? '').toString();

    return UserModel(
      id: idBaru,
      email: emailBaru,
      firstName: namaDepan,
      lastName: namaBelakang,
      avatar: fotoProfil,
    );
  }

  // Getter untuk menggabungkan nama lengkap dengan fungsi standar
  String get namaLengkap {
    return '$firstName $lastName'.trim(); // Ditambah .trim() agar spasi rapi jika nama belakang kosong
  }
}