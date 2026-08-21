import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvk_grievance/features/home/home_remote_data_source.dart';

import 'home_model.dart';
import 'home_repository.dart';

class HomeController extends ChangeNotifier {
  final HomeRepository repository;

  HomeController(this.repository) {
    debugPrint('HOME CONTROLLER: CONSTRUCTOR CALLED');

    loadHomeData();
  }

  // =======================
  // DASHBOARD
  // =======================

  DashboardData? dashboard;

  bool isLoadingDashboard = false;

  String? dashboardErrorMessage;

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
    debugPrint('HOME CONTROLLER: loadHomeData() START');

    final prefs = await SharedPreferences.getInstance();

    debugPrint('HOME CONTROLLER: SharedPreferences obtained');

    // TEMPORARY DEBUG:
    // Print all keys currently stored locally.
    final keys = prefs.getKeys();

    debugPrint('HOME CONTROLLER: SharedPreferences keys=$keys');

    for (final key in keys) {
      final value = prefs.get(key);

      debugPrint('HOME STORAGE: key=$key value=$value');
    }

    // Try the expected userId key first.
    String? userId = prefs.getString('userId');

    // Also try common alternatives.
    userId ??= prefs.getString('user_id');
    userId ??= prefs.getString('userid');
    userId ??= prefs.getString('USER_ID');
    userId ??= prefs.getString('loggedInUserId');

    debugPrint('HOME CONTROLLER: FINAL userId=$userId');

    await Future.wait([
      loadAlerts(),
      loadLatestContents(),
      loadDashboard(userId: userId ?? ''),
    ]);

    debugPrint('HOME CONTROLLER: loadHomeData() COMPLETE');
  }

  // =======================
  // DASHBOARD
  // =======================

  Future<void> loadDashboard({required String userId}) async {
    debugPrint('HOME CONTROLLER: loadDashboard() userId=$userId');

    if (userId.trim().isEmpty) {
      debugPrint('HOME CONTROLLER: userId is EMPTY');

      dashboard = null;

      dashboardErrorMessage = 'User ID not found. Unable to load dashboard.';

      notifyListeners();
      return;
    }

    isLoadingDashboard = true;
    dashboardErrorMessage = null;

    notifyListeners();

    try {
      debugPrint('HOME CONTROLLER: Calling repository.getDashboard()');

      final result = await repository.getDashboard(userId: userId);

      dashboard = result;

      dashboardErrorMessage = null;

      debugPrint('HOME CONTROLLER: Dashboard API SUCCESS');
    } catch (error) {
      dashboard = null;

      dashboardErrorMessage = _errorMessage(
        error,
        fallback: 'Unable to load dashboard.',
      );

      debugPrint('HOME CONTROLLER: Dashboard API ERROR=$error');
    } finally {
      isLoadingDashboard = false;

      notifyListeners();
    }
  }

  // =======================
  // ALERTS
  // =======================

  Future<void> loadAlerts() async {
    debugPrint('HOME CONTROLLER: loadAlerts() START');

    isLoadingAlerts = true;
    alertErrorMessage = null;

    notifyListeners();

    try {
      debugPrint('HOME CONTROLLER: Calling repository.getActiveAlerts()');

      final result = await repository.getActiveAlerts();

      alerts = result;

      alertErrorMessage = null;

      debugPrint('HOME CONTROLLER: Alerts API SUCCESS count=${alerts.length}');
    } catch (error) {
      alerts = [];

      alertErrorMessage = _errorMessage(
        error,
        fallback: 'Unable to load breaking news.',
      );

      debugPrint('HOME CONTROLLER: Alerts API ERROR=$error');
    } finally {
      isLoadingAlerts = false;

      notifyListeners();
    }
  }

  // =======================
  // LATEST CONTENT
  // =======================

  Future<void> loadLatestContents() async {
    debugPrint('HOME CONTROLLER: loadLatestContents() START');

    isLoadingContents = true;
    contentErrorMessage = null;

    notifyListeners();

    try {
      debugPrint('HOME CONTROLLER: Calling repository.getLatestContents()');

      final result = await repository.getLatestContents(limit: 5);

      contents = result;

      contentErrorMessage = null;

      debugPrint(
        'HOME CONTROLLER: Content API SUCCESS count=${contents.length}',
      );
    } catch (error) {
      contents = [];

      contentErrorMessage = _errorMessage(
        error,
        fallback: 'Unable to load latest updates.',
      );

      debugPrint('HOME CONTROLLER: Content API ERROR=$error');
    } finally {
      isLoadingContents = false;

      notifyListeners();
    }
  }

  // =======================
  // REFRESH
  // =======================

  Future<void> refresh() async {
    debugPrint('HOME CONTROLLER: refresh()');

    await loadHomeData();
  }

  // =======================
  // ERROR MESSAGE
  // =======================

  String _errorMessage(Object error, {required String fallback}) {
    if (error is HomeApiException) {
      return error.message;
    }

    return fallback;
  }
}
