import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:soulvie_app/features/koleksi_syukur/model/gratitude.dart';

part 'koleksi_provider.g.dart';

@riverpod
class KoleksiController extends _$KoleksiController {
  @override
  List<GratitudePost> build() {
    return [
      GratitudePost(
        id: '1',
        name: 'Pandu Revi Arnan',
        date: '01 Februari 2026',
        content: 'Hari ini aku bersyukur karena masih bisa tersenyum, membayar hutangku dengan lunas, dan bertemu teman SMA ku dulu',
      ),
      GratitudePost(
        id: '2',
        name: 'Pandu Revi Arnan',
        date: '25 Januari 2026',
        content: 'Akhirnya bisa pulang ke rumah tanpa macet, beli coffe dengan diskon, dan tidak perlu lembur malam ini',
      ),
      GratitudePost(
        id: '3',
        name: 'Pandu Revi Arnan',
        date: '29 Desember 2025',
        content: 'Senangnya bisa keterima kerja di perusahaan impianku...',
      ),
      // ... (biarkan sisa data dummy mu yang kemarin di sini)
    ];
  }

  // --- LOGIC TAMBAH POSTINGAN BARU ---
  void tambahPostingan(String content, List<String> images) {
    // Membuat objek postingan baru
    final newPost = GratitudePost(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // ID unik otomatis
      name: 'Pandu Revi Arnan', // Nama statis sementara
      date: '09 April 2026', // Bisa pakai library 'intl' nanti
      content: content,
      images: images,
    );

    // Memasukkan data baru ke urutan paling atas dari list
    state = [newPost, ...state];
  }

  // ... (biarkan fungsi hapusPostingan dan toggleSimpan yang kemarin)
  void hapusPostingan(String id) {
    state = state.where((post) => post.id != id).toList();
  }

  void toggleSimpan(String id) {
    state = state.map((post) {
      if (post.id == id) return post.copyWith(isSaved: !post.isSaved);
      return post;
    }).toList();
  }
}