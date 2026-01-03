import 'package:dz_pub/api/advertisement.dart';
import 'package:dz_pub/view/admin_ui/widgets/video_player_screen.dart';
import 'package:flutter/material.dart';

class MediaPreviewWidget extends StatelessWidget {
  final Advertisement ad;
  final double aspectRatio;
  final double? height;

  const MediaPreviewWidget({
    super.key,
    required this.ad,
    this.aspectRatio = 16 / 9,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (ad.filePath == null || ad.filePath!.isEmpty) {
      content = Container(
        color: Colors.grey.shade200,
        child: const Icon(Icons.no_photography, color: Colors.grey, size: 40),
      );
    } else if (ad.isImage) {
      content = Image.network(
        ad.fullImageUrl!,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey.shade200,
            child: const Icon(Icons.error, color: Colors.red),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: Colors.grey.shade100,
            child: const Center(child: CircularProgressIndicator()),
          );
        },
      );
    } else if (ad.isVideo) {
      content = GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VideoPlayerScreen(url: ad.fullImageUrl!),
            ),
          );
        },
        child: Container(
          color: Colors.black.withOpacity(0.05),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Icon(Icons.video_collection, color: Colors.grey, size: 50),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.black45,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const Positioned(
                bottom: 8,
                right: 8,
                child: Text(
                  'فيديو',
                  style: TextStyle(
                    color: Colors.white,
                    backgroundColor: Colors.black26,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      content = Container(
        color: Colors.grey.shade200,
        child: const Icon(Icons.insert_drive_file, color: Colors.grey),
      );
    }

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: SizedBox(width: double.infinity, height: height, child: content),
    );
  }
}
