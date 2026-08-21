import 'home_model.dart';
import 'home_remote_data_source.dart';

class HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepository(this.remoteDataSource);

  // Dashboard statistics intentionally remain static for now.
  List<DashboardStat> dashboardStats() {
    return [
      DashboardStat(
        title: 'Resolved',
        value: '1,284',
      ),
      DashboardStat(
        title: 'In Progress',
        value: '46',
      ),
      DashboardStat(
        title: 'Avg Resolution',
        value: '4.2d',
      ),
    ];
  }

  Future<List<Alert>> getActiveAlerts() {
    return remoteDataSource.getActiveAlerts();
  }

  Future<List<Content>> getLatestContents({
    int limit = 5,
  }) {
    return remoteDataSource.getLatestContents(
      limit: limit,
    );
  }
}