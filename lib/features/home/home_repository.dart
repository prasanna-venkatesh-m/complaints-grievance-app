import 'home_model.dart';
import 'home_remote_data_source.dart';

class HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepository(this.remoteDataSource);

  // =======================
  // DASHBOARD
  // =======================

  Future<DashboardData> getDashboard({
    required String userId,
  }) {
    return remoteDataSource.getDashboard(
      userId: userId,
    );
  }

  // =======================
  // ACTIVE ALERTS
  // =======================

  Future<List<Alert>> getActiveAlerts() {
    return remoteDataSource.getActiveAlerts();
  }

  // =======================
  // LATEST CONTENT
  // =======================

  Future<List<Content>> getLatestContents({
    int limit = 5,
  }) {
    return remoteDataSource.getLatestContents(
      limit: limit,
    );
  }
}