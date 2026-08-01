import 'dart:io';

enum MediaType {
  image,
  video,
}

class MediaFileModel {
  final File file;
  final MediaType type;

  MediaFileModel({
    required this.file,
    required this.type, required bool isImage,
  });

  bool get isImage => type == MediaType.image;

  bool get isVideo => type == MediaType.video;
}