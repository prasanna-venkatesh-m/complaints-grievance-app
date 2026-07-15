import 'home_model.dart';
import 'home_repository.dart';

class HomeController {
  final HomeRepository repository;

  HomeController(this.repository);

  List<DashboardStat> get stats =>
      repository.dashboardStats();

  List<HomeUpdate> get updates =>
      repository.latestUpdates();
}