import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

// Pastikan path ini sesuai dengan struktur folder project kamu
import '../../../common/app_colors.dart';

class MeditasiPlayerScreen extends StatefulWidget {
  const MeditasiPlayerScreen({Key? key}) : super(key: key);

  @override
  State<MeditasiPlayerScreen> createState() => _MeditasiPlayerScreenState();
}

class _MeditasiPlayerScreenState extends State<MeditasiPlayerScreen> {
  // 1. Inisialisasi Audio Player dan Variabel State
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  // Variabel baru untuk mencegah "Slider Jumping"
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _setupAudio();
  }

  // 2. Fungsi untuk mengatur audio
  Future<void> _setupAudio() async {
    // Membaca file dari folder assets/audio/
    await _audioPlayer.setSource(AssetSource('audio/relaxation.mp3'));

    // Mendengarkan perubahan status (Play/Pause)
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (!mounted) return; // MENCEGAH ERROR: Hentikan jika layar sudah ditutup
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });

    // Mendengarkan total durasi lagu
    _audioPlayer.onDurationChanged.listen((newDuration) {
      if (!mounted) return; // MENCEGAH ERROR: Hentikan jika layar sudah ditutup
      setState(() {
        _duration = newDuration;
      });
    });

    // Mendengarkan posisi lagu saat ini (berjalan setiap detik)
    _audioPlayer.onPositionChanged.listen((newPosition) {
      if (!mounted) return; // MENCEGAH ERROR: Hentikan jika layar sudah ditutup

      // PENTING: Hanya update posisi UI otomatis jika user TIDAK sedang menggeser slider
      if (!_isDragging) {
        setState(() {
          _position = newPosition;
        });
      }
    });
  }

  // 3. PENTING: Matikan audio saat keluar dari halaman agar tidak bocor
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // Fungsi mengubah format detik menjadi Menit:Detik (Contoh: 01:30)
  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgmeditationplayer,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        // --- TAMBAHKAN BAGIAN INI ---
        // flexibleSpace akan menggambar widget di belakang elemen AppBar lainnya
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/Ornamen.png',
              ), // Path menggunakan '/'
              fit: BoxFit.cover, // Agar gambarnya membentang memenuhi ruang
            ),
          ),
        ),

        // -----------------------------
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Meditasi',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 60),
          const Text(
            'Relaksasi',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),

          // KONTROL PLAYER
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.replay_5, color: Colors.white, size: 32),
                onPressed: () {
                  // Mundur 15 detik
                  final newPosition = _position - const Duration(seconds: 15);
                  _audioPlayer.seek(
                    newPosition < Duration.zero ? Duration.zero : newPosition,
                  );
                },
              ),
              const SizedBox(width: 24),

              // Tombol Play / Pause
              GestureDetector(
                onTap: () {
                  if (_isPlaying) {
                    _audioPlayer.pause();
                  } else {
                    _audioPlayer.resume();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.3),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.black87,
                      size: 32,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 24),
              IconButton(
                icon: const Icon(
                  Icons.forward_5,
                  color: Colors.white,
                  size: 32,
                ),
                onPressed: () {
                  // Maju 15 detik
                  final newPosition = _position + const Duration(seconds: 15);
                  _audioPlayer.seek(
                    newPosition > _duration ? _duration : newPosition,
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 40),

          // SLIDER & WAKTU
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 4.0,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 8.0,
                    ),
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Colors.white.withOpacity(0.3),
                    thumbColor: Colors.white,
                  ),
                  child: Slider(
                    min: 0,
                    max: _duration.inSeconds.toDouble() > 0
                        ? _duration.inSeconds.toDouble()
                        : 1.0,
                    value: _position.inSeconds.toDouble().clamp(
                      0.0,
                      _duration.inSeconds.toDouble() > 0
                          ? _duration.inSeconds.toDouble()
                          : 1.0,
                    ),
                    // Saat mulai digeser
                    onChangeStart: (value) {
                      setState(() {
                        _isDragging = true;
                      });
                    },
                    // Saat sedang digeser (hanya update UI lokal)
                    onChanged: (value) {
                      setState(() {
                        _position = Duration(seconds: value.toInt());
                      });
                    },
                    // Saat jari dilepas
                    onChangeEnd: (value) {
                      final position = Duration(seconds: value.toInt());
                      _audioPlayer.seek(position);
                      setState(() {
                        _isDragging = false;
                      });
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatTime(_position),
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        _formatTime(_duration),
                        style: TextStyle(color: Colors.white.withOpacity(0.8)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          Image.asset(
            'assets/images/grub_meditation_player.png',
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
