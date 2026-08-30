import 'package:tvk_grievance/features/home/home_model.dart';

import 'content_details_remote_data_source.dart';

class ContentDetailsRepository {
  final ContentDetailsRemoteDataSource remoteDataSource;

  ContentDetailsRepository({
    required this.remoteDataSource,
  });

  Future<Content> getContentById(
    String contentId,
  ) async {
    return remoteDataSource.getContentById(
      contentId,
    );
  }
}