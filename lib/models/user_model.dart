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

  // Fungsi konversi JSON (Mengurai satu per satu ke variabel lokal)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    int idBaru = json['id'];
    String emailBaru = json['email'].toString();
    String namaDepan = json['first_name'].toString();
    String namaBelakang = json['last_name'].toString();
    String fotoProfil = json['avatar'].toString();

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
    return '$firstName $lastName';
  }
}