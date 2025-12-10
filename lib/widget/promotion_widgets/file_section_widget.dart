import 'package:dz_pub/api/promations_models/topic_already_ready.dart';
import 'package:dz_pub/constants/strings.dart';
import 'package:dz_pub/widget/promotion_widgets/card_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:dz_pub/api/promations_models/promotions.dart';
import 'package:video_player/video_player.dart';

class FilesSection extends StatelessWidget {
  final Promotion ?promotion;
  final String ?typeName;

  const FilesSection({super.key,  this.promotion,this.typeName});

  bool _isImage(String path) {
    return path.endsWith(".jpg") ||
        path.endsWith(".jpeg") ||
        path.endsWith(".png") ||
        path.endsWith(".gif");
  }

  bool _isVideo(String path) {
    return path.endsWith(".mp4") || path.endsWith(".mov") || path.endsWith(".mkv");
  }

  @override
  Widget build(BuildContext context) {
    final List<TopicAlreadyReady> files = promotion?.topicAlreadyReadies ?? [];

    if (files.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


        ...files.map((file) {
          final fileUrl = "${ServerLocalhostEm.storagePath}${file
              .filePath}"; // عدل الدومين
          debugPrint("file url : $fileUrl");

          if (_isImage(file.filePath)) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  fileUrl,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }

          if (_isVideo(file.filePath)) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _VideoPlayerWidget(url: fileUrl),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text("📄 ملف غير مدعوم: ${file.filePath}"),
          );
        }).toList(),
      ],
    );
  }
}
class _VideoPlayerWidget extends StatefulWidget {
  final String url;

  const _VideoPlayerWidget({required this.url});

  @override
  State<_VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<_VideoPlayerWidget> {
  late VideoPlayerController controller;
  bool initialized = false;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        setState(() => initialized = true);
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!initialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            VideoPlayer(controller),
            VideoProgressIndicator(controller, allowScrubbing: true),
            Positioned(
              bottom: 8,
              left: 8,
              child: IconButton(
                icon: Icon(
                  controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    controller.value.isPlaying
                        ? controller.pause()
                        : controller.play();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
