import 'package:flutter/foundation.dart';
import 'home_model.dart';
import 'home_repository.dart';

class HomeController extends ChangeNotifier {
  final HomeRepository repository;

  HomeController(this.repository);

  List<DashboardStat> get stats => repository.dashboardStats();

  List<LatestUpdate> updates = [];

  bool isLoadingUpdates = false;

  Future<void> loadUpdates() async {
    isLoadingUpdates = true;
    notifyListeners();

    updates = await repository.getLatestUpdates();

    isLoadingUpdates = false;
    notifyListeners();
  }
}
