import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/models/media_file_model.dart';


class MediaPickerService {

  final ImagePicker _picker = ImagePicker();


  Future<MediaFileModel?> capturePhoto() async {

    final result = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );


    if(result == null) return null;


    return MediaFileModel(
      file: File(result.path),
      type: MediaType.image, isImage: true,
    );
  }



  Future<MediaFileModel?> captureVideo() async {

    final result = await _picker.pickVideo(
      source: ImageSource.camera,
      maxDuration:
          const Duration(minutes: 5),
    );


    if(result == null) return null;


    return MediaFileModel(
      file: File(result.path),
      type: MediaType.video, isImage: false,
    );
  }



  Future<List<MediaFileModel>> pickFiles() async {


    final result =
        await FilePicker.platform.pickFiles(

      allowMultiple: true,

      type: FileType.custom,

      allowedExtensions: [
        "jpg",
        "jpeg",
        "png",
        "webp",
        "mp4",
        "mov",
        "avi",
      ],
    );


    if(result == null) return [];


    return result.files
        .where(
          (e)=> e.path != null,
        )
        .map((e){

          final ext =
              e.extension?.toLowerCase();


          return MediaFileModel(
            file: File(e.path!),

            type:
              [
                "mp4",
                "mov",
                "avi",
              ].contains(ext)
              ? MediaType.video
              : MediaType.image, isImage: false,
          );

        })
        .toList();
  }
}