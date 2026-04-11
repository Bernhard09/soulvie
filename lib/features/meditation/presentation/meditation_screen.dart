import 'package:flutter/material.dart';
import 'package:soulvie_app/common/app_colors.dart';
import 'package:soulvie_app/features/meditation/presentation/meditation_player_screen.dart';

class MeditasiScreen extends StatefulWidget {
  const MeditasiScreen({Key? key}) : super(key: key);

  @override
  State<MeditasiScreen> createState() => _MeditasiScreenState();
}

class _MeditasiScreenState extends State<MeditasiScreen> {
  // Variabel untuk menyimpan filter mana yang sedang diklik.
  // Default awalnya adalah "Semua"
  String _selectedFilter = "Semua";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      // 1. HEADER MELENGKUNG
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        toolbarHeight: 80,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Meditasi',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              backgroundImage: const NetworkImage(
                'https://i.pravatar.cc/150?img=11',
              ),
            ),
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 3. ROW FILTER KATEGORI
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Kita tidak perlu lagi mengirim boolean isActive secara manual,
                  // cukup kirim nama titlenya saja.
                  _buildFilterItem("Semua", Icons.dashboard_outlined),
                  _buildFilterItem("Favorit", Icons.favorite_border),
                  _buildFilterItem("Cemas", Icons.sentiment_dissatisfied),
                  _buildFilterItem("Tidur", Icons.dark_mode_outlined),
                ],
              ),
              const SizedBox(height: 24),

              // 4. CARD ATAS (RELAKSASI) MENGGUNAKAN STACK
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.bgCardMeditation, // fallback color
                  image: const DecorationImage(
                    image: AssetImage('assets/images/grup_card_meditation.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: 20,
                      bottom: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Relaksasi',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Musik',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Text(
                                '3-10 Menit',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 16),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MeditasiPlayerScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: AppColors.textDark,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 8,
                                  ),
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text(
                                  'MULAI',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 5. CARD TENGAH (PLAYER) MENGGUNAKAN STACK
              Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.bgCardMeditation,
                  image: const DecorationImage(
                    image: AssetImage('assets/images/meditation_player.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 20,
                      bottom: 16,
                      child: Row(
                        children: const [
                          Text(
                            'MEDITASI',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '• 3-10 MIN',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 20,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        // Membungkus Container dengan GestureDetector agar bisa diklik
                        child: GestureDetector(
                          onTap: () {
                            // Logika untuk berpindah ke halaman player
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const MeditasiPlayerScreen(),
                              ),
                            );
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(6),
                            child: const Icon(
                              Icons.play_arrow,
                              color: AppColors.textDark,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 6. HEADER REKOMENDASI
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Rekomendasi untukmu',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  Text(
                    'Tampilkan lainnya',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 7. LIST REKOMENDASI (HORIZONTAL)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildRecommendationCard(
                      'assets/images/rekomendasi_meditasi1.png',
                      'Fokus',
                    ),
                    const SizedBox(width: 16),
                    _buildRecommendationCard(
                      'assets/images/rekomendasi_meditasi2.png',
                      'Kebahagiaan',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // 8. BOTTOM NAVIGATION BAR (DUMMY)
    );
  }

  // WIDGET BANTUAN UNTUK FILTER DENGAN FITUR KLIK
  Widget _buildFilterItem(String title, IconData icon) {
    // Mengecek apakah filter ini yang sedang dipilih
    bool isActive = _selectedFilter == title;

    return GestureDetector(
      onTap: () {
        // setState akan me-refresh layar untuk menerapkan warna baru
        setState(() {
          _selectedFilter = title;
        });
      },
      child: Column(
        children: [
          // Animasi transisi warna agar lebih halus saat diklik
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : AppColors.cardBg,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.white : AppColors.textLight,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: isActive ? AppColors.textDark : AppColors.textLight,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // WIDGET BANTUAN UNTUK CARD REKOMENDASI
  Widget _buildRecommendationCard(String imagePath, String title) {
    return SizedBox(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              height: 120,
              width: 160,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'MEDITASI • 3-10 MIN',
            style: TextStyle(fontSize: 10, color: AppColors.textLight),
          ),
        ],
      ),
    );
  }
}
