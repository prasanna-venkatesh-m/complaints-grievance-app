import 'package:flutter/material.dart';
import 'package:tvk_grievance/core/shared_widgets/media_upload_widget.dart';
import '../../../core/services/media_picker_service.dart';
import '../grievance_controller.dart';

class GrievanceMediaSection extends StatelessWidget {
  final GrievanceController controller;

  const GrievanceMediaSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final service = MediaPickerService();

    return MediaUploadWidget(
      files: controller.attachments,

      onAdd: () async {
        final source = await showModalBottomSheet<MediaSource>(
          context: context,
          builder: (_) => const _MediaSourceSheet(),
        );

        if (source == null) return;

        switch (source) {
          case MediaSource.cameraPhoto:
            final media = await service.capturePhoto();

            if (media != null) {
              controller.addMedia([media]);
            }
            break;

          case MediaSource.cameraVideo:
            final media = await service.captureVideo();

            if (media != null) {
              controller.addMedia([media]);
            }
            break;

          case MediaSource.files:
            final files = await service.pickFiles();

            if (files.isNotEmpty) {
              controller.addMedia(files);
            }
            break;
        }
      },

      onRemove: controller.removeMedia,
    );
  }
}

enum MediaSource { cameraPhoto, cameraVideo, files }

class _MediaSourceSheet extends StatelessWidget {
  const _MediaSourceSheet();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.photo_camera),
            title: const Text("Take Photo"),
            onTap: () => Navigator.pop(context, MediaSource.cameraPhoto),
          ),
          ListTile(
            leading: const Icon(Icons.videocam),
            title: const Text("Record Video"),
            onTap: () => Navigator.pop(context, MediaSource.cameraVideo),
          ),
          ListTile(
            leading: const Icon(Icons.folder),
            title: const Text("Choose Files"),
            onTap: () => Navigator.pop(context, MediaSource.files),
          ),
        ],
      ),
    );
  }
}
