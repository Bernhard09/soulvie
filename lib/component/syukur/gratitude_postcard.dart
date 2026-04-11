import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Pastikan import path ini sesuai dengan lokasi file provider-mu
import 'package:soulvie_app/features/koleksi_syukur/logic/koleksi_provider.dart';
import 'package:soulvie_app/features/koleksi_syukur/model/gratitude.dart';

class GratitudePostCard extends ConsumerWidget {
  final GratitudePost post; // Sekarang kita passing object model-nya langsung

  const GratitudePostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade300,
                ),
                child: const Icon(Icons.person, color: Colors.grey),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      post.date,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),

              // --- POPUP MENU HAPUS & SIMPAN ---
              PopupMenuButton<String>(
                icon: const Icon(Icons.menu, color: Colors.black54),
                onSelected: (value) {
                  if (value == 'hapus') {
                    ref
                        .read(koleksiControllerProvider.notifier)
                        .hapusPostingan(post.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Postingan dihapus')),
                    );
                  } else if (value == 'simpan') {
                    ref
                        .read(koleksiControllerProvider.notifier)
                        .toggleSimpan(post.id);
                    final isNowSaved = !post.isSaved; // Status baru
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isNowSaved
                              ? 'Postingan disimpan ke koleksi'
                              : 'Batal menyimpan postingan',
                        ),
                      ),
                    );
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'simpan',
                    // Label teks berubah secara dinamis tergantung status
                    child: Text(
                      post.isSaved ? 'Hapus dari Simpanan' : 'Simpan Postingan',
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'hapus',
                    child: Text('Hapus', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          Text(
            post.content,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
