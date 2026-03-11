import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../theme/theme.dart';
import '../../../widgets/song/song_tile.dart';
import '../view_model/library_view_model.dart';
import '../../../states/async_value.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    // 1- Read the globbal song repository
    LibraryViewModel mv = context.watch<LibraryViewModel>();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Library", style: AppTextStyles.heading),
          SizedBox(height: 50),
          
          Expanded(
            child: switch (mv.songs.status) {
              AsyncStatus.loading => Center(
                  child: CircularProgressIndicator(),
                ),
              AsyncStatus.error => Center(
                  child: Text(
                    mv.songs.errorMessage ?? "An error occurred",
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),

              AsyncStatus.data => ListView.builder(
                  itemCount: mv.songs.value?.length ?? 0,
                  itemBuilder: (context, index) {
                    final song = mv.songs.value![index];
                    return SongTile(
                      song: song,
                      isPlaying: mv.isSongPlaying(song),
                      onTap: () {
                        mv.start(song);
                      },
                    );
                  },
                ),
            },
          ),
        ],
      ),
    );
  }
}
