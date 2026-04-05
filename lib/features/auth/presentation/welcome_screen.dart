import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:soulvie_app/common/app_colors.dart';
import 'package:soulvie_app/features/auth/presentation/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. Background Melengkung (Curved Background)
          ClipPath(
            clipper: _CurveClipper(),
            child: Container(
              width: size.width,
              height: size.height * 0.65, // Mengambil 65% tinggi layar
              color: AppColors.primary,
            ),
          ),

          // 2. Watermark Logo Transparan di Latar Belakang (Opsional)
          Positioned(
            top: 40,
            right: -100,
            child: Opacity(
              opacity: 0.1, // Dibuat sangat tipis
              child: SvgPicture.asset(
                'assets/images/app_logo.svg', // Pastikan path ini sesuai
                width: 350,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),

          // 3. Konten Utama
          SafeArea(
            child: Column(
              children: [
                // Spacer untuk mendorong logo ke tengah area background
                SizedBox(height: size.height * 0.32),

                // Logo Utama & Nama Aplikasi
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/app_logo.svg',
                      width: 60,
                      height: 78,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'SOULVIA',
                      style: TextStyle(
                        fontSize: 43,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 250),

                // Tombol Mulai Sekarang
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24.0,
                    right: 24.0,
                    bottom: 40.0,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Mulai Sekarang',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// CustomClipper untuk membuat efek lengkungan di bawah background
class _CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Mulai dari kiri atas
    path.lineTo(0, size.height * 0.75);

    // Buat kurva bezier ke kanan
    path.quadraticBezierTo(
      size.width * 0.3, // Titik tengah X kurva
      size.height * 1, // Titik tarikan Y kurva (makin besar makin melengkung)
      size.width, // Titik akhir X kurva
      size.height * 0.92, // Titik akhir Y kurva
    );

    // Tarik garis ke kanan atas lalu tutup
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
