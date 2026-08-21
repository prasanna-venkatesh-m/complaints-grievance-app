import 'package:flutter/foundation.dart';
import 'package:tvk_grievance/features/home/home_remote_data_source.dart';

import 'home_model.dart';
import 'home_repository.dart';

class HomeController extends ChangeNotifier {
  final HomeRepository repository;

  HomeController(this.repository) {
    loadHomeData();
  }

  // =======================
  // DASHBOARD STATS
  // =======================

  List<DashboardStat> get stats {
    return repository.dashboardStats();
  }

  // =======================
  // ALERTS
  // =======================

  List<Alert> alerts = [];

  bool isLoadingAlerts = false;

  String? alertErrorMessage;

  // =======================
  // LATEST CONTENT
  // =======================

  List<Content> contents = [];

  bool isLoadingContents = false;

  String? contentErrorMessage;

  // =======================
  // INITIAL LOAD
  // =======================

  Future<void> loadHomeData() async {
    await Future.wait([
      loadAlerts(),
      loadLatestContents(),
    ]);
  }

  // =======================
  // ALERTS
  // =======================

  Future<void> loadAlerts() async {
    isLoadingAlerts = true;
    alertErrorMessage = null;

    notifyListeners();

    try {
      final result = await repository.getActiveAlerts();

      alerts = result;
      alertErrorMessage = null;
    } catch (error) {
      alerts = [];

      alertErrorMessage = _errorMessage(
        error,
        fallback: 'Unable to load breaking news.',
      );
    } finally {
      isLoadingAlerts = false;

      notifyListeners();
    }
  }

  // =======================
  // LATEST CONTENT
  // =======================

  Future<void> loadLatestContents() async {
    isLoadingContents = true;
    contentErrorMessage = null;

    notifyListeners();

    try {
      final result = await repository.getLatestContents(
        limit: 5,
      );

      contents = result;
      contentErrorMessage = null;
    } catch (error) {
      contents = [];

      contentErrorMessage = _errorMessage(
        error,
        fallback: 'Unable to load latest updates.',
      );
    } finally {
      isLoadingContents = false;

      notifyListeners();
    }
  }

  // =======================
  // REFRESH
  // =======================

  Future<void> refresh() async {
    await loadHomeData();
  }

  String _errorMessage(
    Object error, {
    required String fallback,
  }) {
    if (error is HomeApiException) {
      return error.message;
    }

    return fallback;
  }
}