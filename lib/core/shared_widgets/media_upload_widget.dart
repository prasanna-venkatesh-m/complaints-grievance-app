import 'package:flutter/material.dart';
import '../../shared/models/media_file_model.dart';

class MediaUploadWidget extends StatelessWidget {
  final List<MediaFileModel> files;

  final VoidCallback onAdd;

  final Function(int) onRemove;

  const MediaUploadWidget({
    super.key,

    required this.files,

    required this.onAdd,

    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,

      physics: const NeverScrollableScrollPhysics(),

      itemCount: files.length + 1,

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,

        crossAxisSpacing: 14,

        mainAxisSpacing: 14,
      ),

      itemBuilder: (context, index) {
        if (index == files.length) {
          return InkWell(
            onTap: onAdd,

            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffA00037),

                borderRadius: BorderRadius.circular(14),

                boxShadow: const [
                  BoxShadow(color: Color(0xffffc107), offset: Offset(4, 4)),
                ],
              ),

              child: const Icon(Icons.add, color: Colors.white, size: 35),
            ),
          );
        }

        final item = files[index];

        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),

              child: item.isImage
                  ? Image.file(
                      item.file,

                      fit: BoxFit.cover,

                      width: double.infinity,

                      height: double.infinity,
                    )
                  : Container(
                      color: Colors.black12,

                      child: const Icon(
                        Icons.play_circle,

                        size: 45,

                        color: Color(0xffA00037),
                      ),
                    ),
            ),

            Positioned(
              right: 5,

              top: 5,

              child: GestureDetector(
                onTap: () => onRemove(index),

                child: const CircleAvatar(
                  radius: 12,

                  backgroundColor: Colors.red,

                  child: Icon(Icons.close, size: 15, color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
