import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/google_user_service.dart';

class ApiDemoPage extends StatefulWidget {
  const ApiDemoPage({super.key});

  @override
  State<ApiDemoPage> createState() => _ApiDemoPageState();
}

class _ApiDemoPageState extends State<ApiDemoPage> {
  Future<List<UserModel>> ambilDataPengguna() async {
    final googleUserService = GoogleUserService();
    if (googleUserService.isLoggedIn) {
      debugPrint(
        'ambilDataPengguna: User sudah login via Google — menampilkan data real user',
      );
      final googleUser = googleUserService.currentUser!;

      final namaParts = (googleUser.displayName ?? 'User').split(' ');
      final firstName = namaParts.isNotEmpty ? namaParts[0] : 'User';
      final lastName = namaParts.length > 1
          ? namaParts.sublist(1).join(' ')
          : '';

      return [
        UserModel(
          id: 1,
          email: googleUser.email,
          firstName: firstName,
          lastName: lastName,
          avatar: googleUser.photoUrl ?? '',
        ),
      ];
    }

    debugPrint(
      'ambilDataPengguna: User belum login Google — tidak menampilkan data lain',
    );
    throw Exception(
      'Silakan masuk dengan Google terlebih dahulu untuk melihat data pengguna.',
    );
  }

  Widget _buildAvatar(String avatarUrl, String name) {
    final initials = name.isNotEmpty
        ? name
              .trim()
              .split(' ')
              .where((part) => part.isNotEmpty)
              .map((part) => part[0])
              .take(2)
              .join()
              .toUpperCase()
        : 'U';

    if (avatarUrl.isEmpty) {
      return CircleAvatar(
        radius: 30,
        backgroundColor: const Color(0xFF003566).withOpacity(0.15),
        child: Text(
          initials,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return CircleAvatar(
      radius: 30,
      backgroundColor: const Color(0xFF003566).withOpacity(0.15),
      child: ClipOval(
        child: Image.network(
          avatarUrl,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Text(
                initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final googleUserService = GoogleUserService();
    final isGoogleLoggedIn = googleUserService.isLoggedIn;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Data Pengguna",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            if (isGoogleLoggedIn)
              Text(
                "Akun Google: ${googleUserService.userEmail}",
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              )
            else
              const Text(
                "Silakan login dengan Google untuk melihat data pengguna",
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
          ],
        ),
        backgroundColor: const Color(0xFF003566),
        centerTitle: false,
        elevation: 0,
      ),
      body: FutureBuilder<List<UserModel>>(
        future: ambilDataPengguna(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF003566)),
            );
          }

          if (snapshot.hasError) {
            final String err = snapshot.error.toString();
            final bool missingKey =
                err.toLowerCase().contains('missing_api_key') ||
                err.toLowerCase().contains('missing/invalid key') ||
                err.contains('401');

            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      err,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    const SizedBox(height: 12),
                    if (missingKey) ...[
                      const Text(
                        'Sepertinya API membutuhkan x-api-key. Buat key gratis di app.reqres.in dan masukkan ke lib/config/env.dart',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Buka lib/config/env.dart lalu isi Env.apiKey dengan nilai key Anda.',
                              ),
                            ),
                          );
                        },
                        child: const Text('Cara isi API key'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF003566),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }

          if (snapshot.hasData) {
            final listUser = snapshot.data!;

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: listUser.length,
              itemBuilder: (context, index) {
                final user = listUser[index];

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: _buildAvatar(user.avatar, user.namaLengkap),
                    title: Text(
                      user.namaLengkap,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF003566),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        user.email,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            );
          }

          return const Center(child: Text("Tidak ada data ditemukan."));
        },
      ),
    );
  }
}
